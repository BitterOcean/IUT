--DELETE 
--FROM [Production].[ProductCopy]
--WHERE ProductID = 1

--UPDATE Production.ProductCopy
--SET MakeFlag = 1
--WHERE ProductID =2

UPDATE Production.ProductLogCopy
SET ModificationType = 'Inserted'
WHERE ProductID = 1