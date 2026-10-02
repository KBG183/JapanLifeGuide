-- 01: 프로젝트 테이블 생성 / Oracle 11g XE 문법 기준 / UTF-8
-- SQL Developer에서 프로젝트용 일반 계정으로 접속하여 F5(스크립트 실행).
-- 최초 한 번 실행합니다. 기존 객체 삭제, 계정 생성, 데이터 초기화는 없습니다.
-- 같은 이름의 JL_ 객체가 있으면 실행을 멈추고 먼저 확인하세요.
-- Oracle DDL은 자동 COMMIT됩니다. 오류 후에는 실행 결과를 확인하세요.

CREATE TABLE JL_REGION (
    id NUMBER(19) PRIMARY KEY,
    parent_id NUMBER(19) REFERENCES JL_REGION(id),
    name NVARCHAR2(100) NOT NULL
);

CREATE TABLE JL_CATEGORY (
    id NUMBER(19) PRIMARY KEY,
    name NVARCHAR2(100) NOT NULL
);

CREATE TABLE JL_MEMBER (
    id NUMBER(19) PRIMARY KEY,
    login_id VARCHAR2(60) NOT NULL UNIQUE,
    password_hash VARCHAR2(255) NOT NULL,
    display_name NVARCHAR2(100) NOT NULL,
    role VARCHAR2(10) DEFAULT 'MEMBER' NOT NULL,
    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL,
    email VARCHAR2(254),
    email_verified CHAR(1) DEFAULT 'N' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jl_member_role_ck CHECK (role IN ('MEMBER','ADMIN')),
    CONSTRAINT jl_member_status_ck CHECK (status IN ('ACTIVE','INACTIVE')),
    CONSTRAINT jl_member_email_verified_ck CHECK (email_verified IN ('Y','N')),
    CONSTRAINT jl_member_email_uq UNIQUE (email)
);

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
);

CREATE INDEX jl_email_verification_email_ix ON JL_EMAIL_VERIFICATION (email);

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
);

CREATE INDEX jl_password_reset_member_ix ON JL_PASSWORD_RESET (member_id);

CREATE TABLE JL_PROCEDURE (
    id NUMBER(19) PRIMARY KEY,
    region_id NUMBER(19) NOT NULL REFERENCES JL_REGION(id),
    category_id NUMBER(19) NOT NULL REFERENCES JL_CATEGORY(id),
    title NVARCHAR2(200) NOT NULL,
    summary NVARCHAR2(600) NOT NULL,
    eligibility NVARCHAR2(1000) NOT NULL,
    deadline_text NVARCHAR2(500),
    method_text NVARCHAR2(500),
    notice NVARCHAR2(1000),
    situation VARCHAR2(20) NOT NULL,
    phase_code VARCHAR2(30) DEFAULT 'AFTER_ARRIVAL' NOT NULL,
    published CHAR(1) DEFAULT 'N' NOT NULL,
    revision NUMBER(10) DEFAULT 1 NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jl_proc_pub_ck CHECK (published IN ('Y','N')),
    CONSTRAINT jl_proc_situation_ck CHECK (situation IN ('ABROAD','DOMESTIC')),
    CONSTRAINT jl_proc_phase_ck CHECK (phase_code IN ('BEFORE_DEPARTURE','AFTER_ARRIVAL','DAILY_LIFE','WORK_OR_SCHOOL','MOVING_OR_UPDATE')),
    CONSTRAINT jl_proc_rev_ck CHECK (revision >= 1)
);

CREATE TABLE JL_DOCUMENT (
    id NUMBER(19) PRIMARY KEY,
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    name NVARCHAR2(200) NOT NULL,
    requirement VARCHAR2(12) NOT NULL,
    condition_text NVARCHAR2(1000),
    display_order NUMBER(5) NOT NULL,
    CONSTRAINT jl_doc_req_ck CHECK (requirement IN ('REQUIRED','CONDITIONAL')),
    CONSTRAINT jl_doc_cond_ck CHECK (requirement = 'REQUIRED' OR condition_text IS NOT NULL),
    CONSTRAINT jl_doc_order_uq UNIQUE (procedure_id, display_order)
);

