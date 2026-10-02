-- 읽기 전용 사전 확인. Oracle SQL Developer에서 실행하세요.
SELECT USER AS current_user FROM DUAL;
SELECT banner FROM v$version;
SELECT parameter, value FROM nls_database_parameters
WHERE parameter IN ('NLS_CHARACTERSET','NLS_NCHAR_CHARACTERSET');
SELECT object_name, object_type FROM user_objects
WHERE object_name LIKE 'JL\_%' ESCAPE '\'
ORDER BY object_type, object_name;
