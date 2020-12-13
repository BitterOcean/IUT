--Q1
select *
from ([AdventureWorks2012].Sales.SalesOrderHeader inner join [AdventureWorks2012].Sales.[SalesTerritory] ON [AdventureWorks2012].Sales.SalesOrderHeader.TerritoryID=[AdventureWorks2012].Sales.[SalesTerritory].TerritoryID)
where ([status]=5 and [TotalDue]>=100000 and [TotalDue]<=500000 and (Name='France' OR [Group]='North America'));

--Q2
select [SalesOrderID],[CustomerID],[TotalDue],[AdventureWorks2012].Sales.SalesOrderHeader.[ModifiedDate],Name
from ([AdventureWorks2012].Sales.SalesOrderHeader inner join [AdventureWorks2012].Sales.[SalesTerritory] ON [AdventureWorks2012].Sales.SalesOrderHeader.TerritoryID=[AdventureWorks2012].Sales.[SalesTerritory].TerritoryID);

--Q3
with mar([ProductID],SUMOrderQty,TerritoryID) as 
(select [ProductID],TerritoryID,sum(OrderQty) 
from [AdventureWorks2012].Sales.SalesOrderHeader inner join [AdventureWorks2012].Sales.SalesOrderDetail
 ON [AdventureWorks2012].Sales.SalesOrderHeader.SalesOrderID=[AdventureWorks2012].Sales.SalesOrderDetail.SalesOrderID
 group by [ProductID],TerritoryID)

select s.[ProductID], MAX(s.SUMOrderQty), s.TerritoryID
from mar as s,mar as t
group by(s.[ProductID])
having(s.[ProductID]=t.[ProductID] and s.TerritoryID=t.TerritoryID);


--Q4
create table NAmerica_Sales(
[SalesOrderID] int primary key,
[CustomerID] int,
[TerritoryID] int,
name_ varchar(30)
);
insert into NAmerica_Sales([SalesOrderID],[CustomerID],[TerritoryID],name_) values (
select [SalesOrderID],[CustomerID],[TerritoryID],name
from ([AdventureWorks2012].Sales.SalesOrderHeader inner join [AdventureWorks2012].Sales.[SalesTerritory] ON [AdventureWorks2012].Sales.SalesOrderHeader.TerritoryID=[AdventureWorks2012].Sales.[SalesTerritory].TerritoryID)
where ([status]=5 and [TotalDue]>=100000 and [TotalDue]<=500000 and [Group]='North America')))