CREATE TABLE JL_DOCUMENT_GUIDE (
    document_id NUMBER(19) NOT NULL REFERENCES JL_DOCUMENT(id),
    language_code VARCHAR2(5) NOT NULL,
    description NVARCHAR2(1000) NOT NULL,
    preparation_note NVARCHAR2(1000) NOT NULL,
    CONSTRAINT jl_doc_guide_pk PRIMARY KEY (document_id, language_code),
    CONSTRAINT jl_doc_guide_lang_ck CHECK (language_code IN ('ja','ko','en'))
);

CREATE TABLE JL_STEP (
    id NUMBER(19) PRIMARY KEY,
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    step_no NUMBER(5) NOT NULL,
    title NVARCHAR2(200) NOT NULL,
    description NVARCHAR2(1000) NOT NULL,
    CONSTRAINT jl_step_order_uq UNIQUE (procedure_id, step_no)
);

CREATE TABLE JL_SOURCE (
    id NUMBER(19) PRIMARY KEY,
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    title NVARCHAR2(200) NOT NULL,
    url VARCHAR2(1500) NOT NULL,
    checked_on DATE NOT NULL,
    updated_on DATE
);

CREATE TABLE JL_OFFICE (
    id NUMBER(19) PRIMARY KEY,
    name NVARCHAR2(200) NOT NULL,
    address NVARCHAR2(300),
    homepage_url VARCHAR2(1500) NOT NULL,
    note NVARCHAR2(1000)
);

CREATE TABLE JL_PROC_OFFICE (
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    office_id NUMBER(19) NOT NULL REFERENCES JL_OFFICE(id),
    PRIMARY KEY (procedure_id, office_id)
);

-- 회원별 준비 목록과 일정 관리용 테이블입니다.
CREATE TABLE JL_USER_TASK (
    id NUMBER(19) PRIMARY KEY,
    member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    saved_revision NUMBER(10) NOT NULL,
    saved_title NVARCHAR2(200) NOT NULL,
    status VARCHAR2(20) DEFAULT 'NOT_STARTED' NOT NULL,
    memo NVARCHAR2(1000),
    visit_date DATE,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jl_task_owner_uq UNIQUE (member_id, procedure_id),
    CONSTRAINT jl_task_status_ck CHECK (status IN ('NOT_STARTED','PREPARING','COMPLETED')),
    CONSTRAINT jl_task_rev_ck CHECK (saved_revision >= 1),
    CONSTRAINT jl_task_done_ck CHECK (
        (status = 'COMPLETED' AND completed_at IS NOT NULL) OR
        (status <> 'COMPLETED' AND completed_at IS NULL))
);

CREATE TABLE JL_USER_CHECK (
    id NUMBER(19) PRIMARY KEY,
    task_id NUMBER(19) NOT NULL REFERENCES JL_USER_TASK(id),
    document_name NVARCHAR2(200) NOT NULL,
    requirement VARCHAR2(12) NOT NULL,
    condition_text NVARCHAR2(1000),
    display_order NUMBER(5) NOT NULL,
    checked CHAR(1) DEFAULT 'N' NOT NULL,
    CONSTRAINT jl_check_value_ck CHECK (checked IN ('Y','N')),
    CONSTRAINT jl_check_req_ck CHECK (requirement IN ('REQUIRED','CONDITIONAL')),
    CONSTRAINT jl_check_order_uq UNIQUE (task_id, display_order)
);

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

