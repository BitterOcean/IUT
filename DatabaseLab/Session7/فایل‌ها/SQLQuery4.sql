----Q4
bcp "SELECT * FROM AdventureWorks2012.Production.Location WITH (NOLOCK)" queryout D:\MaryamEXCEL\location.dat -c -T

----Q5
CREATE TABLE xmlTable(
	Name [nvarchar](250) NULL,
	AnnualSales [xml] NULL,
	YearOpened [xml] NULL,
	NumberEmployees [xml] NULL
);

insert into xmlTable SELECT Name 
, Demographics.query('
	declare default element namespace
	"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $P in /StoreSurvey
	return
	<AnnualSales>
	{ $P/AnnualSales }
	</AnnualSales>
	') as AnnualSales 
, Demographics.query('
	declare default element namespace
	"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $P in /StoreSurvey
	return
	<YearOpened>
	{ $P/YearOpened }
	</YearOpened>
	') as YearOpened 
, Demographics.query('
	declare default element namespace
	"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $P in /StoreSurvey
	return
	<NumberEmployees>
	{ $P/NumberEmployees }
	</NumberEmployees>
	') as NumberEmployees
FROM AdventureWorks2012.Sales.Store

bcp AdventureWorks2012.dbo.xmlTable out xmltest.txt -T -c