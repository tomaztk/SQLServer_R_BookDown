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
CREATE OR ALTER  PROCEDURE [dbo].[Select2MD]
/*
Author: Tomaz Kastrun
Date: 08.Nov.2021
Description:
	Turns resultset of selected table into Markdown

Usage:
	EXEC dbo.select2MD
		@table_name = 'TestForMD'
	   ,@schema_name = 'dbo'

ChangeLog:
	- 

ToDO:
	- data types and left/right alignment
	- line breaks - OK

*/


    @table_name VARCHAR(200)
    ,@schema_name VARCHAR(20)
AS 
BEGIN

	SET NOCOUNT ON;

    -- get the columns of the table
        SELECT 
            c.Column_name
            ,c.Ordinal_position
            ,c.is_nullable
            ,c.Data_Type
        
        INTO  #temp
        
        FROM INFORMATION_SCHEMA.TABLES AS  t
        JOIN INFORMATION_SCHEMA.COLUMNS AS c 
        ON t.table_name = c.table_name
        AND t.table_schema = c.table_schema
        AND t.table_Catalog = c.table_Catalog
        WHERE
        t.table_type = 'BASE TABLE'
        AND t.Table_name = @table_name
        AND t.table_schema = @schema_name

            DECLARE @MD NVARCHAR(MAX)

            -- Title
            DECLARE @title NVARCHAR(MAX) = (SELECT '##Result for table: _**' + CAST(@table_name AS NVARCHAR(MAX)) + '**_
            ###SchemaName: _'+CAST(@schema_name AS NVARCHAR(MAX)) +'_')


            -- header |name |name2 |name3 |name4 |name5 |name6 
            DECLARE @header VARCHAR(MAX)

            SELECT @header = COALESCE(@header + '**|**', '') + column_name 
            FROM #temp
            ORDER BY Ordinal_position ASC
            SELECT @header = '|**' + @header + '**|'


            -- delimiter |-- |-- |-- |-- |-- |-- 
            DECLARE @nof_columns INT = (SELECT MAX(Ordinal_position) FROM #temp)
            DECLARE @firstLine NVARCHAR(MAX) = (SELECT  REPLICATE('|---',@nof_columns) + '|')  


            SET @MD = @title +CHAR(10) + @header + CHAR(13) + CHAR(10) + @firstLine  + CHAR(10)

            -- body
            DECLARE @body NVARCHAR(MAX)
            SET @body = 'SELECT
            ''|'' + CAST(' 

            DECLARE @i INT = 1

            WHILE @i <= @nof_columns
            BEGIN
                DECLARE @w VARCHAR(1000) =  (SELECT column_name FROM #temp WHERE Ordinal_position = @i)
                    SET @body = @body + @w + ' AS VARCHAR(MAX))+ ''|'' + CAST( '
                SET @i = @i + 1
            END

            SET @body  = (SELECT SUBSTRING(@body,1, LEN(@body)-8))
            SET @body = @body + ' FROM ' + @table_name


            DECLARE @bodyTable TABLE(MD VARCHAR(MAX))
            INSERT INTO @BodyTable
            EXEC sp_executesql @body


            DECLARE @body2 NVARCHAR(MAX)
            SELECT @body2 = COALESCE(@body2 + ' ', ' ') + MD + CHAR(10) 
            FROM @bodyTable


            SET @MD = @MD + @body2
            SELECT @MD


END;
GO


EXEC dbo.select2MD
@table_name = 'TestForMD'
,@schema_name = 'dbo'


SELECT 
    c.Column_name
    ,c.Ordinal_position
    ,c.is_nullable
    ,c.Data_Type

INTO #temp

FROM INFORMATION_SCHEMA.TABLES AS  t
JOIN INFORMATION_SCHEMA.COLUMNS AS c 
ON t.table_name = c.table_name
AND t.table_schema = c.table_schema
AND t.table_Catalog = c.table_Catalog
WHERE
t.table_type = 'BASE TABLE'
AND t.Table_name = 'TestForMD'


DECLARE @MD NVARCHAR(MAX)

-- Title
DECLARE @title NVARCHAR(MAX) = SELECT '##Result for table: _**' + CAST(@table_name AS NVARCHAR(MAX)) + '**_
###SchemaName: _'+CAST(@schema_name AS NVARCHAR(MAX)) +'_'


-- header |name |name2 |name3 |name4 |name5 |name6 
DECLARE @header VARCHAR(MAX)

SELECT @header = COALESCE(@header + '**|**', '') + column_name 
FROM #temp
ORDER BY Ordinal_position ASC
SELECT @header = '|**' + @header + '**|'


-- delimiter |-- |-- |-- |-- |-- |-- 
DECLARE @nof_columns INT = (SELECT MAX(Ordinal_position) FROM #temp)
DECLARE @firstLine NVARCHAR(MAX) = (SELECT  REPLICATE('|---',@nof_columns) + '|')  


SET @MD = @header + CHAR(13) + @firstLine

SELECT @MD

-- body
DECLARE @body NVARCHAR(MAX)
SET @body = 'SELECT
 ''|'' + CAST(' 

--PRINT @body
DECLARE @i INT = 1

WHILE @i <= 6 --@nof_columns
BEGIN
    DECLARE @w VARCHAR(1000) =  (SELECT column_name FROM #temp WHERE Ordinal_position = @i)
    --SELECT @w
        SET @body = @body + @w + ' AS VARCHAR(MAX))+ ''|'' + CAST( '
    SET @i = @i + 1
END

SET @body  = (SELECT SUBSTRING(@body,1, LEN(@body)-8))
SET @body = @body + ' from ' + 'testforMD' --@table_name

DECLARE @bodyTable TABLe(MD VARCHAR(MAX))
INSERT INTO @BodyTable
EXEC sp_executesql @body

SELECT * FROM @bodyTable

DECLARE @body2 NVARCHAR(MAX)
SELECT @body2 = COALESCE(@body2 + ' ', ' ') + MD 
FROM @bodyTable

SELECT @Body2

select 
 '|' + CAST( id AS VARCHAR(MAX))+ '|' +
CAST(name AS VARCHAR(MAX)) + '|' +
CAST( age AS VARCHAR(MAX))+ '|' +
CAST( salary AS VARCHAR(MAX))+ '|' +
CAST( height AS VARCHAR(MAX))+ '|' +
CAST( MaritalStatus AS VARCHAR(MAX))+ '|'
 from dbo.testforMD


