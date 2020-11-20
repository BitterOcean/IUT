create procedure make_SCD_2
as
begin
	declare @tmp2 table(
		[customer_code] [int] NULL,
		[name] [varchar](200) NULL,
		[branch] [int] NULL,
		[type] [int] NULL,
		[id_code] [varchar](12) NULL,
		[job] [varchar](100) NULL,
		[phone] [varchar](12) NULL,
		[start_date] [date] NULL,
		[end_date] [date] NULL,
		[current_flag] [int] NULL
	);
	declare @tmp table(
		[su_key] [int] NULL,
		[customer_code] [int] NULL,
		[name] [varchar](200) NULL,
		[branch] [int] NULL,
		[type] [int] NULL,
		[id_code] [varchar](12) NULL,
		[job] [varchar](100) NULL,
		[phone] [varchar](12) NULL,
		[start_date] [date] NULL,
		[end_date] [date] NULL,
		[current_flag] [int] NULL
	);

	insert into @tmp 
		select su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag 
		from SCD_2;

	truncate table SCD_2;

	insert into @tmp2
		select customer_code,name,branch,type,id_code,job,phone,getdate() as start_date,null as end_date,1 as current_flag
		from customer;

	SET IDENTITY_INSERT SCD_2 ON;

	with NotChangedValues as (
		select su_key,
				  [@tmp2].customer_code,
				  [@tmp2].name,
				  [@tmp2].branch,
				  [@tmp2].type,
				  [@tmp2].id_code,
				  [@tmp2].job,
				  [@tmp2].phone,
				  [@tmp2].start_date,
				  [@tmp2].end_date,
				  [@tmp2].current_flag,
				  [@tmp].customer_code as SCD_CUS_CODE
		from @tmp2 left join @tmp 
			on [@tmp2].customer_code = [@tmp].customer_code 
				and [@tmp2].job = [@tmp].job
	),
	T as ( 
		select su_key,
				  customer_code,
				  name,
				  branch,
				  type,
				  id_code,
				  job,
				  phone,
				  start_date,
				  end_date,
				  current_flag 
		from NotChangedValues 
		where SCD_CUS_CODE is not null
	)

	insert into SCD_2(su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag) 
		select su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag 
		from T;

	with OldValues as (
		select [@tmp].su_key,
				  [@tmp].customer_code,
				  [@tmp].name,
				  [@tmp].branch,
				  [@tmp].type,
				  [@tmp].id_code,
				  [@tmp].job,
				  [@tmp].phone,
				  [@tmp].start_date,
				  getdate() as end_date,
				  0 as current_flag,
				  [@tmp].customer_code as SCD_CUS_CODE
		from @tmp2 left join @tmp on [@tmp2].customer_code = [@tmp].customer_code
		where [@tmp2].job != [@tmp].job
	),
	T as (
		select su_key,
				  customer_code,
				  name,
				  branch,
				  type,
				  id_code,
				  job,
				  phone,
				  start_date,
				  end_date,
				  current_flag 
		from OldValues 
		where SCD_CUS_CODE is not null
	)
	insert into SCD_2(su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag) 
		select  su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag
		from T;

	with DeletedValues as (
		select su_key,
				  [@tmp].customer_code,
				  [@tmp].name,
				  [@tmp].branch,
				  [@tmp].type,
				  [@tmp].id_code,
				  [@tmp].job,
				  [@tmp].phone,
				  [@tmp].start_date,
				  [@tmp].end_date,
				  [@tmp].current_flag,
				  [@tmp].customer_code as SCD_CUS_CODE
		from @tmp 
		where customer_code not in (select customer_code from @tmp2) 
	)
	insert into SCD_2(su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag) 
		select  su_key,customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag
		from DeletedValues;

	SET IDENTITY_INSERT SCD_2 OFF;

	with NewValues as (
		select [@tmp2].customer_code,
				  [@tmp2].name,
				  [@tmp2].branch,
				  [@tmp2].type,
				  [@tmp2].id_code,
				  [@tmp2].job,
				  [@tmp2].phone,
				  [@tmp2].start_date,
				  [@tmp2].end_date,
				  [@tmp2].current_flag,
				  [@tmp].customer_code as SCD_CUS_CODE
		from @tmp2 left join @tmp on [@tmp2].customer_code = [@tmp].customer_code
	),
	T as (
		select customer_code,
				  name,
				  branch,
				  type,
				  id_code,
				  job,
				  phone,
				  start_date,
				  end_date,
				  current_flag 
		from NewValues 
		where SCD_CUS_CODE is null
	)
	insert into SCD_2(customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag) 
		select customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag 
		from T;

	with NewChangedValues as (
		select [@tmp2].customer_code,
				  [@tmp2].name,
				  [@tmp2].branch,
				  [@tmp2].type,
				  [@tmp2].id_code,
				  [@tmp2].job,
				  [@tmp2].phone,
				  [@tmp2].start_date,
				  [@tmp2].end_date,
				  [@tmp2].current_flag,
				  [@tmp].customer_code as SCD_CUS_CODE
		from @tmp2 left join @tmp 
			on [@tmp2].customer_code = [@tmp].customer_code 
				and [@tmp2].job != [@tmp].job 
				and [@tmp].current_flag = 1
	),
	T as ( 
		select customer_code,
				  name,
				  branch,
				  type,
				  id_code,
				  job,
				  phone,
				  start_date,
				  end_date,
				  current_flag 
		from NewChangedValues 
		where SCD_CUS_CODE is not null
	)

	insert into SCD_2(customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag) 
		select customer_code,name,branch,type,id_code,job,phone,start_date,end_date,current_flag 
		from T;
end


