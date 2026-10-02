-- JAPAN LIFE GUIDE
-- 비밀번호 변경·계정 복구용 인증 저장 구조 추가
-- 대상: Oracle 11g XE / 프로젝트용 일반 계정
-- 기존 테이블과 데이터를 삭제하지 않습니다.
-- 재실행 시 이미 존재하는 객체는 건너뜁니다.

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_tables
     WHERE table_name = 'JL_PASSWORD_RESET';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE '
            CREATE TABLE JL_PASSWORD_RESET (
                id NUMBER(19) PRIMARY KEY,
                member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),
                code_hash VARCHAR2(128) NOT NULL,
                expires_at TIMESTAMP NOT NULL,
                sent_at TIMESTAMP NOT NULL,
                verified_at TIMESTAMP,
                attempt_count NUMBER(5) DEFAULT 0 NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                CONSTRAINT jl_pr_attempt_ck CHECK (attempt_count >= 0)
            )';
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM user_indexes
     WHERE index_name = 'JL_PASSWORD_RESET_MEMBER_IX';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX jl_password_reset_member_ix ON JL_PASSWORD_RESET (member_id)';
    END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM user_sequences
     WHERE sequence_name = 'JL_PASSWORD_RESET_SEQ';
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE jl_password_reset_seq START WITH 1 INCREMENT BY 1';
    END IF;
END;
/

COMMIT;

SELECT table_name
  FROM user_tables
 WHERE table_name = 'JL_PASSWORD_RESET';

SELECT sequence_name
  FROM user_sequences
 WHERE sequence_name = 'JL_PASSWORD_RESET_SEQ';
