/*************************************************************************
DataBase2 Project		: Create Data Warehouse
Authors						: Sajede Nicknadaf, Maryam Saeedmehr
Student Numbers		: 9637453, 9629373
Semester						: fall 1399
version							: 4
**************************************************************************/
drop database if exists HospitalDW
go

create database HospitalDW
go 

use HospitalDW
go

exec sp_changedbowner 'sa'
go
/***********************************Schema******************************/
create schema Pharmacy
go

create schema Clinic
go
/********************************Dimensions*****************************/
create table dimInsuranceCompanies(
	insuranceCompany_ID			int primary key,
	[name]									varchar(75),
	license_code						varchar(25),
	phone_number					varchar(25),--SCD1
	[address]								varchar(300),--SCD1
	previous_manager				varchar(100),
	manager_change_date		date,
	current_manager					varchar(100),--SCD3
	previous_agent					varchar(100),
	agent_change_date				date,
	current_agent						varchar(100),--SCD3
	fax_number							varchar(25),--SCD1
	website_address					varchar(200),
	manager_phone_number	varchar(25),--SCD1
	agent_phone_number			varchar(25),--SCD1
	additional_info						varchar(200),
	active									int,--SCD1
	active_description				varchar(200)
	)
go

create table dimInsurances(
	insurance_ID						int primary key, 
	code										varchar(15), 
	insuranceCompany_ID			int,
	insuranceCompany_name	varchar(75),
	insurer									varchar(100),
	insurer_phone_number		varchar(25),
	additional_info						varchar(200),
	expire_date							date,
	medicine_reduction				int,
	appointment1_reduction		int,
	appointment2_reduction		int,
	appointment3_reduction		int,
	hospitalization_reduction	int,
	surgery_reduction				int,
	test_reduction						int,
	dentistry_reduction				int,
	radiology_reduction			int
)
go

create table dimPatients(
	patient_code						int identity(1,1) primary key,-- surrogate key
    patient_ID							int ,
    national_code						varchar(15),
	insurance_ID						int,--SCD2
    first_name							varchar(30),
    last_name							varchar(60),
    birthdate								date,
    height									int,--SCD1
    [weight]								int,--SCD1
    gender									varchar(15),
    phone_number					varchar(25),--SCD1
	death_date							date,--SCD1
	death_reason						int,--SCD1
	postal_code							varchar(20),--SCD1
	[address]								varchar(200),--SCD1
	additional_info						varchar(200),
	[start_date]							date,
    end_date								date,
    current_flag							int,
)
go

create table Pharmacy.dimMedicineFactories(
    medicineFactory_ID				int primary key,
    [name]									varchar(75),
    license_code						varchar(25),
    phone_number					varchar(25),--SCD1
	previous_manager				varchar(100),
	manager_change_date		date,
	current_manager					varchar(100),--SCD3
	previous_agent					varchar(100),
	agent_change_date				date,
	current_agent						varchar(100),--SCD3
	fax_number							varchar(25),--SCD1
	website_address					varchar(200),
	manager_phone_number	varchar(25),--SCD1
	agent_phone_number			varchar(25),--SCD1
	[address]								varchar(200),--SCD1
	additional_info						varchar(200),
	active									bit,
	active_description				varchar(200)
)
go

create table Pharmacy.dimMedicines(
    medicine_code						int identity(1,1) primary key, --surrogate key
    medicine_ID								int,
    [name]										varchar(30),
    latin_name								varchar(75),
    dose											float,
    side_effects								varchar(200),
    purchase_price							int,--SCD2
	sales_price								int,--SCD2
	stock										int, --SCD1
	medicine_type							int, 
	medicine_type_description		varchar(20),
	medicineFactory_ID					int,
	production_date						date,--SCD1
	expire_date								date,--SCD1
	additional_info							varchar(200),
    [start_date]								date,
    end_date									date,
    current_flag								int,
	sales_purchase							int, -- -1 -> null records / 0 -> firstload/ 1 -> sales / 2 -> purchase / 3 -> both 
	sales_purchase_description		varchar(50)
)
go

create table dimDate (
    TimeKey										int primary key,
    FullDateAlternateKey					varchar(50),
    PersianFullDateAlternateKey		varchar(50),
    DayNumberOfWeek					int,
    PersianDayNumberOfWeek			int,
    EnglishDayNameOfWeek			varchar(10),
    PersianDayNameOfWeek			nvarchar(10),
    DayNumberOfMonth					int,
    PersianDayNumberOfMonth		int,
    DayNumberOfYear						int,
    PersianDayNumberOfYear			int,
    WeekNumberOfYear					int,
    PersianWeekNumberOfYear		int,
    EnglishMonthName						varchar(50),
    PersianMonthName					nvarchar(50),
    MonthNumberOfYear					int,
    PersianMonthNumberOfYear		int,
    CalendarQuarter							int,
    PersianCalendarQuarter				int,
    CalendarYear								int,
    PersianCalendarYear					int,
    CalendarSemester						int,
    PersianCalendarSemester			int
)
go

create table Clinic.dimDepartments(
    department_ID						int primary key,
    [name]									varchar(30),
    [description]						varchar(300),
	previous_chairman				varchar(100),
	chairman_change_date		date,
	current_chairman					varchar(100),--SCD3
	previous_assistant				varchar(100),
	assistant_change_date			date,
	current_assistant					varchar(100),--SCD3
	chairman_phone_number	varchar(15),--SCD1
	assistant_phone_number		varchar(15),--SCD1
	chairman_room					int,
	assistant_room						int,
	reception_phone_number	varchar(15),--SCD1
	budget									int,
	additional_info						varchar(200)
)
go

create table Clinic.dimDoctorContracts(
	doctorContract_ID			int primary key,
	contract_start_date			date,
	contract_end_date			date,
	appointment_portion		int,
	salary								int,
	active								bit,
	active_description			varchar(50),
	additional_info					varchar(200) 
)
go

create table Clinic.dimDoctors(
	doctor_code							int IDENTITY(1,1) primary key, -- surrogate key
    doctor_ID									int,
	doctorContract_ID					int,--SCD2
    national_code							varchar(15),
    license_code							varchar(25),
    first_name								varchar(30),
    last_name								varchar(75),
    birthdate									date,
    phone_number						varchar(25),--SCD1
	department_ID							int,
	department_name					varchar(30),
	education_degree					int, --[1-3]  --SCD2 
	specialty_description				varchar(100),
	graduation_date						date,
	university									varchar(100),
	gender										varchar(10),
	religion									varchar(100),
	nationality								varchar(50),
	marital_status							bit,
	marital_status_description		varchar(20), -- 0 for single / 1 for married
	postal_code								varchar(12),
	[address]									varchar(200),
	additional_info							varchar(200),
	[start_date]								date,
    end_date									date,
    current_flag								int,
	Contract_Degree						int,-- -1 -> null record / 0 -> firstload / 1 -> Contract / 2 -> Degree / 3 -> both
	Contract_Degree_description	varchar(50)
)
go

create table Clinic.dimIllnessTypes(
	illnessType_ID					int primary key,
	[name]								varchar(50),
	[description]					varchar(200),
	related_department_ID	int
)
go

create table Clinic.dimIllnesses(
	illness_ID								int primary key,
	[name]									varchar(100),
	illnessType_ID						int,
	illnessType_name					varchar(50),
	scientific_name					varchar(100),
	special_illness						bit, --0 for not special / 1 for special illnesses
	special_illness_description	varchar(50),
	killing_status						smallint,
	killing_description				varchar(100),
	chronic									bit,
	chronic_description				varchar(100)
)
go

/***********************************Facts*********************************/
create table Pharmacy.factTransactionalMedicine(
	patient_code						int,-- surrogate key
    patient_ID							int,--natural key
	insurance_ID						int, 
    insuranceCompany_ID			int,
    medicine_code					int, --surrogate key
    medicine_ID							int, --natural key
    medicineFactory_ID				int,
    TimeKey								int,
	----------------------------------
    number_of_units_bought	int,
    paid_price							int,
	real_price								int,
	insurance_credit					int,
	factory_share						int,
	income									int,
)
go

create table Pharmacy.factMonthlyMedicine(
	insuranceCompany_ID				int,
    medicine_code						int, --surrogate key
    medicine_ID								int, --natural key
	medicineFactory_ID					int,
    TimeKey									int,
	-------------------------------------
    total_number_bought				int,
    total_paid_price						int,
	total_real_price						int,
	total_insurance_credit				int,
	total_factory_share					int,
	total_income							int,
    number_of_patients_bought   int,
)
go

create table Pharmacy.factAccumulativeMedicine(
	insuranceCompany_ID				int,
    medicine_code						int, --surrogate key
    medicine_ID								int, --natural key
	medicineFactory_ID					int,
	-------------------------------------
    total_number_bought				int,
    total_paid_price						int,
	total_real_price						int,
	total_insurance_credit				int,
	total_factory_share					int,
	total_income							int,
    number_of_patients_bought   int
)
go
-------------------------------------------------------------
-------------------------------------------------------------
create table Clinic.factTransactionAppointment (
    patient_code								int,-- surrogate key
    patient_ID									int,--natural key
	insurance_ID								int, 
    insuranceCompany_ID					int,
    doctor_code								int, -- surrogate key
	doctor_ID										int, --natural key
	doctorContract_ID						int,
	department_ID								int,
	main_detected_illness					int,
	illnessType_ID								int,
    TimeKey										int,
	-------------------------------------------
    paid_price									int,
	real_price										int,
	doctor_share								int,
	insurance_share							int,
	income											int,
	payment_method						bit, -- credit card / cash
	payment_method_description		varchar(60),
	credit_card_number						varchar(26),
	payer											varchar(60),
	payer_phone_number					varchar(25),
	additional_info								varchar(200),
)
go

create table Clinic.factDailyAppointment (
	insuranceCompany_ID		int,
    doctor_code					int, -- surrogate key
	doctor_ID							int, --natural key
	doctorContract_ID			int,
	department_ID					int,
	main_detected_illness		int,
	illnessType_ID					int,
    TimeKey							int,
	-------------------------------
	total_paied_price				int,
	total_real_price				int,
	total_insurance_share		int,
	total_doctor_share			int,
	total_income					int,
	number_of_patient			int
)
go

create table Clinic.factAccumulativeAppointment (
    insuranceCompany_ID		int,
     doctor_code					int, -- surrogate key
	doctor_ID							int, --natural key
	doctorContract_ID			int,
	department_ID					int,
	-------------------------------
	total_paied_price				int,
	total_real_price				int,
	total_insurance_share		int,
	total_doctor_share			int,
	total_income					int,
	number_of_patient			int
)
go

create table Clinic.factlessPatientIllnesses(
	patient_code			int,
	patient_ID				int,
	illness_ID					int,
	[detection_date]		date,
	severity					int, --[1-5]
	additional_info			varchar(200)
)
go

create table Logs(
    [date]				datetime,
    table_name     varchar(50),
    [status]				bit,
    [description]	varchar(500),
    affected_rows  int,
)
go

--insert date
--writ date file address
bulk insert dbo.[dimDate]
from 'E:\education files\db2\Project\Date.txt'
with
(
	fieldterminator = '\t',
	CODEPAGE = '65001'
);

go

/**************************************************************************
DataBase2 Project		: Create Data Warehouse Procedures-All Procedures
Authors					: Sajede Nicknadaf, Maryam Saeedmehr
Student Numbers			: 9637453, 9629373
Semester				: fall 1399
version					: 4
***************************************************************************/
use HospitalDW
go

