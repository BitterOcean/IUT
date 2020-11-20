CREATE PROCEDURE make_SCD_3
AS
BEGIN
	declare @last_SCD_tmp table(
		[customer_code] [int] NULL,
		[name] [varchar](200) NULL,
		[branch] [int] NULL,
		[type] [int] NULL,
		[id_code] [varchar](12) NULL,
		[phone] [varchar](12) NULL,
		[original_job] [varchar](100) NULL,
		[effective_date] [date] NULL,
		[current_job] [varchar](100) NULL
	);
	insert into @last_SCD_tmp select * from SCD_3;
	truncate table SCD_3;

	--new
	insert into SCD_3
		select customer_code,[name],branch,[type],id_code,phone,null as original_job, getdate() as effective_date,job as current_job
		from customer
		where customer_code not in (select customer_code from @last_SCD_tmp);

	--update
	insert into SCD_3
		select c.customer_code,c.[name],c.branch,c.[type],c.id_code,c.phone,s.current_job as original_job, getdate() as effective_date,c.job as current_job
		from customer as c inner join @last_SCD_tmp as s on(c.customer_code=s.customer_code)
		where c.job!=s.current_job;

	--not change
	insert into SCD_3
		select s.customer_code,s.[name],s.branch,s.[type],s.id_code,s.phone,s.original_job,s.effective_date,s.current_job
		from customer as c inner join @last_SCD_tmp as s on(c.customer_code=s.customer_code)
		where c.job=s.current_job;

	--delete
	insert into SCD_3
		select customer_code,[name],branch,[type],id_code,phone,original_job,effective_date,current_job
		from @last_SCD_tmp
		where customer_code not in (select customer_code from customer);
END

