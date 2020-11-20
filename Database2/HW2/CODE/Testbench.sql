----------------------
--    First Run  :      --
----------------------
SELECT * FROM [dbo].[SCD_1]
EXEC [dbo].[make_SCD_1];
SELECT * FROM [dbo].[SCD_1]

SELECT * FROM [dbo].[SCD_2]
EXEC [dbo].[make_SCD_2];
SELECT * FROM [dbo].[SCD_2]


SELECT * FROM [dbo].[SCD_3]
EXEC [dbo].[make_SCD_3];
SELECT * FROM [dbo].[SCD_3]

----------------------
--   SCD type 1 :    --
----------------------
--insert 
insert into [dbo].[customer](customer_code,name,	branch,	type,	id_code,job,	phone) 
	values (4,'Mohammad Saeedmehr',2,1,'1273218310','Data Analyser','09130010020');
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_1]
EXEC [dbo].[make_SCD_1];
SELECT * FROM [dbo].[SCD_1]

--delete 
delete from [dbo].[customer] where customer_code = 4
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_1]
EXEC [dbo].[make_SCD_1];
SELECT * FROM [dbo].[SCD_1]

--update
UPDATE [dbo].[customer]
SET job = 'Employee'
WHERE customer_code = 1;
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_1]
EXEC [dbo].[make_SCD_1];
SELECT * FROM [dbo].[SCD_1]


----------------------
--   SCD type 2 :    --
----------------------
--insert 
insert into [dbo].[customer](customer_code,name,	branch,	type,	id_code,job,	phone) 
	values (4,'Mohammad Saeedmehr',2,1,'1273218310','Data Analyser','09130010020');
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_2]
EXEC [dbo].[make_SCD_2];
SELECT * FROM [dbo].[SCD_2]

--delete 
delete from [dbo].[customer] where customer_code = 4
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_2]
EXEC [dbo].[make_SCD_2];
SELECT * FROM [dbo].[SCD_2]

--update
UPDATE [dbo].[customer]
SET job = 'Employee'
WHERE customer_code = 1;
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_2];
EXEC [dbo].[make_SCD_2];
SELECT * FROM [dbo].[SCD_2];


----------------------
--   SCD type 3 :    --
----------------------
--insert 
insert into [dbo].[customer](customer_code,name,	branch,	type,	id_code,job,	phone) 
	values (4,'Mohammad Saeedmehr',2,1,'1273218310','Data Analyser','09130010020');
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_3]
EXEC [dbo].[make_SCD_3];
SELECT * FROM [dbo].[SCD_3]

--delete 
delete from [dbo].[customer] where customer_code = 4
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_3]
EXEC [dbo].[make_SCD_3];
SELECT * FROM [dbo].[SCD_3]


 --update
UPDATE [dbo].[customer]
SET job = 'Employee'
WHERE customer_code = 1;
SELECT * FROM [dbo].[customer];

SELECT * FROM [dbo].[SCD_3];
EXEC [dbo].[make_SCD_3];
SELECT * FROM [dbo].[SCD_3];