/**************************************************************************
dbo Dimentions
***************************************************************************/
create or alter procedure dimInsuranceCompanies_FirstLoader @curr_date date
	as
	begin
		begin try 
			truncate table HospitalDW.dbo.dimInsuranceCompanies
			insert into HospitalDW.dbo.dimInsuranceCompanies
			SELECT [insuranceCompany_ID]
				,[name]
				,[license_code]
				,[phone_number]
				,[address]
				,NULL -- previous_manager
				,@curr_date -- manager_change_date
				,[manager]
				,NULL -- previous_agent
				,@curr_date -- agent_change_date
				,[agent]
				,[fax_number]
				,[website_address]
				,[manager_phone_number]
				,[agent_phone_number]
				,[additional_info]
				,[active]
				,[active_description]
			FROM HospitalSA.dbo.InsuranceCompanies
			insert into HospitalDW.dbo.dimInsuranceCompanies
			values(-1,'Nothing','Nothing','Nothing','Nothing','Nothing','0001-01-01','Nothing','Nothing','0001-01-01','Nothing','Nothing','Nothing','Nothing','Nothing','Nothing',null,'Nothing');
			
		---------------------------------------------------
			insert into [dbo].[Logs]
				([date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			values
				(GETDATE()
				,'dimInsuranceCompanies'
				,1
				,'inserting new values was successfull'
				,@@ROWCOUNT)
		end try
		begin catch
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimInsuranceCompanies', 0, 'Error while inserting or updating', @@ROWCOUNT);
			select ERROR_MESSAGE()
		end catch
	end
go
---------------------------------------------
---------------------------------------------

create or alter procedure dimInsuranceCompanies_Loader @curr_date Date
	as 
	begin
	begin try
		merge HospitalDW.dbo.dimInsuranceCompanies as IC
		using HospitalSA.dbo.InsuranceCompanies as SA on
		IC.insuranceCompany_ID = SA.insuranceCompany_ID
		when not matched then 
		insert values (
		[insuranceCompany_ID]
		,[name]
		,[license_code]
		,[phone_number]
		,[address]
		,NULL -- previous_manager
		,@curr_date -- manager_change_date
		,[manager]
		,NULL -- previous_agent
		,@curr_date -- agent_change_date
		,[agent]
		,[fax_number]
		,[website_address]
		,[manager_phone_number]
		,[agent_phone_number]
		,[additional_info]
		,[active]
		,[active_description]
		)
		when matched and (
			IC.phone_number <> SA.phone_number or
			IC.[address] <> SA.[address] or
			IC.fax_number <> SA.fax_number or
			IC.website_address <> SA.website_address or
			IC.manager_phone_number <> SA.manager_phone_number or
			IC.agent_phone_number <> SA.agent_phone_number or
			IC.current_manager <> SA.manager or
			IC.current_agent <> SA.agent
		) then 
		update set 
			IC.phone_Number = SA.phone_number,
			IC.[address] = SA.[address],
			IC.fax_number = SA.fax_number,
			IC.website_address = SA.website_address,
			IC.manager_phone_number = SA.manager_phone_number,
			IC.agent_phone_number = SA.agent_phone_number,
			IC.previous_manager = case 
				when IC.current_manager <> SA.manager then IC.current_manager
				else IC.previous_manager
			end,
			IC.manager_change_date=case 
				when IC.current_manager <> SA.manager then @curr_date
				else IC.manager_change_date
			end,
			IC.current_manager = case 
				when IC.current_manager <> SA.manager then SA.manager
				else IC.current_manager
			end,
			IC.previous_agent = case 
				when IC.current_agent <> SA.agent then IC.current_agent
				else IC.previous_manager
			end,
			IC.agent_change_date=case 
				when IC.current_agent <> SA.agent then @curr_date
				else IC.agent_change_date
			end,
			IC.current_agent = case 
				when IC.current_agent <> SA.agent then SA.agent
				else IC.current_agent
			end

		;
		/*merge HospitalDW.dbo.dimInsuranceCompanies as IC
		using HospitalSA.dbo.InsuranceCompanies as SA on
		IC.insuranceCompany_ID = SA.insuranceCompany_ID
		when matched and (IC.current_manager != SA.manager) then 
		update set 
			IC.previous_manager=IC.current_manager,
			IC.current_manager = SA.manager,
			IC.manager_change_date=@curr_date
		;
		merge HospitalDW.dbo.dimInsuranceCompanies as IC
		using HospitalSA.dbo.InsuranceCompanies as SA on
		IC.insuranceCompany_ID = SA.insuranceCompany_ID
		when matched and (IC.current_agent != SA.agent) then 
		update set 
			IC.previous_agent=IC.current_agent,
			IC.current_agent = SA.agent,
			IC.agent_change_date=@curr_date
		;*/
		--logs
		insert into [dbo].[Logs]
			([date]
			,[table_name]
			,[status]
			,[description]
			,[affected_rows])
		values
			(GETDATE()
			,'dimInsuranceCompanies'
			,1
			,'inserting new values was successfull'
			,@@ROWCOUNT)
	end try
	begin catch
		INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
		VALUES (GETDATE(), 'dbo.dimInsuranceCompanies', 0, 'Error while inserting or updating', @@ROWCOUNT);
	end catch
	end
go
---------------------------------------------
---------------------------------------------
create or alter procedure dimInsurances_FirstLoader
	as
	begin
		begin try 
			truncate table HospitalDW.dbo.dimInsurances
			insert into HospitalDW.dbo.dimInsurances
			SELECT i.[insurance_ID]
				,i.[code]
				,i.[insuranceCompany_ID]
				,c.[name] --insuranceCompany_name
				,i.[insurer]
				,i.[insurer_phone_number]
				,i.[additional_info]
				,i.[expire_date]
				,i.[medicine_reduction]
				,i.[appointment1_reduction]
				,i.[appointment2_reduction]
				,i.[appointment3_reduction]
				,i.[hospitalization_reduction]
				,i.[surgery_reduction]
				,i.[test_reduction]
				,i.[dentistry_reduction]
				,i.[radiology_reduction]
			FROM HospitalSA.dbo.Insurances as i inner join HospitalSA.dbo.InsuranceCompanies as c on(i.insuranceCompany_ID=c.insuranceCompany_ID)
			insert into HospitalDW.dbo.dimInsurances
			values(-1,'Nothing',-1,'Nothing','Nothing','Nothing','Nothing','0001-01-01',0,0,0,0,0,0,0,0,0);
			
		---------------------------------------------------
			insert into [dbo].[Logs]
				([date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			values
				(GETDATE()
				,'dimInsurances'
				,1
				,'inserting new values was successfull'
				,@@ROWCOUNT)
		end try
		begin catch
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimInsurances', 0, 'Error while inserting or updating', @@ROWCOUNT);
			select ERROR_MESSAGE()
		end catch
	end
go
---------------------------------------------
---------------------------------------------
create or alter procedure dimInsurances_Loader
	as
	begin
		begin try 
			/*declare @source table(
				insurance_ID int , 
				code varchar(15), 
				insuranceCompany_ID	int,
				insuranceCompany_name varchar(75),
				insurer	varchar(100),
				insurer_phone_number varchar(25),
				additional_info	varchar(200),
				expire_date	date,
				medicine_reduction int,
				appointment1_reduction int,
				appointment2_reduction int,
				appointment3_reduction int,
				hospitalization_reduction int,
				surgery_reduction int,
				test_reduction int,
				dentistry_reduction	int,
				radiology_reduction int
			);
			insert into @source*/
			SELECT i.[insurance_ID]
				,i.[code]
				,i.[insuranceCompany_ID]
				,c.[name] as insuranceCompany_name
				,i.[insurer]
				,i.[insurer_phone_number]
				,i.[additional_info]
				,i.[expire_date]
				,i.[medicine_reduction]
				,i.[appointment1_reduction]
				,i.[appointment2_reduction]
				,i.[appointment3_reduction]
				,i.[hospitalization_reduction]
				,i.[surgery_reduction]
				,i.[test_reduction]
				,i.[dentistry_reduction]
				,i.[radiology_reduction] into #source
			FROM HospitalSA.dbo.Insurances as i inner join HospitalSA.dbo.InsuranceCompanies as c on(i.insuranceCompany_ID=c.insuranceCompany_ID);

			merge HospitalDW.dbo.dimInsurances as I
			using #source as SA on
			I.insurance_ID = SA.insurance_ID

			when not matched then 
			insert values(
				 [insurance_ID]
				,[code]
				,[insuranceCompany_ID]
				,[insuranceCompany_name] --insuranceCompany_name
				,[insurer]
				,[insurer_phone_number]
				,[additional_info]
				,[expire_date]
				,[medicine_reduction]
				,[appointment1_reduction]
				,[appointment2_reduction]
				,[appointment3_reduction]
				,[hospitalization_reduction]
				,[surgery_reduction]
				,[test_reduction]
				,[dentistry_reduction]
				,[radiology_reduction]
			);
			
		---------------------------------------------------
			insert into [dbo].[Logs]
				([date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			values
				(GETDATE()
				,'dimInsurances'
				,1
				,'inserting new values was successfull'
				,@@ROWCOUNT)
		end try
		begin catch
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimInsurances', 0, 'Error while inserting or updating', @@ROWCOUNT);
			select ERROR_MESSAGE()
		end catch
	end
go
---------------------------------------------
---------------------------------------------
CREATE OR ALTER PROCEDURE dimPatients_FirstLoader @curr_date date
	AS 
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE HospitalDW.dbo.dimPatients;
			-- CREATE A RECORD WITH -1 KEY-ID 
			SET IDENTITY_INSERT HospitalDW.dbo.dimPatients ON;
			INSERT INTO HospitalDW.dbo.dimPatients(
				[patient_code]
				,[patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
			) 
			VALUES(
				-1,
				-1,
				'Nothing',
				-1,
				'Nothing',
				'Nothing',
				'0001-01-01',
				0,
				0,
				'Nothing',
				'Nothing',
				'0001-01-01',
				-1,
				'Nothing',
				'Nothing',
				'Nothing',
				'0001-01-01',
				'0001-01-01',
				1
			)
			-------------------------------------------------
			SET IDENTITY_INSERT HospitalDW.dbo.dimPatients Off;
			INSERT INTO HospitalDW.dbo.dimPatients(
				[patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
			) 
				SELECT [patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,@curr_date
				,null
				,1
				FROM HospitalSA.dbo.Patients;

			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dbo.dimPatients', 1, 'First Load was Successful', @@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dbo.dimPatients', 0, 'First Load was Failed', @@ROWCOUNT);
			RETURN;
		END CATCH
	END
GO
------------------------------------------------------
------------------------------------------------------
CREATE OR ALTER PROCEDURE dimPatients_Loader @curr_date date
	AS 
	BEGIN 
		BEGIN TRY
			MERGE INTO HospitalDW.dbo.dimPatients AS [Target]
			USING HospitalSA.dbo.Patients AS [Source]
			ON Source.patient_ID = [Target].patient_ID
			WHEN MATCHED AND
				(
					[Target].height	<> Source.height
					OR [Target].[weight]<> Source.[weight]
					OR [Target].phone_number <> Source.phone_number
					OR [Target].death_date <> Source.death_date
					OR [Target].death_reason <> Source.death_reason
					OR [Target].insurance_ID<>Source.insurance_ID
				) 
			THEN UPDATE SET 
						height = Source.[height],
						[weight] = Source.[weight],
						phone_number = Source.[phone_number],
						death_date = Source.death_date,
						death_reason = Source.death_reason,
						end_date= case
							when [Target].insurance_ID<>Source.insurance_ID and [Target].current_flag=1 then @curr_date
							else end_date
						end,
						current_flag =  case
							when [Target].insurance_ID<>Source.insurance_ID then 0
							else current_flag
						end
			WHEN NOT MATCHED BY TARGET 
			THEN INSERT (
				[patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
			) VALUES (
				[patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,@curr_date
				,NULL
				,1
			);
			/*MERGE INTO HospitalDW.dbo.dimPatients AS [Target]
			USING HospitalSA.dbo.Patients AS [Source]
			ON Source.patient_ID = [Target].patient_ID
			WHEN MATCHED AND([Target].insurance_ID<>Source.insurance_ID)
			THEN UPDATE SET
					end_date=@curr_date,
					current_flag=0
			;*/
			INSERT INTO HospitalDW.dbo.dimPatients(
				[patient_ID]
				,[national_code]
				,[insurance_ID]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[height]
				,[weight]
				,[gender]
				,[phone_number]
				,[death_date]
				,[death_reason]
				,[postal_code]
				,[address]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
			)
			select d.[patient_ID]
				,d.[national_code]
				,s.[insurance_ID]
				,d.[first_name]
				,d.[last_name]
				,d.[birthdate]
				,d.[height]
				,d.[weight]
				,d.[gender]
				,d.[phone_number]
				,d.[death_date]
				,d.[death_reason]
				,d.[postal_code]
				,d.[address]
				,d.[additional_info]
				,@curr_date
				,NULL
				,1
			from HospitalDW.dbo.dimPatients as d inner join HospitalSA.dbo.Patients as s
				on(d.patient_ID=s.patient_ID)
			where d.end_date=@curr_date
			;

			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dbo.dimPatients', 1, 'Update or Insert was Successful', @@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dbo.dimPatients', 0, 'Update or Insert was Failed', @@ROWCOUNT);
			RETURN;
		END CATCH
	END
GO

/*###########################################################################
								Pharmacy Mart
###########################################################################*/

/**************************************************************************
Pharmacy Dimentions
***************************************************************************/
create or alter procedure Pharmacy.dimMedicineFactory_FirstLoader @curr_date date
	as
	begin
		begin try 
			truncate table HospitalDW.Pharmacy.dimMedicineFactories
			insert into HospitalDW.Pharmacy.dimMedicineFactories 
			select 
				[medicineFactory_ID],
				[name],
				[license_code],
				[phone_number],
				NULL,--[previous_manager]
				@curr_date,
				[manager],--[current_manager]
				NULL,--[previous_agent]
				@curr_date,
				[agent],--current_agent
				[fax_number],
				[website_address],
				[manager_phone_number],
				[agent_phone_number],
				[address],
				[additional_info],
				[active],
				[active_description]
			from HospitalSA.dbo.MedicineFactories;
			insert into HospitalDW.Pharmacy.dimMedicineFactories 
			values(-1,'Nothing','Nothing','Nothing','Nothing','0001-01-01','Nothing','Nothing','0001-01-01','Nothing','Nothing','Nothing','Nothing','Nothing','Nothing','Nothing',null,'Nothing')
		---------------------------------------------------
			insert into [dbo].[Logs]
				([date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			values
				(GETDATE()
				,'dimMedicineFactories'
				,1
				,'inserting new values was successfull'
				,@@ROWCOUNT)
		end try
		begin catch
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dbo.dimMedicineFactories', 0, 'Error while inserting or updating', @@ROWCOUNT);
			select ERROR_MESSAGE()
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure Pharmacy.dimMedicineFactory_Loader @curr_date date
	as 
	begin
	begin try
		merge HospitalDW.Pharmacy.dimMedicineFactories as MF
		using HospitalSA.dbo.MedicineFactories as SA on
		MF.MedicineFactory_ID = SA.MedicineFactory_ID

		when not matched then 
		insert values (
			[medicineFactory_ID],
			[name],
			[license_code],
			[phone_number],
			NULL,--[previous_manager]
			@curr_date,
			[manager],--[current_manager]
			NULL,--[previous_agent]
			@curr_date,
			[agent],--current_agent
			[fax_number],
			[website_address],
			[manager_phone_number],
			[agent_phone_number],
			[address],
			[additional_info],
			[active],
			[active_description]
		)
		when matched and (
			MF.phone_number <> SA.phone_number or
			MF.fax_number <> SA.fax_number or
			MF.manager_phone_number <> SA.manager_phone_number or
			MF.agent_phone_number <> SA.agent_phone_number or
			MF.active <> SA.active or
			MF.current_manager <> SA.manager or
			MF.current_agent <> SA.agent 
		) then update set
			 MF.phone_Number = SA.phone_number,
			 MF.fax_number = SA.fax_number,
			 MF.manager_phone_number = SA.manager_phone_number,
			 MF.agent_phone_number = SA.agent_phone_number,
			 MF.active = SA.active,
			 MF.previous_manager = case 
				when MF.current_manager <> SA.manager then MF.current_manager
				else MF.previous_manager
			end,
			MF.manager_change_date=case 
				when MF.current_manager <> SA.manager then @curr_date
				else MF.manager_change_date
			end,
			MF.current_manager = case 
				when MF.current_manager <> SA.manager then SA.manager
				else MF.current_manager
			end,
			MF.previous_agent = case 
				when MF.current_agent <> SA.agent then MF.current_agent
				else MF.previous_manager
			end,
			MF.agent_change_date=case 
				when MF.current_agent <> SA.agent then @curr_date
				else MF.agent_change_date
			end,
			MF.current_agent = case 
				when MF.current_agent <> SA.agent then SA.agent
				else MF.current_agent
			end
		;
		--logs
		insert into [dbo].[Logs]
			([date]
			,[table_name]
			,[status]
			,[description]
			,[affected_rows])
		values
			(GETDATE()
			,'dimMedicineFactories'
			,1
			,'inserting new values was successfull'
			,@@ROWCOUNT)
	end try
	begin catch
		INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
		VALUES (GETDATE(), 'dbo.dimMedicineFactories', 0, 'Error while inserting or updating', @@ROWCOUNT);
	end catch
	end
go
------------------------------------------------------
------------------------------------------------------

CREATE OR ALTER PROCEDURE Pharmacy.dimMedicines_FirstLoader @curr_date DATE
	AS 
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE HospitalDW.Pharmacy.dimMedicines;
			-- CREATE A RECORD WITH -1 KEY-ID 
			SET IDENTITY_INSERT HospitalDW.Pharmacy.dimMedicines ON;
			INSERT INTO HospitalDW.Pharmacy.dimMedicines(
				[medicine_code]
				,[medicine_ID]
				,[name]
				,[latin_name]
				,[dose]
				,[side_effects]
				,[purchase_price]
				,[sales_price]
				,[stock]
				,[medicine_type]
				,[medicine_type_description]
				,[medicineFactory_ID]
				,[production_date]
				,[expire_date]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
				,[sales_purchase]
				,[sales_purchase_description]
			)VALUES(
				-1
				,-1
				,'Nothing'
				,'Nothing'
				,0
				,'Nothing'
				,0
				,0
				,0
				,-1
				,'Nothing'
				,-1
				,'0001-01-01'
				,'0001-01-01'
				,'Nothing'
				,'0001-01-01'
				,'0001-01-01'
				,-1
				,-1
				,'Nothing'
			)
			SET IDENTITY_INSERT HospitalDW.Pharmacy.dimMedicines Off;
			INSERT INTO HospitalDW.Pharmacy.dimMedicines(
				[medicine_ID]
				,[name]
				,[latin_name]
				,[dose]
				,[side_effects]
				,[purchase_price]
				,[sales_price]
				,[stock]
				,[medicine_type]
				,[medicine_type_description]
				,[medicineFactory_ID]
				,[production_date]
				,[expire_date]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
				,[sales_purchase]
				,[sales_purchase_description]
			)
			SELECT 
				[medicine_ID]
				,[name]
				,[latin_name]
				,[dose]
				,[side_effects]
				,[purchase_price]
				,[sales_price]
				,[stock]
				,[medicine_type]
				,[medicine_type_description]
				,[medicineFactory_ID]
				,[production_date]
				,[expire_date]
				,[additional_info]
				,@curr_date
				,NULL
				,1
				,0
				,'FirstLoad'
				FROM HospitalSA.dbo.Medicines;
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'Pharmacy.dimMedicines', 1, 'First Load was Successful', @@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'Pharmacy.dimMedicines', 0, 'First Load was Failed', @@ROWCOUNT);
			RETURN;
		END CATCH
	END
GO
------------------------------------------------------
------------------------------------------------------
CREATE OR ALTER PROCEDURE Pharmacy.dimMedicines_Loader @curr_date DATE
	AS 
	BEGIN
		BEGIN TRY
			DECLARE @RowAffected INT;
			MERGE INTO HospitalDW.Pharmacy.dimMedicines AS [Target]
			USING HospitalSA.dbo.Medicines AS Source
			ON  [Target].medicine_ID = Source.medicine_ID 
			WHEN MATCHED AND
				(
					[Target].purchase_price <> Source. purchase_price or
					[Target].sales_price <> Source. sales_price or
					[Target].stock <> Source. stock or
					[Target].production_date <> Source. production_date or
					[Target].expire_date <> Source. expire_date 
				)
			THEN UPDATE SET 
					[Target].stock = Source. stock ,
					[Target].production_date = Source. production_date ,
					[Target].expire_date = Source. expire_date ,
					end_date =case
						when ([Target].purchase_price <> Source. purchase_price or [Target].sales_price <> Source. sales_price ) and current_flag=1 then @curr_date
						else end_date
					end,
					current_flag =  case
						when ([Target].purchase_price <> Source. purchase_price or [Target].sales_price <> Source. sales_price )  then 0
						else current_flag
					end
			WHEN NOT MATCHED BY Target 
			THEN  INSERT 
			(
				[medicine_ID]
				,[name]
				,[latin_name]
				,[dose]
				,[side_effects]
				,[purchase_price]
				,[sales_price]
				,[stock]
				,[medicine_type]
				,[medicine_type_description]
				,[medicineFactory_ID]
				,[production_date]
				,[expire_date]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
				,[sales_purchase]
				,[sales_purchase_description]
			)
			VALUES 
			(
				[medicine_ID]
				,[name]
				,[latin_name]
				,[dose]
				,[side_effects]
				,[purchase_price]
				,[sales_price]
				,[stock]
				,[medicine_type]
				,[medicine_type_description]
				,[medicineFactory_ID]
				,[production_date]
				,[expire_date]
				,[additional_info]
				,@curr_date
				,NULL
				,1
				,0
				,'FirstLoad'
			);
			SET @RowAffected = @@ROWCOUNT;
			INSERT INTO HospitalDW.Pharmacy.dimMedicines
				SELECT [Target].[medicine_ID]
				,[Target].[name]
				,[Target].[latin_name]
				,[Target].[dose]
				,[Target].[side_effects]
				,Source.[purchase_price]
				,Source.[sales_price]
				,[Target].[stock]
				,[Target].[medicine_type]
				,[Target].[medicine_type_description]
				,[Target].[medicineFactory_ID]
				,[Target].[production_date]
				,[Target].[expire_date]
				,[Target].[additional_info]
				,@curr_date
				,NULL
				,1
				,case
						when [Target].purchase_price <> Source. purchase_price and [Target].sales_price <> Source. sales_price then 3
						when [Target].purchase_price <> Source. purchase_price and [Target].sales_price = Source. sales_price then 2
						when [Target].sales_price <> Source. sales_price and [Target].purchase_price = Source. purchase_price then 1
						else sales_purchase
					end
				,case
						when [Target].purchase_price <> Source. purchase_price and [Target].sales_price <> Source. sales_price then 'both'
						when [Target].purchase_price <> Source. purchase_price and [Target].sales_price = Source. sales_price then 'purchase price'
						when [Target].sales_price <> Source. sales_price and [Target].purchase_price = Source. purchase_price then 'sales price'
						else sales_purchase_description
					end
				FROM HospitalDW.Pharmacy.dimMedicines AS Target INNER JOIN HospitalSA.dbo.Medicines AS Source
				ON  [Target].medicine_ID = Source.medicine_ID 
				AND [Target].[end_date] = @curr_date;

			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'Pharmacy.dimMedicines', 1, 'Update or Insert was Successful', @@ROWCOUNT + @RowAffected);
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([date], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'Pharmacy.dimMedicines', 0, 'Update or Insert was Failed', @@ROWCOUNT);
			RETURN;
		END CATCH
	END
GO

/**************************************************************************
Pharmacy Facts
***************************************************************************/
create or alter procedure  Pharmacy.factTransactionalMedicine_FirstLoader
	as 
	begin
		begin try
			DECLARE @temp_cur_date DATE;
			declare @temp_cur_datekey int;
			declare @end_date date;
			

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);
			
			SET @temp_cur_date=(
				SELECT min(order_date)
				FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
			);
			
			--loop in days
			while @temp_cur_date<@end_date begin
				begin try
					--find TimeKey
					set @temp_cur_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=@temp_cur_date
					);
					--active patient and insurance and company
					select p.patient_code,p.patient_ID,p.insurance_ID,i.insuranceCompany_ID
					into #active_patient
					from dimPatients as p inner join dimInsurances as i on(p.insurance_ID=i.insurance_ID)
					where p.[start_date] <= @temp_cur_date and (p.current_flag=1 or p.end_date>@temp_cur_date);

					--active medicine and factory
					select medicine_code,medicine_ID,medicineFactory_ID
					into #active_medicine
					from Pharmacy.dimMedicines
					where [start_date] <= @temp_cur_date and (current_flag=1 or end_date>@temp_cur_date);

					--read this day OrderHeader 
					select o.medicineOrderHeader_ID, isnull(o.patient_ID,-1)as patient_ID
					into #tmp_order
					from HospitalSA.dbo.MedicineOrderHeaders as o
					where order_date=@temp_cur_date
					
					--find this day OrderDetails and group by header_ID and Medicine_ID
					select tmp.medicineOrderHeader_ID,tmp.patient_ID ,isnull(src.medicine_ID,-1)as medicine_ID,sum( src.[count])as total_count, sum((src.unit_price-src.insurance_portion)*src.[count])as paid_price,sum(src.unit_price*src.[count])as total_price,sum(src.insurance_portion*src.[count])as insurance_credit,sum(src.purchase_unit_price*src.[count])as factory_share,sum((src.unit_price-src.purchase_unit_price)*src.[count])as income
					into #tmp_grouped
					from #tmp_order as tmp inner join HospitalSA.dbo.MedicineOrderDetails as src on (tmp.medicineOrderHeader_ID=src.medicineOrderHeader_ID)
					group by tmp.medicineOrderHeader_ID,tmp.patient_ID, src.medicine_ID;

					--finding medicine keys
					select g.medicineOrderHeader_ID,g.patient_ID,m.medicine_code,g.medicine_ID,m.medicineFactory_ID,g.total_count,g.paid_price,g.total_price,g.insurance_credit,g.factory_share,g.income
					into #tmp_grouped_medicine
					from #tmp_grouped as g inner join #active_medicine as m on (g.medicine_ID=m.medicine_ID)


					--finding patient keys and insert to fact
					insert into Pharmacy.factTransactionalMedicine
					select a.patient_code,a.patient_ID,a.insurance_ID,a.insuranceCompany_ID,m.medicine_code,m.medicine_ID,m.medicineFactory_ID,@temp_cur_datekey,m.total_count,m.paid_price,m.total_price,m.insurance_credit,m.factory_share,m.income
					from #tmp_grouped_medicine as m inner join #active_patient as a on(m.patient_ID=a.patient_ID)

					--drop table 
					drop table #tmp_order;
					drop table #tmp_grouped;
					drop table #active_medicine;
					drop table #tmp_grouped_medicine;
					drop table #active_patient;

					insert into Logs values
					(GETDATE(),'Pharmacy.MedicineTransactionFact',1,'Transactions of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
					
					--add a day 
					set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);
					
				end try
				begin catch
					insert into Logs values
					(GETDATE(),'Pharmacy.MedicineTransactionFact',0,'ERROR : Transactions of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
				end catch
			end
			
			

			insert into Logs values
			(GETDATE(),'Pharmacy.MedicineTransactionFact',1,'New Transactions inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.MedicineTransactionFact',0,'ERROR : New Transactions may not inserted',@@ROWCOUNT);
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure  Pharmacy.factTransactionalMedicine_Loader 
	as 
	begin
		begin try
			DECLARE @temp_cur_date DATE;
			declare @temp_cur_datekey int;
			declare @end_date date;
			

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);

			SET @temp_cur_datekey=(
				SELECT max(TimeKey)
				FROM [HospitalDW].[Pharmacy].[factTransactionalMedicine]
			);
			
			set @temp_cur_date=(
			select FullDateAlternateKey
			from dbo.dimDate
			where TimeKey=@temp_cur_datekey
			);

			--loop in days
			while @temp_cur_date<@end_date begin
				begin try
					--find TimeKey
					set @temp_cur_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=@temp_cur_date
					);
					--active patient and insurance and company
					select p.patient_code,p.patient_ID,p.insurance_ID,i.insuranceCompany_ID
					into #active_patient
					from dimPatients as p inner join dimInsurances as i on(p.insurance_ID=i.insurance_ID)
					where p.[start_date] <= @temp_cur_date and (p.current_flag=1 or p.end_date>@temp_cur_date);

					--active medicine and factory
					select medicine_code,medicine_ID,medicineFactory_ID
					into #active_medicine
					from Pharmacy.dimMedicines
					where [start_date] <= @temp_cur_date and (current_flag=1 or end_date>@temp_cur_date);

					--read this day OrderHeader 
					select o.medicineOrderHeader_ID, isnull(o.patient_ID,-1)as patient_ID
					into #tmp_order
					from HospitalSA.dbo.MedicineOrderHeaders as o
					where order_date=@temp_cur_date
					
					--find this day OrderDetails and group by header_ID and Medicine_ID
					select tmp.medicineOrderHeader_ID,tmp.patient_ID ,isnull(src.medicine_ID,-1)as medicine_ID,sum( src.[count])as total_count, sum((src.unit_price-src.insurance_portion)*src.[count])as paid_price,sum(src.unit_price*src.[count])as total_price,sum(src.insurance_portion*src.[count])as insurance_credit,sum(src.purchase_unit_price*src.[count])as factory_share,sum((src.unit_price-src.purchase_unit_price)*src.[count])as income
					into #tmp_grouped
					from #tmp_order as tmp inner join HospitalSA.dbo.MedicineOrderDetails as src on (tmp.medicineOrderHeader_ID=src.medicineOrderHeader_ID)
					group by tmp.medicineOrderHeader_ID,tmp.patient_ID, src.medicine_ID;

					--finding medicine keys
					select g.medicineOrderHeader_ID,g.patient_ID,m.medicine_code,g.medicine_ID,m.medicineFactory_ID,g.total_count,g.paid_price,g.total_price,g.insurance_credit,g.factory_share,g.income
					into #tmp_grouped_medicine
					from #tmp_grouped as g inner join #active_medicine as m on (g.medicine_ID=m.medicine_ID)


					--finding patient keys and insert to fact
					insert into Pharmacy.factTransactionalMedicine
					select a.patient_code,a.patient_ID,a.insurance_ID,a.insuranceCompany_ID,m.medicine_code,m.medicine_ID,m.medicineFactory_ID,@temp_cur_datekey,m.total_count,m.paid_price,m.total_price,m.insurance_credit,m.factory_share,m.income
					from #tmp_grouped_medicine as m inner join #active_patient as a on(m.patient_ID=a.patient_ID)

					--drop table 
					drop table #tmp_order;
					drop table #tmp_grouped;
					drop table #active_medicine;
					drop table #tmp_grouped_medicine;
					drop table #active_patient;

					insert into Logs values
					(GETDATE(),'Pharmacy.MedicineTransactionFact',1,'Transactions of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
					
					--add a day 
					set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);
					
				end try
				begin catch
					insert into Logs values
					(GETDATE(),'Pharmacy.MedicineTransactionFact',0,'ERROR : Transactions of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
				end catch
			end
			
			

			insert into Logs values
			(GETDATE(),'Pharmacy.MedicineTransactionFact',1,'New Transactions inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.MedicineTransactionFact',0,'ERROR : New Transactions may not inserted',@@ROWCOUNT);
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure  Pharmacy.factMonthlyMedicine_FirstLoader
	as 
	begin
		begin try
			declare @small_curr_date date;--loop in days
			declare @small_curr_datekey int;
			declare @temp_cur_date date;--loop in month
			declare @temp_cur_datekey int;
			declare @end_month_datekey int;
			declare @end_date date;

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);

			SET @temp_cur_date=(
				SELECT min(order_date)
				FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
			);

			if(DATEADD(month, 1, @temp_cur_date)>@end_date) return;
			
			--loop in months
			while @temp_cur_date<@end_date begin
				begin try
					--find TimeKeys
					set @temp_cur_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=@temp_cur_date
					);
					set @end_month_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=DATEADD(month, 1, @temp_cur_date)
					);

					set @small_curr_date=@temp_cur_date;
					set @small_curr_datekey=@temp_cur_datekey;

					--transactions of this day
						select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price)as total_paid_price,sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,sum(income)as total_income,count(patient_ID)as number_of_patients_bought
						into #tmp_grouped_day
						from Pharmacy.factTransactionalMedicine
						where TimeKey=@small_curr_datekey
						group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

						--add day
						set @small_curr_date=DATEADD(day, 1, @small_curr_date);
						set @small_curr_datekey=(
							select TimeKey
							from dbo.dimDate
							where FullDateAlternateKey=@small_curr_date
						);

					--loop in days
					while @small_curr_date<DATEADD(month, 1, @temp_cur_date) begin
						
						--transactions of this day
						insert into  #tmp_grouped_day
						select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price)as total_paid_price,sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,sum(income)as total_income,count(patient_ID)as number_of_patients_bought
						
						from Pharmacy.factTransactionalMedicine
						where TimeKey=@small_curr_datekey
						group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

						--add day
						set @small_curr_date=DATEADD(day, 1, @small_curr_date);
						set @small_curr_datekey=(
							select TimeKey
							from dbo.dimDate
							where FullDateAlternateKey=@small_curr_date
						);
					end

					
					--group by
					select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(total_number_bought)as total_number_bought,sum(total_paid_price)as total_paid_price,sum(total_real_price)as total_real_price,sum(total_insurance_credit)as total_insurance_credit,sum(total_factory_share)as total_factory_share,sum(total_income)as total_income,count(number_of_patients_bought)as number_of_patients_bought
					into #tmp_grouped
					from #tmp_grouped_day
					group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

					--this month medicine
					select medicine_ID ,max( [start_date]) as [start_date]
					into #tmp_active_medicine
					from Pharmacy.dimMedicines
					where [start_date]<DATEADD(month, 1, @temp_cur_date) and (current_flag=1 or [end_date]>=@temp_cur_date )
					group by medicine_ID;

					--
					select m.medicine_code,m.medicine_ID,m.medicineFactory_ID
					into #tmp_medicine
					from Pharmacy.dimMedicines as m inner join #tmp_active_medicine as a on(m.medicine_ID=a.medicine_ID and a.[start_date]=m.[start_date] and m.medicine_code<>-1);

					--Medicine X InsuranceCompanies
					select t.insuranceCompany_ID ,m.medicine_code,m.medicine_ID,m.medicineFactory_ID
					into #tmp_kartezian
					from #tmp_medicine as m , dbo.dimInsuranceCompanies as t
					where m.medicine_code<>-1 and t.insuranceCompany_ID<>-1;
					
					--insert
					insert into Pharmacy.factMonthlyMedicine
					select i.insuranceCompany_ID,i.medicine_code,i.medicine_ID,i.medicineFactory_ID,@temp_cur_datekey,isnull(t.total_number_bought,0)as total_number_bought,isnull(t.total_paid_price,0)as total_paid_price,isnull(t.total_real_price,0)as total_real_price,isnull(t.total_insurance_credit,0)as total_insurance_credit,isnull(t.total_factory_share,0)as total_factory_share,isnull(t.total_income,0)as total_income,isnull(t.number_of_patients_bought,0)as number_of_patients_bought
					from #tmp_kartezian as i left join #tmp_grouped as t on(i.insuranceCompany_ID=t.insuranceCompany_ID and t.medicine_ID=i.medicine_ID and t.medicineFactory_ID=i.medicineFactory_ID)

					--drop tables
				drop table #tmp_grouped_day;
				drop table #tmp_grouped;
				drop table #tmp_active_medicine;
				drop table #tmp_medicine;
				drop table #tmp_kartezian;

					insert into Logs values
					(GETDATE(),'Pharmacy.factMonthlyMedicine',1,'Records of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
					
					--add a day 
					set @temp_cur_date=DATEADD(month, 1, @temp_cur_date);
					
				end try
				begin catch
					insert into Logs values
					(GETDATE(),'Pharmacy.factMonthlyMedicine',0,'ERROR : Records of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
				end catch
			end
			

			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',1,'New Records inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',0,'ERROR : New Records may not inserted',@@ROWCOUNT);
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure  Pharmacy.factMonthlyMedicine_Loader 
	as 
	begin
		begin try
			declare @small_curr_date date;--loop in days
			declare @small_curr_datekey int;
			declare @temp_cur_date date;--loop in month
			declare @temp_cur_datekey int;
			declare @end_month_datekey int;
			declare @end_date date;

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);

			declare @month_count int;
			set @month_count=(select count(*) from Pharmacy.factMonthlyMedicine);
			if @month_count=0 begin
				SET @temp_cur_date=(
				SELECT min(order_date)
				FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
			);
			end
			else begin
				SET @temp_cur_datekey=(
					SELECT max(TimeKey)
					FROM [HospitalDW].[Pharmacy].[factMonthlyMedicine]
				);
				set @temp_cur_date=(select DATEADD(month, 1, FullDateAlternateKey)  from dbo.dimDate where TimeKey=@temp_cur_datekey);
				set @temp_cur_datekey=(select TimeKey  from dbo.dimDate where FullDateAlternateKey=@temp_cur_date);
			end

			if(DATEADD(month, 1, @temp_cur_date)>@end_date) return;
			
			--loop in months
			while @temp_cur_date<@end_date begin
				begin try
					--find TimeKeys
					set @temp_cur_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=@temp_cur_date
					);
					set @end_month_datekey=(
						select TimeKey
						from dbo.dimDate
						where FullDateAlternateKey=DATEADD(month, 1, @temp_cur_date)
					);

					set @small_curr_date=@temp_cur_date;
					set @small_curr_datekey=@temp_cur_datekey;
					--transactions of this day
						select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price)as total_paid_price,sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,sum(income)as total_income,count(patient_ID)as number_of_patients_bought
						into #tmp_grouped_day
						from Pharmacy.factTransactionalMedicine
						where TimeKey=@small_curr_datekey
						group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

						--add day
						set @small_curr_date=DATEADD(day, 1, @small_curr_date);
						set @small_curr_datekey=(
							select TimeKey
							from dbo.dimDate
							where FullDateAlternateKey=@small_curr_date
						);

					--loop in days
					while @small_curr_date<DATEADD(month, 1, @temp_cur_date) begin
						
						--transactions of this day
						insert into  #tmp_grouped_day
						select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price)as total_paid_price,sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,sum(income)as total_income,count(patient_ID)as number_of_patients_bought
						
						from Pharmacy.factTransactionalMedicine
						where TimeKey=@small_curr_datekey
						group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

						--add day
						set @small_curr_date=DATEADD(day, 1, @small_curr_date);
						set @small_curr_datekey=(
							select TimeKey
							from dbo.dimDate
							where FullDateAlternateKey=@small_curr_date
						);
					end

					
					--group by
					select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(total_number_bought)as total_number_bought,sum(total_paid_price)as total_paid_price,sum(total_real_price)as total_real_price,sum(total_insurance_credit)as total_insurance_credit,sum(total_factory_share)as total_factory_share,sum(total_income)as total_income,count(number_of_patients_bought)as number_of_patients_bought
					into #tmp_grouped
					from #tmp_grouped_day
					group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

					--this month medicine
					select medicine_ID ,max( [start_date]) as [start_date]
					into #tmp_active_medicine
					from Pharmacy.dimMedicines
					where [start_date]<DATEADD(month, 1, @temp_cur_date) and (current_flag=1 or [end_date]>=@temp_cur_date )
					group by medicine_ID;

					--
					select m.medicine_code,m.medicine_ID,m.medicineFactory_ID
					into #tmp_medicine
					from Pharmacy.dimMedicines as m inner join #tmp_active_medicine as a on(m.medicine_ID=a.medicine_ID and a.[start_date]=m.[start_date] and m.medicine_code<>-1);

					--Medicine X InsuranceCompanies
					select t.insuranceCompany_ID ,m.medicine_code,m.medicine_ID,m.medicineFactory_ID
					into #tmp_kartezian
					from #tmp_medicine as m , dbo.dimInsuranceCompanies as t
					where m.medicine_code<>-1 and t.insuranceCompany_ID<>-1;
					
					--insert
					insert into Pharmacy.factMonthlyMedicine
					select i.insuranceCompany_ID,i.medicine_code,i.medicine_ID,i.medicineFactory_ID,@temp_cur_datekey,isnull(t.total_number_bought,0)as total_number_bought,isnull(t.total_paid_price,0)as total_paid_price,isnull(t.total_real_price,0)as total_real_price,isnull(t.total_insurance_credit,0)as total_insurance_credit,isnull(t.total_factory_share,0)as total_factory_share,isnull(t.total_income,0)as total_income,isnull(t.number_of_patients_bought,0)as number_of_patients_bought
					from #tmp_kartezian as i left join #tmp_grouped as t on(i.insuranceCompany_ID=t.insuranceCompany_ID and t.medicine_ID=i.medicine_ID and t.medicineFactory_ID=i.medicineFactory_ID)

					--drop tables
				drop table #tmp_grouped_day;
				drop table #tmp_grouped;
				drop table #tmp_active_medicine;
				drop table #tmp_medicine;
				drop table #tmp_kartezian;

					insert into Logs values
					(GETDATE(),'Pharmacy.factMonthlyMedicine',1,'Records of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
					
					--add a day 
					set @temp_cur_date=DATEADD(month, 1, @temp_cur_date);
					
				end try
				begin catch
					insert into Logs values
					(GETDATE(),'Pharmacy.factMonthlyMedicine',0,'ERROR : Records of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
				end catch
			end
		

			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',1,'New Records inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',0,'ERROR : New Records may not inserted',@@ROWCOUNT);
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure  Pharmacy.factAccumulativeMedicine_FirstLoader 
	as 
	begin
		begin try
			declare @temp_cur_date date;
			declare @temp_cur_datekey int;
			declare @end_date date;
			declare @end_datekey int;

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);
			SET @temp_cur_date=(
				SELECT min(order_date)
				FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
			);

			--kartezian
			select i.insuranceCompany_ID,m.medicine_code,m.medicine_ID,m.medicineFactory_ID,0 as total_number_bought,0 as total_paid_price,
					0 as total_real_price,0 as total_insurance_credit, 0 as total_factory_share,0 as total_income,0 as number_of_patients_bought
			into #temp1
			from dbo.dimInsuranceCompanies as i,Pharmacy.dimMedicines as m
			where i.insuranceCompany_ID<>-1 and m.medicine_code<>-1 and m.current_flag=1

			while @temp_cur_date<@end_date begin
				--curr datekey
				set @temp_cur_datekey=(select TimeKey from dbo.dimDate where FullDateAlternateKey=@temp_cur_date);

				
				--this day transactions
				
				select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price) as total_paid_price,
						sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,
						sum(income)as total_income, count(patient_ID) as number_of_patients_bought
				into #temp2
				from Pharmacy.factTransactionalMedicine
				where TimeKey=@temp_cur_datekey
				group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

				--
				select *
				into #temp3
				from #temp1
				--
				truncate table #temp1;
				

				insert  into #temp1
				select s.insuranceCompany_ID,s.medicine_code,s.medicine_ID,s.medicineFactory_ID,isnull(n.total_number_bought,0)+s.total_number_bought as total_number_bought,isnull(n.total_paid_price,0)+s.total_paid_price as total_paid_price,
						isnull(n.total_real_price,0)+s.total_real_price as total_real_price,isnull(n.total_insurance_credit,0)+s.total_insurance_credit as total_insurance_credit,isnull(n.total_factory_share,0)+s.total_factory_share as total_factory_share,
						isnull(n.total_income,0)+s.total_income as total_income, isnull(n.number_of_patients_bought,0)+s.number_of_patients_bought as number_of_patients_bought
				
				from #temp3 as s left join #temp2 as n on(s.insuranceCompany_ID=n.insuranceCompany_ID and s.medicine_ID=n.medicine_ID and s.medicineFactory_ID=n.medicineFactory_ID)
				
				--add day
				set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);

				drop table #temp2;
				drop table #temp3;

				insert into Logs values
			(GETDATE(),'Pharmacy.factAccumulativeMedicine',1,'New Records of'+convert(varchar,@temp_cur_date)+' calculated',@@ROWCOUNT);
			
			end
			--select * from Logs;

			--insert to fact
			insert into Pharmacy.factAccumulativeMedicine
			select insuranceCompany_ID,medicine_code,medicine_ID,medicineFactory_ID,total_number_bought,total_paid_price,
					total_real_price,total_insurance_credit,total_factory_share,total_income,number_of_patients_bought
			from #temp1;

			--drop tables
			drop table #temp1;

			insert into Logs values
			(GETDATE(),'Pharmacy.factAccumulativeMedicine',1,'New Records inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.factAccumulativeMedicine',0,'ERROR : New Records may not inserted',@@ROWCOUNT);
		end catch
	end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure  Pharmacy.factAccumulativeMedicine_Loader @cur_date date
	as 
	begin
		begin try

			declare @temp_cur_date date;
			declare @temp_cur_datekey int;
			declare @end_date date;
			declare @end_datekey int;

			--set end_date and current_date
			set @end_date=(
				select max(order_date)
				from HospitalSA.dbo.MedicineOrderHeaders
			);
			set @temp_cur_date=@cur_date;

			--kartezian
			select i.insuranceCompany_ID,m.medicine_code,m.medicine_ID,m.medicineFactory_ID
			into #kartezian
			from dbo.dimInsuranceCompanies as i,Pharmacy.dimMedicines as m
			where i.insuranceCompany_ID<>-1 and m.medicine_code<>-1 and m.current_flag=1

			--#temp1
			select k.insuranceCompany_ID,k.medicine_code,k.medicine_ID,k.medicineFactory_ID,isnull( total_number_bought,0)as total_number_bought, isnull( total_paid_price,0)as total_paid_price,
					isnull(total_real_price,0) as total_real_price,isnull(total_insurance_credit,0) as total_insurance_credit, isnull(total_factory_share,0) as total_factory_share,isnull(total_income,0) as total_income,isnull(number_of_patients_bought,0) as number_of_patients_bought
			into #temp1
			from #kartezian as k left join Pharmacy.factAccumulativeMedicine as a on(k.insuranceCompany_ID=a.insuranceCompany_ID and k.medicine_ID=a.medicine_ID and k.medicineFactory_ID=a.medicineFactory_ID)

			


			while @temp_cur_date<@end_date begin
				--curr datekey
				set @temp_cur_datekey=(select TimeKey from dbo.dimDate where FullDateAlternateKey=@temp_cur_date);

				--this day transactions
				
				select insuranceCompany_ID,medicine_ID,medicineFactory_ID,sum(number_of_units_bought)as total_number_bought,sum(paid_price) as total_paid_price,
						sum(real_price)as total_real_price,sum(insurance_credit)as total_insurance_credit,sum(factory_share)as total_factory_share,
						sum(income)as total_income, count(patient_ID) as number_of_patients_bought
				into #temp2
				from Pharmacy.factTransactionalMedicine
				where TimeKey=@temp_cur_datekey
				group by insuranceCompany_ID,medicine_ID,medicineFactory_ID;

				--
				select *
				into #temp3
				from #temp1
				--
				truncate table #temp1

				insert into #temp1
				select s.insuranceCompany_ID,s.medicine_code,s.medicine_ID,s.medicineFactory_ID,isnull(n.total_number_bought,0)+s.total_number_bought,isnull(n.total_paid_price,0)+s.total_paid_price ,
						isnull(n.total_real_price,0)+s.total_real_price,isnull(n.total_insurance_credit,0)+s.total_insurance_credit,isnull(n.total_factory_share,0)+s.total_factory_share ,
						isnull(n.total_income,0)+s.total_income, isnull(n.number_of_patients_bought,0)+s.number_of_patients_bought
				from #temp3 as s left join #temp2 as n on(s.insuranceCompany_ID=n.insuranceCompany_ID and s.medicine_ID=n.medicine_ID and s.medicineFactory_ID=n.medicineFactory_ID)
			
				--add day
				set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);

				drop table #temp2;
				drop table #temp3;

			end

			--insert to fact
			insert into Pharmacy.factAccumulativeMedicine
			select insuranceCompany_ID,medicine_code,medicine_ID,medicineFactory_ID,total_number_bought,total_paid_price,
					total_real_price,total_insurance_credit,total_factory_share,total_income,number_of_patients_bought
			from #temp1;

			--drop tables
			drop table #temp1;
			

			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',1,'New Records inserted',@@ROWCOUNT);
		end try
		begin catch
			insert into Logs values
			(GETDATE(),'Pharmacy.factMonthlyMedicine',0,'ERROR : New Records may not inserted',@@ROWCOUNT);
		end catch
	end
