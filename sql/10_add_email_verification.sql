-- JAPAN LIFE GUIDE
-- 회원 이메일 및 이메일 인증 저장 구조 추가
-- 대상: Oracle 11g XE / 프로젝트용 일반 계정
-- 기존 테이블과 데이터를 삭제하지 않습니다.
-- 재실행 시 이미 존재하는 컬럼·제약조건·객체는 건너뜁니다.

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_tab_columns
     WHERE table_name = 'JL_MEMBER'
       AND column_name = 'EMAIL';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD (email VARCHAR2(254))';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_tab_columns
     WHERE table_name = 'JL_MEMBER'
       AND column_name = 'EMAIL_VERIFIED';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD (email_verified CHAR(1) DEFAULT ''N'' NOT NULL)';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_constraints
     WHERE table_name = 'JL_MEMBER'
       AND constraint_name = 'JL_MEMBER_EMAIL_VERIFIED_CK';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD CONSTRAINT jl_member_email_verified_ck CHECK (email_verified IN (''Y'', ''N''))';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_constraints
     WHERE table_name = 'JL_MEMBER'
       AND constraint_name = 'JL_MEMBER_EMAIL_UQ';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD CONSTRAINT jl_member_email_uq UNIQUE (email)';
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_tables
     WHERE table_name = 'JL_EMAIL_VERIFICATION';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE '
            CREATE TABLE JL_EMAIL_VERIFICATION (
                id NUMBER(19) PRIMARY KEY,
                email VARCHAR2(254) NOT NULL,
                code_hash VARCHAR2(128) NOT NULL,
                expires_at TIMESTAMP NOT NULL,
                sent_at TIMESTAMP NOT NULL,
                verified_at TIMESTAMP,
                attempt_count NUMBER(5) DEFAULT 0 NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                CONSTRAINT jl_ev_attempt_ck CHECK (attempt_count >= 0)
            )';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_indexes
     WHERE index_name = 'JL_EMAIL_VERIFICATION_EMAIL_IX';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX jl_email_verification_email_ix ON JL_EMAIL_VERIFICATION (email)';
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_sequences
     WHERE sequence_name = 'JL_EMAIL_VERIFICATION_SEQ';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE jl_email_verification_seq START WITH 1 INCREMENT BY 1';
    END IF;
END;
/

COMMIT;

-- 확인
SELECT column_name, data_type, nullable
  FROM user_tab_columns
 WHERE table_name = 'JL_MEMBER'
 ORDER BY column_id;

SELECT constraint_name, constraint_type, status
  FROM user_constraints
 WHERE table_name IN ('JL_MEMBER', 'JL_EMAIL_VERIFICATION')
 ORDER BY table_name, constraint_name;
