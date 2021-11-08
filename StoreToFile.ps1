-- Store to file with Powershell
Invoke-Sqlcmd -ServerInstance "localhost" -Database "TestMD" -Query "EXEC dbo.select2MD @table_name = 'TestForMD' ,@schema_name = 'dbo'" | Export-Csv "d:\md\result2.md" -NoTypeInformation