go

/**************************************************************************
Pharmacy Main Procedures
***************************************************************************/
create or alter procedure Pharmacy.FirstLoad as
begin
	begin try
		declare @curr_date date;
		SET @curr_date=(
					SELECT min(order_date)
					FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
				);
		exec Pharmacy.dimMedicineFactory_FirstLoader @curr_date;
		exec Pharmacy.dimMedicines_FirstLoader @curr_date;
		exec Pharmacy.factTransactionalMedicine_FirstLoader;
		exec Pharmacy.factMonthlyMedicine_FirstLoader;
		exec Pharmacy.factAccumulativeMedicine_FirstLoader;

		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'Pharmacy Tables'
				,1
				,'First Load insertions was successful'
				,@@ROWCOUNT
			);
	end try
	begin catch
		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'Pharmacy Tables'
				,0
				,'ERROR : First Load insertions FAILED'
				,@@ROWCOUNT
			);
	end catch

end
go
------------------------------------------------------
------------------------------------------------------
create or alter procedure Pharmacy.[Load] as
begin
	begin try
		declare @curr_date date;
		declare @curr_datekey int;
		SET @curr_datekey=(
					SELECT max(TimeKey)
					FROM Pharmacy.[factTransactionalMedicine]
				);
		set @curr_date=(select DATEADD(day, 1, FullDateAlternateKey) from dbo.dimDate where TimeKey=@curr_datekey);

		exec Pharmacy.dimMedicineFactory_Loader @curr_date;
		exec Pharmacy.dimMedicines_Loader @curr_date;
		exec Pharmacy.factTransactionalMedicine_Loader;
		exec Pharmacy.factMonthlyMedicine_Loader;
		exec Pharmacy.factAccumulativeMedicine_Loader @curr_date;

		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'Pharmacy Tables'
				,1
				,'Load insertions was successful'
				,@@ROWCOUNT
			);
	end try
	begin catch
		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'Pharmacy Tables'
				,0
				,'ERROR : Load insertions FAILED'
				,@@ROWCOUNT
			);
	end catch

