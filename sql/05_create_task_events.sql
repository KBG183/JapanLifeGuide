-- 05: 개인 준비 일정 캘린더
-- 기존 JL_* 데이터를 삭제하거나 초기화하지 않습니다.
-- 기존 Oracle 설치가 완료된 계정에서 한 번만 실행하세요.

CREATE TABLE JL_USER_TASK_EVENT (
    id NUMBER(19) PRIMARY KEY,
    task_id NUMBER(19) NOT NULL REFERENCES JL_USER_TASK(id),
    member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),
    event_date DATE NOT NULL,
    title NVARCHAR2(200) NOT NULL,
    memo NVARCHAR2(1000),
    completed CHAR(1) DEFAULT 'N' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jl_task_event_completed_ck CHECK (completed IN ('Y','N'))
);

CREATE INDEX jl_task_event_member_date_ix ON JL_USER_TASK_EVENT(member_id, event_date);
CREATE SEQUENCE jl_user_task_event_seq START WITH 1000 INCREMENT BY 1;
COMMIT;
