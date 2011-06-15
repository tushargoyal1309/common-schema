-- 
-- InnoDB tables where no PRIMARY KEY is defined
-- 
CREATE OR REPLACE
ALGORITHM = UNDEFINED
SQL SECURITY INVOKER
VIEW no_pk_innodb_tables AS
  SELECT 
    TABLES.TABLE_SCHEMA,
    TABLES.TABLE_NAME,
    TABLES.ENGINE
  FROM 
    INFORMATION_SCHEMA.TABLES 
    LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS USING(TABLE_SCHEMA, TABLE_NAME)
  WHERE 
    TABLES.ENGINE='InnoDB'
  GROUP BY
    TABLES.TABLE_SCHEMA,
    TABLES.TABLE_NAME
  HAVING
    IFNULL(
      SUM(CONSTRAINT_TYPE='PRIMARY KEY'),
      0
    ) = 0
;

