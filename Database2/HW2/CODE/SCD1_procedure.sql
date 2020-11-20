CREATE PROCEDURE make_SCD_1
AS
BEGIN
	declare @last_SCD_tmp table(
		[customer_code] [int] NULL,
		[name] [varchar](200) NULL,
		[branch] [int] NULL,
		[type] [int] NULL,
		[id_code] [varchar](12) NULL,
		[phone] [varchar](12) NULL,
		[job] [varchar](100) NULL
	);
	insert into @last_SCD_tmp 
		select * from SCD_1;
	
	truncate table SCD_1;

	--new & update & not change
	insert into SCD_1
		select customer_code,[name],branch,[type],id_code,phone,job
		from customer

	--delete
	insert into SCD_1
		select customer_code,[name],branch,[type],id_code,phone,job
		from @last_SCD_tmp
		where customer_code not in (select customer_code from customer);
END