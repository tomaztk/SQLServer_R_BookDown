--CREATE DATABASE TestMD;

USE TestMD;

/*

CREATE TABLE dbo.TestForMD
( ID INT IDENTITy(1,1)
,Name VARCHAR(100)
,Age INT NOT NULL
,Salary MONEY
,Height DECIMAL(10,2)
,MaritalStatus CHAR(1)
)

INSERT INTO dbo.TestForMD
SELECT 'Tim', 31, 300, 191.2, 1 UNION ALL
SELECT 'Tom', 21, 400, 181.87, 2 UNION ALL
SELECT 'Tam', 51, 500, 176.54, 3 


*/


SELECT * FROM TestForMD 

-- 1. get the columns of the query result
-- 2. get the data types
-- 3. add the headers and remove any annotations (SET NOCOUNT OFF and similar)
-- 4. save the results to md file
-- 5. open the file


-- Select statement
CREATE OR ALTER PROCEDURE dbo.Select2MD
    @table_name VARCHAR(200)
    ,@schema_name VARCHAR(20)
AS 
BEGIN
    -- get the columns of the table
        SELECT 
            c.Column_name
            ,c.Ordinal_position
            ,c.is_nullable
            ,c.Data_Type
        FROM INFORMATION_SCHEMA.TABLES AS  t
        JOIN INFORMATION_SCHEMA.COLUMNS AS c 
        ON t.table_name = c.table_name
        AND t.table_schema = c.table_schema
        AND t.table_Catalog = c.table_Catalog
        WHERE
        t.table_type = 'BASE TABLE'
        AND t.Table_name = @table_name
        AND t.table_schema = @schema_name


END;


EXEC dbo.select2MD
@table_name = 'TestForMD'
,@schema_name = 'dbo'


SELECT 
    c.Column_name
    ,c.Ordinal_position
    ,c.is_nullable
    ,c.Data_Type
FROM INFORMATION_SCHEMA.TABLES AS  t
JOIN INFORMATION_SCHEMA.COLUMNS AS c 
ON t.table_name = c.table_name
AND t.table_schema = c.table_schema
AND t.table_Catalog = c.table_Catalog
WHERE
t.table_type = 'BASE TABLE'
AND t.Table_name = 'TestForMD'

