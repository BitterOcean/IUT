 ----Q3
 --EXEC sp_configure 'xp_cmdshell', 1
 --GO
 ---- To update the currently configured value for this feature.
 --RECONFIGURE
 --GO

 EXEC xp_cmdshell 'bcp "SELECT TerritoryID,Name FROM AdventureWorks2012.Sales.SalesTerritory" queryout "D:\MaryamEXCEL\OUTPUT_FILE.txt" -T -c -t,'