CREATE INDEX jl_proc_region_ix ON JL_PROCEDURE(region_id);
CREATE INDEX jl_proc_category_ix ON JL_PROCEDURE(category_id);
CREATE INDEX jl_doc_guide_lang_ix ON JL_DOCUMENT_GUIDE(language_code);
CREATE INDEX jl_source_proc_ix ON JL_SOURCE(procedure_id);
CREATE INDEX jl_proc_office_ix ON JL_PROC_OFFICE(office_id);
CREATE INDEX jl_task_proc_ix ON JL_USER_TASK(procedure_id);
CREATE INDEX jl_task_event_member_date_ix ON JL_USER_TASK_EVENT(member_id, event_date);

CREATE TABLE JL_COMMUNITY_POST (
    id NUMBER(19) PRIMARY KEY, member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),
    category VARCHAR2(30) NOT NULL, title NVARCHAR2(200) NOT NULL, body NCLOB NOT NULL,
    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    view_count NUMBER(19) DEFAULT 0 NOT NULL,
    CONSTRAINT jl_community_post_category_ck CHECK (category IN ('ADMIN','HOME','STUDENT','WORK','MEETUP','GENERAL')),
    CONSTRAINT jl_community_post_status_ck CHECK (status IN ('ACTIVE','HIDDEN','DELETED'))
);
CREATE TABLE JL_COMMUNITY_COMMENT (
    id NUMBER(19) PRIMARY KEY, post_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_POST(id),
    member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), body NCLOB NOT NULL,
    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jl_community_comment_status_ck CHECK (status IN ('ACTIVE','HIDDEN','DELETED'))
);
CREATE TABLE JL_COMMUNITY_LIKE (post_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_POST(id), member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT jl_community_like_pk PRIMARY KEY(post_id,member_id));
CREATE TABLE JL_COMMUNITY_IMAGE (id NUMBER(19) PRIMARY KEY, post_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_POST(id), original_name NVARCHAR2(255) NOT NULL, stored_name VARCHAR2(255) NOT NULL, content_type VARCHAR2(100) NOT NULL, file_size NUMBER(19) NOT NULL, display_order NUMBER(5) NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT jl_community_image_size_ck CHECK(file_size > 0));
CREATE TABLE JL_COMMUNITY_REPORT (id NUMBER(19) PRIMARY KEY, post_id NUMBER(19) REFERENCES JL_COMMUNITY_POST(id), comment_id NUMBER(19) REFERENCES JL_COMMUNITY_COMMENT(id), member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), reason NVARCHAR2(500) NOT NULL, status VARCHAR2(20) DEFAULT 'OPEN' NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT jl_community_report_target_ck CHECK((post_id IS NOT NULL AND comment_id IS NULL) OR (post_id IS NULL AND comment_id IS NOT NULL)), CONSTRAINT jl_community_report_status_ck CHECK(status IN('OPEN','RESOLVED','REJECTED')));
CREATE TABLE JL_COMMUNITY_REPORT_AUDIT (
    id NUMBER(19) PRIMARY KEY,
    report_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_REPORT(id),
    admin_member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id),
    action_type VARCHAR2(20) NOT NULL,
    previous_report_status VARCHAR2(20) NOT NULL,
    new_report_status VARCHAR2(20) NOT NULL,
    target_type VARCHAR2(20) NOT NULL,
    previous_content_status VARCHAR2(20),
    new_content_status VARCHAR2(20),
    reason NVARCHAR2(1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT jcr_audit_action_ck CHECK (action_type IN ('REJECT','HIDE','DELETE')),
    CONSTRAINT jcr_audit_target_ck CHECK (target_type IN ('POST','COMMENT')),
    CONSTRAINT jcr_audit_status_ck CHECK (
        previous_report_status IN ('OPEN','RESOLVED','REJECTED')
        AND new_report_status IN ('OPEN','RESOLVED','REJECTED')
    )
);
CREATE TABLE JL_COMMUNITY_BOOKMARK (member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), post_id NUMBER(19) NOT NULL REFERENCES JL_COMMUNITY_POST(id), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT jl_community_bookmark_pk PRIMARY KEY (member_id, post_id));
CREATE TABLE JL_NOTIFICATION (id NUMBER(19) PRIMARY KEY, member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), notification_type VARCHAR2(40) NOT NULL, post_id NUMBER(19) REFERENCES JL_COMMUNITY_POST(id), comment_id NUMBER(19) REFERENCES JL_COMMUNITY_COMMENT(id), message NVARCHAR2(1000) NOT NULL, read_at TIMESTAMP NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL);
CREATE TABLE JL_MEMBER_AUDIT (id NUMBER(19) PRIMARY KEY, member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), admin_member_id NUMBER(19) NOT NULL REFERENCES JL_MEMBER(id), action_type VARCHAR2(40) NOT NULL, previous_status VARCHAR2(20), new_status VARCHAR2(20), reason NVARCHAR2(1000), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL);

