-- JAPAN LIFE GUIDE 데이터 추가·수정 예제
-- 이 파일의 변경 명령은 모두 주석 처리되어 있어 그대로 F5를 눌러도 데이터가 바뀌지 않습니다.
-- 사용할 부분만 복사한 뒤 값과 ID를 확인하고, 주석 기호(--)를 제거하여 실행하세요.
-- 일본어·한국어 문자열은 N'문자열' 형식을 사용합니다.

-- ================================================================
-- 1. 현재 데이터와 다음 ID 확인
-- ================================================================

SELECT id, name, parent_id
FROM JL_REGION
ORDER BY id;

SELECT id, name
FROM JL_CATEGORY
ORDER BY id;

SELECT id, title, situation, published, revision, updated_at
FROM JL_PROCEDURE
ORDER BY id;

SELECT jl_procedure_seq.NEXTVAL AS next_procedure_id
FROM DUAL;

-- 주의: NEXTVAL을 조회하면 시퀀스 번호가 실제로 한 번 증가합니다.
-- 번호가 중간에 비어도 오류가 아니며, PK는 연속 번호일 필요가 없습니다.

-- ================================================================
-- 2. 새 절차 추가 예제
-- ================================================================
-- 먼저 실제로 존재하는 region_id와 category_id를 위 SELECT로 확인하세요.
-- 아래 예제는 실행되지 않도록 주석 처리되어 있습니다.

-- INSERT INTO JL_PROCEDURE (
--     id, region_id, category_id, title, summary, eligibility,
--     deadline_text, method_text, notice, situation,
--     published, revision, updated_at
-- ) VALUES (
--     jl_procedure_seq.NEXTVAL,
--     2,
--     1,
--     N'새 절차 제목',
--     N'목록에 표시할 짧은 설명',
--     N'이 절차를 이용할 수 있는 대상',
--     N'신청 기한 설명',
--     N'신청 방법 설명',
--     N'주의사항',
--     'DOMESTIC',
--     'N',
--     1,
--     CURRENT_TIMESTAMP
-- );
-- COMMIT;

-- situation은 해외 전입이면 ABROAD, 일본 국내 이동이면 DOMESTIC입니다.
-- 작성 중에는 published를 N으로 두고 확인이 끝난 뒤 Y로 바꾸세요.

-- ================================================================
-- 3. 기존 절차 수정 예제
-- ================================================================
-- WHERE id의 숫자를 반드시 확인하세요.
-- 안내 내용을 수정할 때 revision도 1 증가시킵니다.

-- UPDATE JL_PROCEDURE
-- SET title = N'수정한 제목',
--     summary = N'수정한 설명',
--     revision = revision + 1,
--     updated_at = CURRENT_TIMESTAMP
-- WHERE id = 1;
-- COMMIT;

-- ================================================================
-- 4. 화면 공개·비공개 변경 예제
-- ================================================================

-- UPDATE JL_PROCEDURE
-- SET published = 'Y',
--     updated_at = CURRENT_TIMESTAMP
-- WHERE id = 1000;
-- COMMIT;

-- UPDATE JL_PROCEDURE
-- SET published = 'N',
--     updated_at = CURRENT_TIMESTAMP
-- WHERE id = 1000;
-- COMMIT;

-- ================================================================
-- 5. 준비 서류 추가 예제
-- ================================================================
-- procedure_id는 실제 절차 ID, display_order는 같은 절차 안에서 중복되면 안 됩니다.
-- requirement는 REQUIRED 또는 CONDITIONAL만 사용할 수 있습니다.

-- INSERT INTO JL_DOCUMENT (
--     id, procedure_id, name, requirement, condition_text, display_order
-- ) VALUES (
--     jl_document_seq.NEXTVAL,
--     1000,
--     N'준비 서류 이름',
--     'CONDITIONAL',
--     N'이 서류가 필요한 조건',
--     1
-- );
-- COMMIT;

-- ================================================================
-- 6. 진행 단계 추가 예제
-- ================================================================

-- INSERT INTO JL_STEP (
--     id, procedure_id, step_no, title, description
-- ) VALUES (
--     jl_step_seq.NEXTVAL,
--     1000,
--     1,
--     N'진행 단계 제목',
--     N'이 단계에서 해야 하는 일'
-- );
-- COMMIT;

-- ================================================================
-- 7. 공식 출처 추가 예제
-- ================================================================
-- checked_on은 직접 확인한 날짜입니다.
-- updated_on을 확인할 수 없으면 NULL을 사용하세요.

-- INSERT INTO JL_SOURCE (
--     id, procedure_id, title, url, checked_on, updated_on
-- ) VALUES (
--     jl_source_seq.NEXTVAL,
--     1000,
--     N'공식 페이지 제목',
--     'https://example.invalid/replace-with-official-url',
--     DATE '2026-09-28',
--     NULL
-- );
-- COMMIT;

-- ================================================================
-- 8. COMMIT 전 변경 내용 확인과 취소 예제
-- ================================================================
-- UPDATE 또는 INSERT 뒤 COMMIT 전이라면 아래처럼 확인할 수 있습니다.

-- SELECT * FROM JL_PROCEDURE WHERE id = 1000;

-- 변경이 잘못되었다면 COMMIT 대신 아래 명령을 실행합니다.
-- ROLLBACK;

-- 이미 COMMIT한 변경은 ROLLBACK으로 되돌릴 수 없습니다.
