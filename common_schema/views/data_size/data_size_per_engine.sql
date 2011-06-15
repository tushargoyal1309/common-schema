-- 
-- Dataset size per engine
-- 
CREATE OR REPLACE
ALGORITHM = UNDEFINED
SQL SECURITY INVOKER
VIEW data_size_per_engine AS
  SELECT 
    ENGINE, 
    COUNT(*) AS count_tables,
    SUM(DATA_LENGTH) AS data_size,
    SUM(INDEX_LENGTH) AS index_size,
    SUM(DATA_LENGTH+INDEX_LENGTH) AS total_size,
    SUBSTRING_INDEX(GROUP_CONCAT(CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) ORDER BY DATA_LENGTH+INDEX_LENGTH DESC), ',', 1) AS largest_table,
    MAX(DATA_LENGTH+INDEX_LENGTH) AS largest_table_size
  FROM 
    INFORMATION_SCHEMA.TABLES
  WHERE 
    TABLE_SCHEMA NOT IN ('mysql', 'INFORMATION_SCHEMA', 'performance_schema')
    AND ENGINE IS NOT NULL
  GROUP BY 
    ENGINE
;