CREATE TABLE JL_PROCEDURE_I18N (
    procedure_id NUMBER(19) NOT NULL REFERENCES JL_PROCEDURE(id),
    language_code VARCHAR2(5) NOT NULL,
    title NVARCHAR2(200) NOT NULL,
    summary NVARCHAR2(600) NOT NULL,
    eligibility NVARCHAR2(1000) NOT NULL,
    deadline_text NVARCHAR2(500),
    method_text NVARCHAR2(500),
    notice NVARCHAR2(1000),
    CONSTRAINT jl_proc_i18n_pk PRIMARY KEY (procedure_id, language_code),
    CONSTRAINT jl_proc_i18n_lang_ck CHECK (language_code IN ('ko','en'))
);
CREATE TABLE JL_DOCUMENT_I18N (
    document_id NUMBER(19) NOT NULL REFERENCES JL_DOCUMENT(id),
    language_code VARCHAR2(5) NOT NULL,
    name NVARCHAR2(200) NOT NULL,
    condition_text NVARCHAR2(1000),
    CONSTRAINT jl_doc_i18n_pk PRIMARY KEY (document_id, language_code),
    CONSTRAINT jl_doc_i18n_lang_ck CHECK (language_code IN ('ko','en'))
);
CREATE TABLE JL_STEP_I18N (
    step_id NUMBER(19) NOT NULL REFERENCES JL_STEP(id),
    language_code VARCHAR2(5) NOT NULL,
    title NVARCHAR2(200) NOT NULL,
    description NVARCHAR2(1000) NOT NULL,
    CONSTRAINT jl_step_i18n_pk PRIMARY KEY (step_id, language_code),
    CONSTRAINT jl_step_i18n_lang_ck CHECK (language_code IN ('ko','en'))
);
CREATE TABLE JL_SOURCE_I18N (
    source_id NUMBER(19) NOT NULL REFERENCES JL_SOURCE(id),
    language_code VARCHAR2(5) NOT NULL,
    title NVARCHAR2(200) NOT NULL,
    CONSTRAINT jl_source_i18n_pk PRIMARY KEY (source_id, language_code),
    CONSTRAINT jl_source_i18n_lang_ck CHECK (language_code IN ('ko','en'))
);
CREATE TABLE JL_OFFICE_I18N (
    office_id NUMBER(19) NOT NULL REFERENCES JL_OFFICE(id),
    language_code VARCHAR2(5) NOT NULL,
    name NVARCHAR2(200) NOT NULL,
    note NVARCHAR2(1000),
    CONSTRAINT jl_office_i18n_pk PRIMARY KEY (office_id, language_code),
    CONSTRAINT jl_office_i18n_lang_ck CHECK (language_code IN ('ko','en'))
);

-- 1~999는 초기 데이터용입니다. 새 레코드는 해당 시퀀스.NEXTVAL로 생성합니다.
CREATE SEQUENCE jl_region_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_category_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_member_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_email_verification_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE jl_password_reset_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE jl_procedure_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_document_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_step_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_source_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_office_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_user_task_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_user_check_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_user_task_event_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_community_post_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_community_comment_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_community_report_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_community_report_audit_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_community_image_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE jl_notification_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE jl_member_audit_seq START WITH 1 INCREMENT BY 1 NOCACHE;
