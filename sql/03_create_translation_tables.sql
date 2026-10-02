-- 03: 다국어 콘텐츠 테이블
-- 기존 JL_* 테이블과 일본어 원문은 유지합니다.
-- Oracle SQL Developer에서 SOLO 계정으로 최초 1회 실행하세요.
-- 이 파일은 기존 테이블을 삭제하거나 수정하지 않습니다.

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

CREATE INDEX jl_proc_i18n_lang_ix ON JL_PROCEDURE_I18N(language_code);
CREATE INDEX jl_doc_i18n_lang_ix ON JL_DOCUMENT_I18N(language_code);
CREATE INDEX jl_step_i18n_lang_ix ON JL_STEP_I18N(language_code);
CREATE INDEX jl_source_i18n_lang_ix ON JL_SOURCE_I18N(language_code);
CREATE INDEX jl_office_i18n_lang_ix ON JL_OFFICE_I18N(language_code);

COMMIT;
