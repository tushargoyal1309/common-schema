-- 
-- Tables' charsets and collations
-- 
CREATE OR REPLACE
ALGORITHM = MERGE
SQL SECURITY INVOKER
VIEW table_charset AS
  SELECT 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    CHARACTER_SET_NAME, 
    TABLE_COLLATION
  FROM 
    INFORMATION_SCHEMA.TABLES
    INNER JOIN INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY 
      ON (TABLES.TABLE_COLLATION = COLLATION_CHARACTER_SET_APPLICABILITY.COLLATION_NAME)
  WHERE 
    TABLE_SCHEMA NOT IN ('mysql', 'INFORMATION_SCHEMA', 'performance_schema')
;
