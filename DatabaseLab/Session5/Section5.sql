---Q1---
select [Name] , [Europe]  , [North America] , [Pacific]
from( select  Product.[Name] , SalesTerritory.[Group] , SalesOrderDetail.OrderQty
		 from
			Production.Product 
			inner join Sales.SalesOrderDetail on Product.ProductID=SalesOrderDetail.ProductID
			inner join Sales.SalesOrderHeader on SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID
			inner join Sales.SalesTerritory on SalesTerritory.TerritoryID=SalesOrderHeader.TerritoryID 
		) SourceTable
pivot (
		count(OrderQty)
		for [Group] in (Europe , [North America] ,  Pacific)
) as pvt

---Q2---
select PersonType , M , F
from (
		select PersonType , Person.BusinessEntityID , Gender
		from Person.Person inner join HumanResources.Employee on Person.BusinessEntityID=Employee.BusinessEntityID
		)as SourceTable
pivot(
		count(BusinessEntityID)
		for Gender in (M , F)
		)as pvt

---Q3---
select [Name] 
from Production.Product
where len(Name) < 15 and right(RTRIM(Name),2) like 'e%'

---Q4---
go
create function dbo.ufnShamciDate(@date char(10))
returns varchar(50)
as
begin
	if(len(@date)<>10 or SUBSTRING(@date,5,1)<>'/' or SUBSTRING(@date,8,1)<>'/') 
		return 'Wrong Format';
	if(SUBSTRING(@date,6,2) = '01')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Farvardin Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '02')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Ordibehesht Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '03')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Khordad Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '04')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Tir Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '05')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Mordad Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '06')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Shahrivar Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '07')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Mehr Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '08')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Aban Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '09')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Azar Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '10')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Dey Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '11')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Bahman Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	if(SUBSTRING(@date,6,2) = '12')
		return CONCAT(CONCAT(CONCAT(SUBSTRING(@date,9,2),' Esfand Mah'),SUBSTRING(@date,1,4)),' Shamci ');
	return 'ERROR'
end;
go
select dbo.ufnShamciDate('1396/09/15') as Date --example

---Q5---
go
create function dbo.ufnFindTerritory(@Year int , @Month int , @ProductName nvarchar(50))
returns Table
as
return
(
			select Product.[Name] as ProductName , SalesTerritory.[Name] as TerritoryName , SalesOrderHeader.OrderDate
			from Sales.SalesOrderHeader 
					inner join Sales.SalesOrderDetail on SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID
					inner join Production.Product on SalesOrderDetail.ProductID=Product.ProductID
					inner join Sales.SalesTerritory on SalesOrderHeader.TerritoryID=SalesTerritory.TerritoryID
			where   Product.[Name]=@ProductName 
						and year(SalesOrderHeader.OrderDate)=@Year 
						and month(SalesOrderHeader.OrderDate)=@Month
);
go
--example
select *
from dbo.ufnFindTerritory(2005,07,'Mountain-100 Black, 44')