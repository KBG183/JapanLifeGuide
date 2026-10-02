-- 전체 설치 SQL 실행 후 실제 생성 결과를 확인합니다.
SELECT id, title, published FROM JL_PROCEDURE ORDER BY id;
SELECT COUNT(*) AS document_count FROM JL_DOCUMENT;
SELECT COUNT(*) AS source_count FROM JL_SOURCE;
SELECT COUNT(*) AS procedure_count FROM JL_PROCEDURE WHERE published = 'Y';
SELECT language_code, COUNT(*) AS translation_count FROM JL_PROCEDURE_I18N GROUP BY language_code ORDER BY language_code;
SELECT p.title, d.name, d.requirement, d.condition_text
FROM JL_PROCEDURE p JOIN JL_DOCUMENT d ON d.procedure_id = p.id
ORDER BY p.id, d.display_order;
