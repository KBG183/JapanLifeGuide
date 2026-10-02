-- Japan Life Guide
-- 커뮤니티 확장 기능용 SQL
-- 대상: Oracle 11g XE / 계정 SOLO
--
-- 목적:
--   1) 댓글 수정 시각 기록
--   2) 게시글 북마크
--   3) 사용자 알림
--   4) 관리자 회원 제재·감사 이력
--
-- 안전성:
--   - 기존 테이블과 기존 데이터는 삭제·초기화하지 않습니다.
--   - 객체·컬럼·인덱스·시퀀스가 없을 때만 추가합니다.
--   - 이 파일 자체는 여러 번 실행할 수 있도록 작성했습니다.
--   - 이 파일을 실행해도 기존 데이터의 상태나 내용은 변경하지 않습니다.

SET SERVEROUTPUT ON;

DECLARE
    v_count NUMBER;

    PROCEDURE add_column_if_missing(
        p_table_name  VARCHAR2,
        p_column_name VARCHAR2,
        p_definition  VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*) INTO v_count
          FROM USER_TAB_COLUMNS
         WHERE TABLE_NAME = UPPER(p_table_name)
           AND COLUMN_NAME = UPPER(p_column_name);

        IF v_count = 0 THEN
            EXECUTE IMMEDIATE
                'ALTER TABLE ' || p_table_name ||
                ' ADD (' || p_column_name || ' ' || p_definition || ')';
            DBMS_OUTPUT.PUT_LINE('ADDED COLUMN ' || p_table_name || '.' || p_column_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('EXISTS COLUMN ' || p_table_name || '.' || p_column_name);
        END IF;
    END;

    PROCEDURE create_table_if_missing(
        p_table_name VARCHAR2,
        p_ddl        VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*) INTO v_count
          FROM USER_TABLES
         WHERE TABLE_NAME = UPPER(p_table_name);

        IF v_count = 0 THEN
            EXECUTE IMMEDIATE p_ddl;
            DBMS_OUTPUT.PUT_LINE('CREATED TABLE ' || p_table_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('EXISTS TABLE ' || p_table_name);
        END IF;
    END;

    PROCEDURE create_sequence_if_missing(
        p_sequence_name VARCHAR2,
        p_ddl            VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*) INTO v_count
          FROM USER_SEQUENCES
         WHERE SEQUENCE_NAME = UPPER(p_sequence_name);

        IF v_count = 0 THEN
            EXECUTE IMMEDIATE p_ddl;
            DBMS_OUTPUT.PUT_LINE('CREATED SEQUENCE ' || p_sequence_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('EXISTS SEQUENCE ' || p_sequence_name);
        END IF;
    END;

    PROCEDURE create_index_if_missing(
        p_index_name VARCHAR2,
        p_ddl         VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*) INTO v_count
          FROM USER_INDEXES
         WHERE INDEX_NAME = UPPER(p_index_name);

        IF v_count = 0 THEN
            EXECUTE IMMEDIATE p_ddl;
            DBMS_OUTPUT.PUT_LINE('CREATED INDEX ' || p_index_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('EXISTS INDEX ' || p_index_name);
        END IF;
    END;
BEGIN
    -- 댓글 수정 기능에 사용할 수정 시각입니다.
    add_column_if_missing(
        'JL_COMMUNITY_COMMENT',
        'UPDATED_AT',
        'TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL'
    );

    -- 게시글 북마크: 회원별 게시글 중복 저장을 방지합니다.
    create_table_if_missing(
        'JL_COMMUNITY_BOOKMARK',
        'CREATE TABLE JL_COMMUNITY_BOOKMARK (' ||
        'member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),' ||
        'post_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_POST(id),' ||
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,' ||
        'CONSTRAINT jl_community_bookmark_pk PRIMARY KEY (member_id, post_id)' ||
        ')'
    );

    -- 사용자 알림: 댓글·댓글 반응·신고 처리 결과 등을 저장할 수 있습니다.
    create_sequence_if_missing(
        'JL_NOTIFICATION_SEQ',
        'CREATE SEQUENCE JL_NOTIFICATION_SEQ START WITH 1 INCREMENT BY 1 NOCACHE'
    );

    create_table_if_missing(
        'JL_NOTIFICATION',
        'CREATE TABLE JL_NOTIFICATION (' ||
        'id NUMBER(19) PRIMARY KEY,' ||
        'member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),' ||
        'notification_type VARCHAR2(40) NOT NULL,' ||
        'post_id NUMBER(19) REFERENCES JL_COMMUNITY_POST(id),' ||
        'comment_id NUMBER(19) REFERENCES JL_COMMUNITY_COMMENT(id),' ||
        'message NVARCHAR2(1000) NOT NULL,' ||
        'read_at TIMESTAMP NULL,' ||
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL' ||
        ')'
    );

    -- 관리자 회원 제재 및 상태 변경의 감사 이력입니다.
    create_sequence_if_missing(
        'JL_MEMBER_AUDIT_SEQ',
        'CREATE SEQUENCE JL_MEMBER_AUDIT_SEQ START WITH 1 INCREMENT BY 1 NOCACHE'
    );

    create_table_if_missing(
        'JL_MEMBER_AUDIT',
        'CREATE TABLE JL_MEMBER_AUDIT (' ||
        'id NUMBER(19) PRIMARY KEY,' ||
        'member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),' ||
        'admin_member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),' ||
        'action_type VARCHAR2(40) NOT NULL,' ||
        'previous_status VARCHAR2(20),' ||
        'new_status VARCHAR2(20),' ||
        'reason NVARCHAR2(1000),' ||
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL' ||
        ')'
    );

    create_index_if_missing(
        'JL_COMM_BOOKMARK_MEMBER_IX',
        'CREATE INDEX JL_COMM_BOOKMARK_MEMBER_IX ON JL_COMMUNITY_BOOKMARK(member_id, created_at DESC)'
    );

    create_index_if_missing(
        'JL_NOTIFICATION_MEMBER_IX',
        'CREATE INDEX JL_NOTIFICATION_MEMBER_IX ON JL_NOTIFICATION(member_id, read_at, created_at DESC)'
    );

    create_index_if_missing(
        'JL_MEMBER_AUDIT_MEMBER_IX',
        'CREATE INDEX JL_MEMBER_AUDIT_MEMBER_IX ON JL_MEMBER_AUDIT(member_id, created_at DESC)'
    );

    create_index_if_missing(
        'JL_MEMBER_AUDIT_ADMIN_IX',
        'CREATE INDEX JL_MEMBER_AUDIT_ADMIN_IX ON JL_MEMBER_AUDIT(admin_member_id, created_at DESC)'
    );

    DBMS_OUTPUT.PUT_LINE('COMMUNITY USER FEATURES SQL CHECK COMPLETE');
END;
/

COMMIT;

-- 실행 후 확인용 조회입니다. 데이터 변경은 하지 않습니다.
SELECT TABLE_NAME
  FROM USER_TABLES
 WHERE TABLE_NAME IN (
       'JL_COMMUNITY_BOOKMARK',
       'JL_NOTIFICATION',
       'JL_MEMBER_AUDIT'
 )
 ORDER BY TABLE_NAME;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE
  FROM USER_TAB_COLUMNS
 WHERE TABLE_NAME = 'JL_COMMUNITY_COMMENT'
   AND COLUMN_NAME = 'UPDATED_AT';

SELECT SEQUENCE_NAME
  FROM USER_SEQUENCES
 WHERE SEQUENCE_NAME IN ('JL_NOTIFICATION_SEQ', 'JL_MEMBER_AUDIT_SEQ')
 ORDER BY SEQUENCE_NAME;
