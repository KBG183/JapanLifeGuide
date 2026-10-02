-- JAPAN LIFE GUIDE
-- 관리자 회원 비활성화용 회원 상태 컬럼 추가
-- 대상: Oracle 11g XE / 프로젝트용 일반 계정
-- 기존 JL_MEMBER와 회원 데이터를 삭제하거나 초기화하지 않습니다.
-- 재실행 시 이미 존재하는 컬럼·제약조건은 건너뜁니다.

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_tab_columns
     WHERE table_name = 'JL_MEMBER'
       AND column_name = 'STATUS';

    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD (status VARCHAR2(20) DEFAULT ''ACTIVE'' NOT NULL)';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_constraints
     WHERE table_name = 'JL_MEMBER'
       AND constraint_name = 'JL_MEMBER_STATUS_CK';

    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE JL_MEMBER ADD CONSTRAINT jl_member_status_ck CHECK (status IN (''ACTIVE'', ''INACTIVE''))';
    END IF;
END;
/

COMMIT;

-- 실행 결과 확인
SELECT column_name, data_type, data_length, nullable, data_default
  FROM user_tab_columns
 WHERE table_name = 'JL_MEMBER'
   AND column_name = 'STATUS';

SELECT constraint_name, constraint_type, status
  FROM user_constraints
 WHERE table_name = 'JL_MEMBER'
   AND constraint_name = 'JL_MEMBER_STATUS_CK';