end
go

/*###########################################################################
								Clinic Mart
###########################################################################*/

/**************************************************************************
Clinic Dimentions
***************************************************************************/
-- Dimensions First Loader Procedures
CREATE OR ALTER PROCEDURE Clinic.dimDepartments_FirstLoader
	AS
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.dimDepartments

			INSERT INTO Clinic.dimDepartments
				VALUES(-1,'Unknown','Unknown','Unknown',
					   NULL,'Unknown','Unknown',NULL,
					   'Unknown','Unknown','Unknown',NULL,
					   NULL,'Unknown',NULL,'Unknown')

			INSERT INTO Clinic.dimDepartments
				SELECT 	[department_ID]
						,[name]
						,[description]
						,NULL
						,NULL
						,[chairman]
						,NULL
						,NULL
						,[assistant]
						,[chairman_phone_number]
						,[assistant_phone_number]
						,[chairman_room]
						,[assistant_room]
						,[reception_phone_number]
						,[budget]
						,[additional_info]
				FROM HospitalSA.dbo.Departments
		---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDepartments'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDepartments', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimDoctorContracts_FirstLoader
	AS
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.dimDoctorContracts

			INSERT INTO Clinic.dimDoctorContracts
				VALUES(-1,NULL,NULL,NULL,NULL,NULL,'Unknown','Unknown')

			INSERT INTO Clinic.dimDoctorContracts
				SELECT 	[doctorContract_ID]
						,[contract_start_date]
						,[contract_end_date]
						,[appointment_portion]
						,[salary]
						,[active]
						,[active_description]
						,[additional_info]
				FROM HospitalSA.dbo.DoctorContracts
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDoctorContracts'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDoctorContracts', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimDoctors_FirstLoader @curr_date DATE
	AS
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.dimDoctors

			INSERT INTO [Clinic].[dimDoctors]
					([doctor_ID]
					,[doctorContract_ID]
					,[national_code]
					,[license_code]
					,[first_name]
					,[last_name]
					,[birthdate]
					,[phone_number]
					,[department_ID]
					,[department_name]
					,[education_degree]
					,[specialty_description]
					,[graduation_date]
					,[university]
					,[gender]
					,[religion]
					,[nationality]
					,[marital_status]
					,[marital_status_description]
					,[postal_code]
					,[address]
					,[additional_info]
					,[start_date]
					,[end_date]
					,[current_flag]
					,[Contract_Degree]
					,[Contract_Degree_description])
				VALUES
					(-1
					,-1
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,NULL
					,'Unknown'
					,-1
					,'Unknown'
					,NULL
					,'Unknown'
					,NULL
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,NULL
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,'Unknown'
					,NULL
					,NULL
					,1
					,-1
					,'Unknown')

			INSERT INTO Clinic.dimDoctors(
						 [doctor_ID],[doctorContract_ID],[national_code]
						,[license_code],[first_name],[last_name]
						,[birthdate],[phone_number],[department_ID]
						,[department_name],[education_degree]
						,[specialty_description],[graduation_date]
						,[university],[gender],[religion],[nationality]
						,[marital_status],[marital_status_description]
						,[postal_code],[address],[additional_info]
						,[start_date],[end_date],[current_flag]
						,[Contract_Degree],[Contract_Degree_description])

				SELECT 	 [doctor_ID]
						,[doctorContract_ID]
						,[national_code]
						,[license_code]
						,[first_name]
						,[last_name]
						,[birthdate]
						,[phone_number]
						,doc.[department_ID]
						,dep.[name]
						,[education_degree]
						,[specialty_description]
						,[graduation_date]
						,[university]
						,[gender]
						,[religion]
						,[nationality]
						,[marital_status]
						,[marital_status_description]
						,[postal_code]
						,[address]
						,doc.[additional_info]
						,@curr_date
						,NULL
						,1
						,0 AS [Contract_Degree]
						,'First Load'
				FROM HospitalSA.dbo.Doctors doc 
				INNER JOIN HospitalSA.dbo.Departments dep 
				ON doc.department_ID = dep.department_ID
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDoctors'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH 
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDoctors', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimIllnessTypes_FirstLoader
	AS 
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.dimIllnessTypes

			INSERT INTO Clinic.dimIllnessTypes
				VALUES(-1,'Unknown','Unknown',-1)

			INSERT INTO Clinic.dimIllnessTypes
				SELECT  [illnessType_ID]
						,[name]
						,[description]
						,[related_department_ID]
				FROM HospitalSA.dbo.IllnessTypes
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimIllnessTypes'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimIllnessTypes', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimIllnesses_FirstLoader
	AS
	BEGIN
		BEGIN TRY 
			TRUNCATE TABLE Clinic.dimIllnesses

			INSERT INTO Clinic.dimIllnesses
				VALUES(-1,'Unknown',-1,'Unknown','Unknown'
					   ,NULL,'Unknown',NULL,'Unknown',NULL,'Unknown')

			INSERT INTO Clinic.dimIllnesses
				SELECT   [illness_ID]
						,i.[name]
						,i.[illnessType_ID]
						,it.[name] AS [illnessType_name]
						,[scientific_name]
						,[special_illness]
						,[special_illness_description]
						,[killing_status]
						,[killing_description]
						,[chronic]
						,[chronic_description]
				FROM HospitalSA.dbo.Illnesses i
				INNER JOIN HospitalSA.dbo.IllnessTypes it
				ON i.illnessType_ID = it.illnessType_ID
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimIllnesses'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH 
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimIllnesses', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

