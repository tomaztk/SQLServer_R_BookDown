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