-- Dimensions Usual Loader Procedures
CREATE OR ALTER PROCEDURE Clinic.dimDepartments_Loader @curr_date DATE
	AS
	BEGIN
		BEGIN TRY
			MERGE Clinic.dimDepartments AS dw
			USING HospitalSA.dbo.Departments AS sa 
			ON dw.department_ID = sa.department_ID

			WHEN MATCHED AND (
				dw.current_chairman	<> sa.chairman
				OR dw.current_assistant <> sa.assistant
				OR dw.chairman_phone_number <> sa.chairman_phone_number
				OR dw.assistant_phone_number <> sa.assistant_phone_number
				OR dw.reception_phone_number <> sa.reception_phone_number
			) 
			THEN UPDATE SET 
				-- SCD3
				dw.previous_chairman = 	CASE 
											WHEN dw.current_chairman <> sa.chairman 
												THEN dw.current_chairman 
											ELSE dw.previous_chairman
									 	END,
				dw.chairman_change_date = 	CASE 
												WHEN dw.current_chairman <> sa.chairman 
													THEN @curr_date 
												ELSE dw.chairman_change_date
									 		END,
				dw.current_chairman	= 	CASE 
											WHEN dw.current_chairman <> sa.chairman 
												THEN sa.chairman 
											ELSE dw.current_chairman
									 	END,
				dw.previous_assistant = CASE 
											WHEN dw.current_assistant <> sa.assistant 
												THEN dw.current_assistant
											ELSE dw.previous_assistant
									 	END,
				dw.assistant_change_date = 	CASE 
												WHEN dw.current_assistant <> sa.assistant 
													THEN @curr_date
												ELSE dw.assistant_change_date
									 		END,
				dw.current_assistant = 	CASE 
											WHEN dw.current_assistant <> sa.assistant 
												THEN sa.assistant
											ELSE dw.current_assistant
									 	END,
				-- SCD1
				dw.chairman_phone_number = sa.chairman_phone_number,
				dw.assistant_phone_number = sa.assistant_phone_number,
				dw.reception_phone_number = sa.reception_phone_number
			WHEN NOT MATCHED BY TARGET 
			THEN INSERT (
				 [department_ID]
				,[name]
				,[description]
				,[previous_chairman]
				,[chairman_change_date]
				,[current_chairman]
				,[previous_assistant]
				,[assistant_change_date]
				,[current_assistant]
				,[chairman_phone_number]
				,[assistant_phone_number]
				,[chairman_room]
				,[assistant_room]
				,[reception_phone_number]
				,[budget]
				,[additional_info]
			) VALUES (
				 sa.[department_ID]
				,sa.[name]
				,sa.[description]
				,NULL
				,NULL
				,sa.[chairman]
				,NULL
				,NULL
				,sa.[assistant]
				,sa.[chairman_phone_number]
				,sa.[assistant_phone_number]
				,sa.[chairman_room]
				,sa.[assistant_room]
				,sa.[reception_phone_number]
				,sa.[budget]
				,sa.[additional_info]
			);
		---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDepartments'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDepartments', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimDoctorContracts_Loader
	AS
	BEGIN
		BEGIN TRY
			MERGE Clinic.dimDoctorContracts AS dw
			USING HospitalSA.dbo.DoctorContracts AS sa 
			ON dw.doctorContract_ID = sa.doctorContract_ID
			WHEN NOT MATCHED BY TARGET 
			THEN INSERT (
				 [doctorContract_ID]
				,[contract_start_date]
				,[contract_end_date]
				,[appointment_portion]
				,[salary]
				,[active]
				,[active_description]
				,[additional_info]
			) VALUES (
				 sa.[doctorContract_ID]
				,sa.[contract_start_date]
				,sa.[contract_end_date]
				,sa.[appointment_portion]
				,sa.[salary]
				,sa.[active]
				,sa.[active_description]
				,sa.[additional_info]
			);
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDoctorContracts'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDoctorContracts', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimDoctors_Loader @curr_date DATE
	AS
	BEGIN
		BEGIN TRY
			DECLARE @RowAffected INT;
			SET @RowAffected = 0;

			SELECT 	 [doctor_ID]
					,[doctorContract_ID]
					,[national_code]
					,[license_code]
					,[first_name]
					,[last_name]
					,[birthdate]
					,[phone_number]
					,doc.[department_ID]
					,dep.[name] as [department_name]
					,[education_degree]
					,[specialty_description]
					,[graduation_date]
					,[university]
					,[gender]
					,[religion]
					,[nationality]
					,[marital_status]
					,[marital_status_description]
					,[postal_code]
					,[address]
					,doc.[additional_info]
					,@curr_date as [start_date]
					,NULL as[end_date]
					,1 as [current_flag]
					,0 as [Contract_Degree]
					,'FirstLoad'as [Contract_Degree_description]
			INTO #tmp
			FROM HospitalSA.dbo.Doctors doc
			INNER JOIN HospitalSA.dbo.Departments dep
			ON doc.department_ID = dep.department_ID

			MERGE INTO Clinic.dimDoctors AS dw
			USING #tmp AS sa
			ON  dw.doctor_ID = sa.doctor_ID 
			AND dw.[current_flag] = 1

			WHEN MATCHED AND(
				dw.doctorContract_ID <> sa.doctorContract_ID 
				OR dw.education_degree <> sa.education_degree
				OR dw.phone_number <> sa.phone_number
			)
			THEN UPDATE SET 
				-- SCD2
				end_date = 	CASE
								WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
								OR dw.education_degree <> sa.education_degree
								THEN @curr_date
								ELSE dw.end_date
							END, 
				current_flag = 	CASE
									WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
									OR dw.education_degree <> sa.education_degree
									THEN 0
									ELSE 1
								END,
				Contract_Degree = CASE
									WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
									AND dw.education_degree = sa.education_degree
									THEN 1
									WHEN dw.doctorContract_ID = sa.doctorContract_ID 
									AND dw.education_degree <> sa.education_degree
									THEN 2
									WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
									AND dw.education_degree <> sa.education_degree
									THEN 3
									ELSE 0
								  END,
				Contract_Degree_description = CASE
									WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
									AND dw.education_degree = sa.education_degree
									THEN 'Contract'
									WHEN dw.doctorContract_ID = sa.doctorContract_ID 
									AND dw.education_degree <> sa.education_degree
									THEN 'Degree'
									WHEN dw.doctorContract_ID <> sa.doctorContract_ID 
									AND dw.education_degree <> sa.education_degree
									THEN 'Both'
									ELSE 'First Load'
								  END,
				-- SCD1
				dw.phone_number = sa.phone_number
			WHEN NOT MATCHED BY Target 
			THEN  INSERT 
			(
				 [doctor_ID]
				,[doctorContract_ID]
				,[national_code]
				,[license_code]
				,[first_name]
				,[last_name]
				,[birthdate]
				,[phone_number]
				,[department_ID]
				,[department_name]
				,[education_degree]
				,[specialty_description]
				,[graduation_date]
				,[university]
				,[gender]
				,[religion]
				,[nationality]
				,[marital_status]
				,[marital_status_description]
				,[postal_code]
				,[address]
				,[additional_info]
				,[start_date]
				,[end_date]
				,[current_flag]
				,[Contract_Degree]
				,[Contract_Degree_description]
			)
			VALUES 
			(
				 sa.[doctor_ID]
				,sa.[doctorContract_ID]
				,sa.[national_code]
				,sa.[license_code]
				,sa.[first_name]
				,sa.[last_name]
				,sa.[birthdate]
				,sa.[phone_number]
				,sa.[department_ID]
				,sa.[department_name]
				,sa.[education_degree]
				,sa.[specialty_description]
				,sa.[graduation_date]
				,sa.[university]
				,sa.[gender]
				,sa.[religion]
				,sa.[nationality]
				,sa.[marital_status]
				,sa.[marital_status_description]
				,sa.[postal_code]
				,sa.[address]
				,sa.[additional_info]
				,@curr_date
				,NULL
				,1
				,0
				,'First Load'
			);
			SET @RowAffected = @@ROWCOUNT;
			INSERT INTO HospitalDW.Clinic.dimDoctors
				SELECT   sa.[doctor_ID]
						,sa.[doctorContract_ID]
						,sa.[national_code]
						,sa.[license_code]
						,sa.[first_name]
						,sa.[last_name]
						,sa.[birthdate]
						,sa.[phone_number]
						,sa.[department_ID]
						,sa.[department_name]
						,sa.[education_degree]
						,sa.[specialty_description]
						,sa.[graduation_date]
						,sa.[university]
						,sa.[gender]
						,sa.[religion]
						,sa.[nationality]
						,sa.[marital_status]
						,sa.[marital_status_description]
						,sa.[postal_code]
						,sa.[address]
						,sa.[additional_info]
						,@curr_date
						,NULL
						,1
						,0
						,'First Load'
				FROM HospitalDW.Clinic.dimDoctors dw 
				INNER JOIN #tmp sa
				ON dw.doctor_ID = sa.doctor_ID 
				AND dw.[end_date] = @curr_date;

			DROP TABLE #tmp;
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimDoctors'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT + @RowAffected)
		END TRY
		BEGIN CATCH 
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimDoctors', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT + @RowAffected);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimIllnessTypes_Loader
	AS 
	BEGIN
		BEGIN TRY
			MERGE Clinic.dimIllnessTypes AS dw
			USING HospitalSA.dbo.IllnessTypes AS sa 
			ON dw.illnessType_ID = sa.illnessType_ID
			WHEN NOT MATCHED BY TARGET 
			THEN INSERT (
				 [illnessType_ID]
				,[name]
				,[description]
				,[related_department_ID]
			) VALUES (
				 sa.[illnessType_ID]
				,sa.[name]
				,sa.[description]
				,sa.[related_department_ID]
			);
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimIllnessTypes'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimIllnessTypes', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.dimIllnesses_Loader
	AS
	BEGIN
		BEGIN TRY 
			SELECT [illness_ID]
					,i.[name]
					,i.[illnessType_ID]
					,it.[name] AS [illnessType_name]
					,[scientific_name]
					,[special_illness]
					,[special_illness_description]
					,[killing_status]
					,[killing_description]
					,[chronic]
					,[chronic_description]
			INTO #tmp
			FROM HospitalSA.dbo.Illnesses i
			INNER JOIN HospitalSA.dbo.IllnessTypes it
			ON i.illnessType_ID = it.illnessType_ID

			MERGE Clinic.dimIllnesses AS dw
			USING #tmp AS sa 
			ON dw.illness_ID = sa.illness_ID
			WHEN NOT MATCHED BY TARGET 
			THEN INSERT (
				[illness_ID]
				,[name]
				,[illnessType_ID]
				,[scientific_name]
				,[special_illness]
				,[special_illness_description]
				,[killing_status]
				,[killing_description]
				,[chronic]
				,[chronic_description]
			) VALUES (
				 [illness_ID]
				,[name]
				,[illnessType_ID]
				,[scientific_name]
				,[special_illness]
				,[special_illness_description]
				,[killing_status]
				,[killing_description]
				,[chronic]
				,[chronic_description]
			);

			DROP TABLE #tmp;
			---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'dimIllnesses'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH 
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'dimIllnesses', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

/**************************************************************************
Clinic Facts
***************************************************************************/
-- Facts First Loader Procedures
CREATE OR ALTER PROCEDURE Clinic.factTransactionAppointment_FirstLoader
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_key INT;
			DECLARE @end_date DATE;

			SET @curr_date = (
				SELECT MIN(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			TRUNCATE TABLE Clinic.factTransactionAppointment

			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);

					SELECT ISNULL(patient_ID,-1) AS patient_ID,
						   ISNULL(doctor_ID,-1) AS doctor_ID,
						   ISNULL(main_detected_illness,-1) AS main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp_today_appointments
					FROM HospitalSA.dbo.Appointments
					WHERE appointment_date = @curr_date
					
					SELECT p.patient_code,
						   p.patient_ID,
						   p.insurance_ID,
						   i.insuranceCompany_ID
					INTO #tmp_patient_info
					FROM dbo.dimPatients p 
						INNER JOIN dbo.dimInsurances i 
						ON p.insurance_ID = i.insurance_ID
					WHERE p.[start_date] <= @curr_date 
						AND (p.current_flag = 1 
							 OR p.end_date > @curr_date);
					
					SELECT patient_ID,
						   doctor_code,
						   d.doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   a.additional_info 
					INTO #tmp1
					FROM Clinic.dimDoctors d
						INNER JOIN #tmp_today_appointments a
						ON d.doctor_ID = a.doctor_ID
					WHERE [start_date] <= @curr_date 
						AND (current_flag = 1 
							 OR end_date > @curr_date);

					SELECT p.patient_code,
						   p.patient_ID,
						   p.insurance_ID,
						   p.insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp2
					FROM #tmp_patient_info p
						INNER JOIN #tmp1 d
						ON d.patient_ID = p.patient_ID

					SELECT t.patient_code,
						   t.patient_ID,
						   t.insurance_ID,
						   t.insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   i.illnessType_ID,
						   @curr_date_key AS TimeKey,
						   ---------------
						   price - insurance_share AS paid_price,
						   price AS real_price,
						   doctor_share,
						   insurance_share,
						   price - doctor_share AS income,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp3
					FROM #tmp2 t
						INNER JOIN Clinic.dimIllnesses i
						ON i.illness_ID = t.main_detected_illness

					INSERT INTO Clinic.factTransactionAppointment
						SELECT patient_code,
						   patient_ID,
						   insurance_ID,
						   insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   illnessType_ID,
						   TimeKey,
						   ---------------
						   paid_price,
						   real_price,
						   doctor_share,
						   insurance_share,
						   income,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
						FROM #tmp3
					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factTransactionAppointment',
							1,
							'Transactions of '+CONVERT(VARCHAR,@curr_date)+' inserted',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_today_appointments
					DROP TABLE #tmp_patient_info
					DROP TABLE #tmp1
					DROP TABLE #tmp2
					DROP TABLE #tmp3

				END TRY
				BEGIN CATCH
					--drop temporary tables
					DROP TABLE IF EXISTS #tmp_today_appointments
					DROP TABLE IF EXISTS #tmp_patient_info
					DROP TABLE IF EXISTS #tmp1
					DROP TABLE IF EXISTS #tmp2
					DROP TABLE IF EXISTS #tmp3

					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factTransactionAppointment',
							0,
							'ERROR : Transactions of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END 
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factTransactionAppointment',
					1,
					'New Transactions inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factTransactionAppointment',
					0,
					'ERROR : New Transactions may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factDailyAppointment_FirstLoader 
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_key INT;
			DECLARE @end_date DATE;

			SET @curr_date = (
				SELECT MIN(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			SELECT  ic.[insuranceCompany_ID]
					,d.[doctor_code]
					,d.[doctor_ID]
					,d.[doctorContract_ID]
					,d.[department_ID]
					,ill.[illness_ID] AS main_detected_illness
					,ill.[illnessType_ID]
			INTO #tmp_dim_cartesian
			FROM dbo.dimInsuranceCompanies ic
				 ,Clinic.dimDoctors d
				 ,Clinic.dimIllnesses ill
			WHERE d.current_flag = 1

			TRUNCATE TABLE Clinic.factDailyAppointment

			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);
					
					SELECT 	 [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,[main_detected_illness]
							,[illnessType_ID]
							,[TimeKey]
							,SUM([paid_price]) AS total_paied_price
							,SUM([real_price]) AS total_real_price
							,SUM([insurance_share]) AS total_insurance_credit
							,SUM([doctor_share]) AS total_doctor_share
							,SUM([income]) AS total_income
							,SUM([patient_code]) AS number_of_patient
					INTO #tmp_groupby
					FROM HospitalDW.Clinic.factTransactionAppointment
					WHERE TimeKey = @curr_date_key
					GROUP BY [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,[main_detected_illness]
							,[illnessType_ID]
							,[TimeKey]
					
					INSERT INTO Clinic.factDailyAppointment
						SELECT   td.[insuranceCompany_ID]
								,td.[doctor_code]
								,td.[doctor_ID]
								,td.[doctorContract_ID]
								,td.[department_ID]
								,td.[main_detected_illness]
								,td.[illnessType_ID]
								,@curr_date_key
								,ISNULL(total_paied_price,0)
								,ISNULL(total_real_price,0)
								,ISNULL(total_insurance_credit,0)
								,ISNULL(total_doctor_share,0)
								,ISNULL(total_income,0)
								,ISNULL(number_of_patient,0)
						FROM #tmp_groupby tg
							RIGHT JOIN #tmp_dim_cartesian td
							ON (tg.insuranceCompany_ID = td.insuranceCompany_ID
								AND tg.doctor_code = td.doctor_code
								AND tg.doctor_ID = td.doctor_ID
								AND tg.doctorContract_ID = td.doctorContract_ID
								AND tg.department_ID = td.department_ID
								AND tg.main_detected_illness = td.main_detected_illness
								AND tg.illnessType_ID = td.illnessType_ID)

					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factDailyAppointment',
							1,
							'Transactions of '+CONVERT(VARCHAR,@curr_date)+' inserted',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_groupby

				END TRY
				BEGIN CATCH
					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factDailyAppointment',
							0,
							'ERROR : Transactions of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END

			--drop temporary tables
			DROP TABLE #tmp_dim_cartesian

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factDailyAppointment',
					1,
					'New Transactions inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			--drop temporary tables
			DROP TABLE IF EXISTS #tmp_groupby
			DROP TABLE IF EXISTS #tmp_dim_cartesian

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factDailyAppointment',
					0,
					'ERROR : New Transactions may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factAccumulativeAppointment_FirstLoader
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_key INT;
			DECLARE @end_date DATE;

			SET @curr_date = (
				SELECT MIN(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			SELECT   i.[insuranceCompany_ID]
					,d.[doctor_code]
					,d.[doctor_ID]
					,d.[doctorContract_ID]
					,d.[department_ID]
					,0 AS total_paied_price
					,0 AS total_real_price
					,0 AS total_insurance_credit
					,0 AS total_doctor_share
					,0 AS total_income
					,0 AS number_of_patient
			INTO #tmp_dim_cartesian
			FROM dbo.dimInsuranceCompanies i
				 ,Clinic.dimDoctors d
			WHERE d.current_flag = 1

			TRUNCATE TABLE Clinic.factAccumulativeAppointment

			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);

					SELECT 	 [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,SUM([total_paied_price]) AS total_paied_price
							,SUM([total_real_price]) AS total_real_price
							,SUM([total_insurance_share]) AS total_insurance_credit
							,SUM([total_doctor_share]) AS total_doctor_share
							,SUM([total_income]) AS total_income
							,SUM([number_of_patient]) AS number_of_patient
					INTO #tmp_current_date_daily
					FROM Clinic.factDailyAppointment
					WHERE TimeKey = @curr_date_key
					GROUP BY [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
					
					SELECT 	 a.[insuranceCompany_ID]
							,a.[doctor_code]
							,a.[doctor_ID]
							,a.[doctorContract_ID]
							,a.[department_ID]
							,a.total_paied_price + d.total_paied_price AS total_paied_price
							,a.total_real_price + d.total_real_price AS total_real_price
							,a.total_insurance_credit + d.total_insurance_credit AS total_insurance_credit
							,a.total_doctor_share + d.total_doctor_share AS total_doctor_share
							,a.total_income + d.total_income AS total_income
							,a.number_of_patient + d.number_of_patient AS number_of_patient
					INTO #tmp_acc_current_date
					FROM #tmp_dim_cartesian a
						INNER JOIN #tmp_current_date_daily d
						ON (a.[insuranceCompany_ID] = d.[insuranceCompany_ID]
						   AND a.[doctor_code] = d.[doctor_code]
						   AND a.[doctor_ID] = d.[doctor_ID]
						   AND a.[doctorContract_ID] = d.[doctorContract_ID]
						   AND a.[department_ID] = d.[department_ID])
					
					truncate TABLE #tmp_dim_cartesian;

					insert INTO #tmp_dim_cartesian
						SELECT 	[insuranceCompany_ID]
								,[doctor_code]
								,[doctor_ID]
								,[doctorContract_ID]
								,[department_ID]
								,total_paied_price
								,total_real_price
								,total_insurance_credit
								,total_doctor_share
								,total_income
								,number_of_patient
						
						FROM #tmp_acc_current_date
					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factAccumulativeAppointment',
							1,
							'Records of '+CONVERT(VARCHAR,@curr_date)+' calculated',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_acc_current_date
					DROP TABLE #tmp_current_date_daily

				END TRY
				BEGIN CATCH
					--drop temporary tables
					DROP TABLE IF EXISTS #tmp_acc_current_date
					DROP TABLE IF EXISTS #tmp_current_date_daily
					DROP TABLE IF EXISTS #tmp_dim_cartesian

					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factAccumulativeAppointment',
							0,
							'ERROR : Records of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END 
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factAccumulativeAppointment',
					1,
					'Records inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			--drop temporary tables
			DROP TABLE IF EXISTS #tmp_dim_cartesian
			
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factAccumulativeAppointment',
					0,
					'ERROR : Records may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factlessPatientIllnesses_FirstLoader
AS
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.factlessPatientIllnesses


			INSERT INTO Clinic.factlessPatientIllnesses
				SELECT 	[patient_code]
						,i.[patient_ID]
						,[illness_ID]
						,[detection_date]
						,[severity]
						,i.[additional_info]
				FROM HospitalSA.dbo.PatientIllnesses as i inner join dbo.dimPatients as p on(i.patient_ID=p.patient_ID and p.current_flag=1)
		---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'factlessPatientIllnesses'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'factlessPatientIllnesses', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

-- Facts Usual Loader Procedures
CREATE OR ALTER PROCEDURE Clinic.factTransactionAppointment_Loader
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date_key INT;
			DECLARE @curr_date DATE;
			DECLARE @end_date DATE;

			SET @curr_date = (
				SELECT CONVERT(DATE,CONVERT(VARCHAR,MAX(TimeKey)))
				FROM HospitalDW.Clinic.factTransactionAppointment 
			);
			SET @curr_date = DATEADD(DAY,1,@curr_date);

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);

					SELECT ISNULL(patient_ID,-1) AS patient_ID,
						   ISNULL(doctor_ID,-1) AS doctor_ID,
						   ISNULL(main_detected_illness,-1) AS main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp_today_appointments
					FROM HospitalSA.dbo.Appointments
					WHERE appointment_date = @curr_date
					
					SELECT p.patient_code,
						   p.patient_ID,
						   p.insurance_ID,
						   i.insuranceCompany_ID
					INTO #tmp_patient_info
					FROM dbo.dimPatients p 
						INNER JOIN dbo.dimInsurances i 
						ON p.insurance_ID = i.insurance_ID
					WHERE p.[start_date] <= @curr_date 
						AND (p.current_flag = 1 
							 OR p.end_date > @curr_date);
					
					SELECT patient_ID,
						   doctor_code,
						   d.doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   a.additional_info 
					INTO #tmp1
					FROM Clinic.dimDoctors d
						INNER JOIN #tmp_today_appointments a
						ON d.doctor_ID = a.doctor_ID
					WHERE [start_date] <= @curr_date 
						AND (current_flag = 1 
							 OR end_date > @curr_date);

					SELECT p.patient_code,
						   p.patient_ID,
						   p.insurance_ID,
						   p.insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   price,
						   doctor_share,
						   insurance_share,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp2
					FROM #tmp_patient_info p
						INNER JOIN #tmp1 d
						ON d.patient_ID = p.patient_ID

					SELECT t.patient_code,
						   t.patient_ID,
						   t.insurance_ID,
						   t.insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   i.illnessType_ID,
						   @curr_date_key AS TimeKey,
						   ---------------
						   price - insurance_share AS paid_price,
						   price AS real_price,
						   doctor_share,
						   insurance_share,
						   price - doctor_share AS income,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
					INTO #tmp3
					FROM #tmp2 t
						INNER JOIN Clinic.dimIllnesses i
						ON i.illness_ID = t.main_detected_illness

					INSERT INTO Clinic.factTransactionAppointment
						SELECT patient_code,
						   patient_ID,
						   insurance_ID,
						   insuranceCompany_ID,
						   doctor_code,
						   doctor_ID,
						   doctorContract_ID,
						   department_ID,
						   main_detected_illness,
						   illnessType_ID,
						   TimeKey,
						   ---------------
						   paid_price,
						   real_price,
						   doctor_share,
						   insurance_share,
						   income,
						   payment_method,
						   payment_method_description,
						   credit_card_number,
						   payer,
						   payer_phone_number,
						   additional_info 
						FROM #tmp3
					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factTransactionAppointment',
							1,
							'Transactions of '+CONVERT(VARCHAR,@curr_date)+' inserted',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_today_appointments
					DROP TABLE #tmp_patient_info
					DROP TABLE #tmp1
					DROP TABLE #tmp2
					DROP TABLE #tmp3

				END TRY
				BEGIN CATCH
					--drop temporary tables
					DROP TABLE IF EXISTS #tmp_today_appointments
					DROP TABLE IF EXISTS #tmp_patient_info
					DROP TABLE IF EXISTS #tmp1
					DROP TABLE IF EXISTS #tmp2
					DROP TABLE IF EXISTS #tmp3

					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factTransactionAppointment',
							0,
							'ERROR : Transactions of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END 
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factTransactionAppointment',
					1,
					'New Transactions inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factTransactionAppointment',
					0,
					'ERROR : New Transactions may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factDailyAppointment_Loader 
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_key INT;
			DECLARE @end_date DATE;

			SET @curr_date = (
				SELECT CONVERT(DATE,CONVERT(VARCHAR,MAX(TimeKey)))
				FROM HospitalDW.Clinic.factTransactionAppointment 
			);
			SET @curr_date = DATEADD(DAY,1,@curr_date);

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			SELECT  ic.[insuranceCompany_ID]
					,d.[doctor_code]
					,d.[doctor_ID]
					,d.[doctorContract_ID]
					,d.[department_ID]
					,ill.[illness_ID] AS main_detected_illness
					,ill.[illnessType_ID]
			INTO #tmp_dim_cartesian
			FROM dbo.dimInsuranceCompanies ic
				 ,Clinic.dimDoctors d
				 ,Clinic.dimIllnesses ill
			WHERE d.current_flag = 1

			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);
					
					SELECT 	 [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,[main_detected_illness]
							,[illnessType_ID]
							,[TimeKey]
							,SUM([paid_price]) AS total_paied_price
							,SUM([real_price]) AS total_real_price
							,SUM([insurance_share]) AS total_insurance_credit
							,SUM([doctor_share]) AS total_doctor_share
							,SUM([income]) AS total_income
							,SUM([patient_code]) AS number_of_patient
					INTO #tmp_groupby
					FROM HospitalDW.Clinic.factTransactionAppointment
					WHERE TimeKey = @curr_date_key
					GROUP BY [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,[main_detected_illness]
							,[illnessType_ID]
							,[TimeKey]
					
					INSERT INTO Clinic.factDailyAppointment
						SELECT   td.[insuranceCompany_ID]
								,td.[doctor_code]
								,td.[doctor_ID]
								,td.[doctorContract_ID]
								,td.[department_ID]
								,td.[main_detected_illness]
								,td.[illnessType_ID]
								,@curr_date_key
								,ISNULL(total_paied_price,0)
								,ISNULL(total_real_price,0)
								,ISNULL(total_insurance_credit,0)
								,ISNULL(total_doctor_share,0)
								,ISNULL(total_income,0)
								,ISNULL(number_of_patient,0)
						FROM #tmp_groupby tg
							RIGHT JOIN #tmp_dim_cartesian td
							ON (tg.insuranceCompany_ID = td.insuranceCompany_ID
								AND tg.doctor_code = td.doctor_code
								AND tg.doctor_ID = td.doctor_ID
								AND tg.doctorContract_ID = td.doctorContract_ID
								AND tg.department_ID = td.department_ID
								AND tg.main_detected_illness = td.main_detected_illness
								AND tg.illnessType_ID = td.illnessType_ID)

					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factDailyAppointment',
							1,
							'Transactions of '+CONVERT(VARCHAR,@curr_date)+' inserted',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_groupby

				END TRY
				BEGIN CATCH
					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factDailyAppointment',
							0,
							'ERROR : Transactions of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END

			--drop temporary tables
			DROP TABLE #tmp_dim_cartesian

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factDailyAppointment',
					1,
					'New Transactions inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			--drop temporary tables
			DROP TABLE IF EXISTS #tmp_groupby
			DROP TABLE IF EXISTS #tmp_dim_cartesian

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factDailyAppointment',
					0,
					'ERROR : New Transactions may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factAccumulativeAppointment_Loader @cur_date DATE
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_key INT;
			DECLARE @end_date DATE;

			SET @curr_date = DATEADD(DAY,1,@cur_date)

			SET @end_date = (
				SELECT MAX(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			SELECT   i.[insuranceCompany_ID]
					,d.[doctor_code]
					,d.[doctor_ID]
					,d.[doctorContract_ID]
					,d.[department_ID]
					,0 AS total_paied_price
					,0 AS total_real_price
					,0 AS total_insurance_credit
					,0 AS total_doctor_share
					,0 AS total_income
					,0 AS number_of_patient
			INTO #tmp_dim_cartesian
			FROM dbo.dimInsuranceCompanies i
				 ,Clinic.dimDoctors d
			WHERE d.current_flag = 1

			--loop in days
			WHILE @curr_date < @end_date BEGIN
				BEGIN TRY
					--find TimeKey
					SET @curr_date_key = (
						SELECT TimeKey
						FROM dbo.dimDate
						WHERE FullDateAlternateKey = @curr_date
					);

					SELECT 	 [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
							,SUM([total_paied_price]) AS total_paied_price
							,SUM([total_real_price]) AS total_real_price
							,SUM([total_insurance_share]) AS total_insurance_credit
							,SUM([total_doctor_share]) AS total_doctor_share
							,SUM([total_income]) AS total_income
							,SUM([number_of_patient]) AS number_of_patient
					INTO #tmp_current_date_daily
					FROM Clinic.factDailyAppointment
					WHERE TimeKey = @curr_date_key
					GROUP BY [insuranceCompany_ID]
							,[doctor_code]
							,[doctor_ID]
							,[doctorContract_ID]
							,[department_ID]
					
					SELECT 	 a.[insuranceCompany_ID]
							,a.[doctor_code]
							,a.[doctor_ID]
							,a.[doctorContract_ID]
							,a.[department_ID]
							,a.total_paied_price + d.total_paied_price AS total_paied_price
							,a.total_real_price + d.total_real_price AS total_real_price
							,a.total_insurance_credit + d.total_insurance_credit AS total_insurance_credit
							,a.total_doctor_share + d.total_doctor_share AS total_doctor_share
							,a.total_income + d.total_income AS total_income
							,a.number_of_patient + d.number_of_patient AS number_of_patient
					INTO #tmp_acc_current_date
					FROM #tmp_dim_cartesian a
						INNER JOIN #tmp_current_date_daily d
						ON (a.[insuranceCompany_ID] = d.[insuranceCompany_ID]
						   AND a.[doctor_code] = d.[doctor_code]
						   AND a.[doctor_ID] = d.[doctor_ID]
						   AND a.[doctorContract_ID] = d.[doctorContract_ID]
						   AND a.[department_ID] = d.[department_ID])
					
					truncate TABLE #tmp_dim_cartesian;

					insert INTO #tmp_dim_cartesian
						SELECT 	[insuranceCompany_ID]
								,[doctor_code]
								,[doctor_ID]
								,[doctorContract_ID]
								,[department_ID]
								,total_paied_price
								,total_real_price
								,total_insurance_credit
								,total_doctor_share
								,total_income
								,number_of_patient
							
						FROM #tmp_acc_current_date
					--------------------------------------------
					INSERT INTO Logs
					VALUES (GETDATE(),
							'Clinic.factAccumulativeAppointment',
							1,
							'Records of '+CONVERT(VARCHAR,@curr_date)+' calculated',
							@@ROWCOUNT);
					
					--add a day 
					SET @curr_date = DATEADD(DAY, 1, @curr_date);

					--drop temporary tables
					DROP TABLE #tmp_acc_current_date
					DROP TABLE #tmp_current_date_daily

				END TRY
				BEGIN CATCH
					--drop temporary tables
					DROP TABLE IF EXISTS #tmp_acc_current_date
					DROP TABLE IF EXISTS #tmp_current_date_daily
					DROP TABLE IF EXISTS #tmp_dim_cartesian

					INSERT INTO Logs 
					VALUES (GETDATE(),
							'Clinic.factAccumulativeAppointment',
							0,
							'ERROR : Transactions of '+CONVERT(VARCHAR,@curr_date)+' may not inserted',
							@@ROWCOUNT);
				END CATCH
			END 
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factAccumulativeAppointment',
					1,
					'Records inserted',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			--drop temporary tables
			DROP TABLE IF EXISTS #tmp_dim_cartesian
			
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic.factAccumulativeAppointment',
					0,
					'ERROR : Records may not inserted',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.factlessPatientIllnesses_Loader
AS
	BEGIN
		BEGIN TRY
			TRUNCATE TABLE Clinic.factlessPatientIllnesses


			INSERT INTO Clinic.factlessPatientIllnesses
				SELECT 	[patient_code]
						,i.[patient_ID]
						,[illness_ID]
						,[detection_date]
						,[severity]
						,i.[additional_info]
				FROM HospitalSA.dbo.PatientIllnesses as i inner join dbo.dimPatients as p on(i.patient_ID=p.patient_ID and p.current_flag=1)
		---------------------------------------------------
			INSERT INTO [dbo].[Logs]
				([DATE]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows])
			VALUES
				(GETDATE()
				,'factlessPatientIllnesses'
				,1
				,'inserting new VALUES was successfull'
				,@@ROWCOUNT)
		END TRY
		BEGIN CATCH
			INSERT INTO HospitalDW.dbo.Logs([DATE], [table_name], [status], [description], [affected_rows])
			VALUES (GETDATE(), 'factlessPatientIllnesses', 0, 'Error WHILE inserting OR updating', @@ROWCOUNT);
			SELECT ERROR_MESSAGE() AS ErrorMessage
		END CATCH
	END
GO

/**************************************************************************
Clinic Main Procedures
***************************************************************************/
CREATE OR ALTER PROCEDURE Clinic.FirstLoad
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;

			SET @curr_date = (
				SELECT MIN(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);
			
			EXEC Clinic.dimDepartments_FirstLoader;
			EXEC Clinic.dimDoctorContracts_FirstLoader;
			EXEC Clinic.dimDoctors_FirstLoader @curr_date;
			EXEC Clinic.dimIllnessTypes_FirstLoader;
			EXEC Clinic.dimIllnesses_FirstLoader;

			EXEC Clinic.factTransactionAppointment_FirstLoader
			EXEC Clinic.factDailyAppointment_FirstLoader
			EXEC Clinic.factAccumulativeAppointment_FirstLoader
			EXEC Clinic.factlessPatientIllnesses_FirstLoader

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic Mart',
					1,
					'All First Load insertions was successful',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic Mart',
					0,
					'ERROR : First Load insertions FAILED',
					@@ROWCOUNT);
		END CATCH
	END
GO

CREATE OR ALTER PROCEDURE Clinic.[Load]
	AS
	BEGIN
		BEGIN TRY
			DECLARE @curr_date DATE;
			DECLARE @curr_date_fact DATE;

			SET @curr_date = (
				SELECT MIN(appointment_date)
				FROM HospitalSA.dbo.Appointments
			);

			SET @curr_date_fact = (
				SELECT CONVERT(DATE,CONVERT(VARCHAR,MAX(TimeKey)))
				FROM HospitalDW.Clinic.factTransactionAppointment 
			);
			
			EXEC Clinic.dimDepartments_Loader @curr_date;
			EXEC Clinic.dimDoctorContracts_Loader;
			EXEC Clinic.dimDoctors_Loader @curr_date;
			EXEC Clinic.dimIllnessTypes_Loader;
			EXEC Clinic.dimIllnesses_Loader;

			EXEC Clinic.factTransactionAppointment_Loader;
			EXEC Clinic.factDailyAppointment_Loader;
			EXEC Clinic.factAccumulativeAppointment_Loader @curr_date_fact;
			EXEC Clinic.factlessPatientIllnesses_Loader;

			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic Mart',
					1,
					'All insertions was successful',
					@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			INSERT INTO Logs 
			VALUES (GETDATE(),
					'Clinic Mart',
					0,
					'ERROR : insertions FAILED',
					@@ROWCOUNT);
		END CATCH
	END
GO


/*###########################################################################
								Final Procedures
###########################################################################*/
create or alter procedure dbo.FirstLoad as
begin
	begin try
		declare @curr_date date;
		SET @curr_date=(
					SELECT min(order_date)
					FROM [HospitalSA].[dbo].[MedicineOrderHeaders]
				);
		exec dbo.dimInsuranceCompanies_FirstLoader @curr_date;
		exec dbo.dimInsurances_FirstLoader;
		exec dbo.dimPatients_FirstLoader @curr_date;
		exec Pharmacy.FirstLoad;
		exec Clinic.FirstLoad;

		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'All Tables'
				,1
				,'First Load insertions was successful'
				,@@ROWCOUNT
			);
	end try
	begin catch
		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'All Tables'
				,0
				,'ERROR : First Load insertions FAILED'
				,@@ROWCOUNT
			);
	end catch

end
go

------------------------------------------------------
------------------------------------------------------

create or alter procedure dbo.[Load] as
begin
	begin try
		declare @curr_date date;
		declare @curr_datekey int;
		SET @curr_datekey=(
					SELECT max(TimeKey)
					FROM Pharmacy.[factTransactionalMedicine]
				);
		set @curr_date=(select DATEADD(day, 1, FullDateAlternateKey) from dbo.dimDate where TimeKey=@curr_datekey);

		exec dbo.dimInsuranceCompanies_Loader @curr_date;
		exec dbo.dimInsurances_Loader;
		exec dbo.dimPatients_Loader @curr_date;
		exec Pharmacy.[Load];
		exec Clinic.[Load];

		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'All Tables'
				,1
				,'Load insertions was successful'
				,@@ROWCOUNT
			);
	end try
	begin catch
		INSERT INTO [dbo].[Logs](
				[date]
				,[table_name]
				,[status]
				,[description]
				,[affected_rows]
			)VALUES(
				GETDATE()
				,'All Tables'
				,0
				,'ERROR : Load insertions FAILED'
				,@@ROWCOUNT
			);
	end catch

end
go

/*###########################################################################
										RUN
###########################################################################*/
/*
--FirstLoad
exec dbo.[FirstLoad];
select * from Logs;
*/

/*
--UsualLoad
exec dbo.[Load];
select * from Logs;
*/

