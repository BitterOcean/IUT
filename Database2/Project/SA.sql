/**************************************************************************
DataBase2 Project		: Create Stage Area Tables
Authors						: Sajede Nicknadaf, Maryam Saeedmehr
Student Numbers		: 9637453, 9629373
Semester						: fall 1399
version							: 3
***************************************************************************/
drop database if exists HospitalSA
go

create database HospitalSA
go

use HospitalSA
go

exec sp_changedbowner 'sa'

create table InsuranceCompanies(
insuranceCompany_ID int primary key,
[name] varchar(50) ,
license_code varchar(15) ,
manager varchar(50) ,
agent varchar(50) ,
phone_number varchar(15) ,
fax_number varchar(15) ,
website_address varchar(200) ,
manager_phone_number varchar(15) ,
agent_phone_number varchar(15) ,
[address] varchar(200) ,
additional_info varchar(200) ,
active bit ,
active_description varchar(200) 
);

create table Insurances(
insurance_ID int primary key,
insuranceCompany_ID int ,
code varchar(15) ,
insurer varchar(50) ,
insurer_phone_number varchar(15) ,
expire_date date ,
medicine_reduction int ,
appointment1_reduction int , --General doctor
appointment2_reduction int , --Specialist doctor
appointment3_reduction int , --Subspecialty doctor
hospitalization_reduction int ,
surgery_reduction int ,
test_reduction int ,
dentistry_reduction int ,
radiology_reduction int ,
additional_info varchar(200) 
);

create table Departments(
department_ID int primary key,
[name] varchar(20) ,
[description] varchar(200) ,
chairman varchar(50) ,
assistant varchar(50) ,
chairman_phone_number varchar(15) ,
assistant_phone_number varchar(15) ,
chairman_room int ,
assistant_room int ,
reception_phone_number varchar(15) ,
budget int ,
additional_info varchar(200) 
);

create table IllnessTypes(
illnessType_ID int primary key,
[name] varchar(50) ,
[description] varchar(200) ,
related_department_ID int 
);

create table Illnesses(
illness_ID int primary key,
illnessType_ID int ,
[name] varchar(100) ,
scientific_name varchar(100) ,
special_illness bit , --0 for not special / 1 for special illnesses
special_illness_description varchar(100),
killing_status smallint ,
killing_description varchar(100) ,
chronic bit ,
chronic_description varchar(100) 
);

create table Patients(
patient_ID int primary key,
national_code varchar(10) ,
insurance_ID int ,
first_name varchar(20) ,
last_name varchar(50) ,
birthdate date ,
height int ,
[weight] int ,
gender varchar(10) ,
phone_number varchar(15) ,
postal_code varchar(12) ,
[address] varchar(200) ,
death_date date ,
death_reason int ,
additional_info varchar(200) 
);

create table Doctors(
doctor_ID int primary key,
doctorContract_ID int ,
department_ID int ,
national_code varchar(10) ,
license_code varchar(15) ,
first_name varchar(20) ,
last_name varchar(50) ,
birthdate date ,
gender varchar(10),
religion varchar(100) ,
nationality varchar(50) ,
marital_status bit ,
marital_status_description varchar(20) , -- 0 for single / 1 for married
phone_number varchar(15) ,
postal_code varchar(12) ,
[address] varchar(200) ,
education_degree int , --[1-3]
specialty_description varchar(100) ,
graduation_date date ,
university varchar(100) ,
additional_info varchar(200) 
);

create table DoctorContracts(
doctorContract_ID int ,
contract_start_date date  ,
contract_end_date date  ,
appointment_portion int  ,
salary int  ,
active bit  ,
active_description varchar(30),
additional_info varchar(200) 
);

create table PatientIllnesses(
patient_ID int ,
illness_ID int ,
detection_date date ,
severity int ,--[1-5]
additional_info varchar(200)
);

create table Nurses(
nurse_ID int primary key,
national_code varchar(10) ,
license_code varchar(15) ,
department_ID int ,
first_name varchar(20) ,
last_name varchar(50) ,
birthdate date ,
gender varchar(10),
phone_number varchar(15) ,
postal_code varchar(12) ,
[address] varchar(200) ,
religion varchar(100) ,
nationality varchar(50) ,
marital_status bit ,
marital_status_description varchar(20) , -- 0 for single / 1 for married
education_degree int ,
specialty_description varchar(100) ,
graduation_date date ,
university varchar(100) ,
contract_start_date date ,
contract_end_date date ,
payment_base int ,
additional_info varchar(200) 
);

create table Sections(
section_ID int primary key,
supervisor_ID int ,
head_nurse_ID int ,
department_ID int ,
supervisor_phone_number varchar(15) ,
head_nurse_phone_number varchar(15) ,
supervisor_room int ,
head_nurse_room int ,
total_room int ,
budget int ,
[description] varchar(500),
additional_info varchar(200) 
);

create table Hospitalization(
hospitalization_ID int primary key,
patient_ID int ,
doctor_ID int ,
hospitalization_reason int ,
admit_date date ,
section_ID int ,
room_number int ,
accompanied_by varchar(50) ,
accompany_phone_number varchar(15) ,
dietary_recommendations varchar(MAX) ,
medication_recommendations varchar(MAX) ,
additional_info varchar(200) 
);

create table Hospitalization_checkout(
hospitalization_checkout_ID int primary key,
hospitalization_ID int ,
discharg_date date ,
payment_method bit , -- credit card / cash
payment_method_description varchar(50) ,
credit_card_number varchar(16) , 
payer varchar(50) ,
payer_phone_number varchar(15) ,
checkout_status bit , -- for Installment payment
additional_info varchar(MAX) 
);

create table Surgeries(
surgery_ID int primary key,
patient_ID int ,
main_doctor_ID int ,
anesthesiologist int ,
surgery_nurse int ,
[start_date] datetime ,
duration smallint ,
main_doctor_portion int ,
anesthesiologist_portion int ,
surgery_nurse_portion int ,
base_price int ,
paid int ,
additional_info varchar(200)
);

create table MedicineFactories(
medicineFactory_ID int primary key,
[name] varchar(50) ,
license_code varchar(15) ,
manager varchar(50) ,
agent varchar(50) ,
phone_number varchar(15) ,
fax_number varchar(15) ,
website_address varchar(200) ,
manager_phone_number varchar(15) ,
agent_phone_number varchar(15) ,
[address] varchar(200) ,
additional_info varchar(200) ,
active bit ,
active_description varchar(200) 
);

create table Medicines(
medicine_ID int primary key,
medicineFactory_ID int ,
[name] varchar(20) ,
latin_name varchar(50) ,
dose float ,
side_effects varchar(100) ,
production_date date ,
expire_date date ,
purchase_price int ,
sales_price int ,
stock int ,
[description] varchar(100) ,
medicine_type smallint ,--0:normal(with reduction with insurance) / 1:beauty(without reduction) / 2:special(free)
medicine_type_description varchar(10) ,
additional_info varchar(200) 
);

create table MedicineOrderHeaders(
medicineOrderHeader_ID int primary key,
patient_ID int ,
order_date date ,
total_price int ,
payment_method bit , -- credit card / cash
payment_method_description varchar(50) ,
credit_card_number varchar(16) , 
payer varchar(50) ,
payer_phone_number varchar(15) ,
additional_info varchar(200) 
);

create table MedicineOrderDetails(
medicineOrderDetails_ID int primary key,
medicineOrderHeader_ID int ,
medicine_ID int ,
[count] int ,
unit_price int ,
purchase_unit_price int ,
insurance_portion int 
);

create table Appointments(
appointment_ID int primary key,
patient_ID int ,
doctor_ID int , 
main_detected_illness int ,
appointment_number int ,
appointment_date date ,
price int ,
doctor_share int,
insurance_share int,
payment_method bit , -- credit card / cash
payment_method_description varchar(50) ,
credit_card_number varchar(16) , 
payer varchar(50) ,
payer_phone_number varchar(15) ,
additional_info varchar(200) 
);

--Logs
create table Logs(
[date] datetime,
table_name varchar(50),
[status] tinyint,
[text] varchar(500),
affected_rows int
);

go

/**************************************************************************
DataBase2 Project		: Create Stage Area Procedures
Authors						: Sajede Nicknadaf, Maryam Saeedmehr
Student Numbers		: 9637453, 9629373
Semester						: fall 1399
version							: 3
***************************************************************************/
create or alter procedure InsuranceCompanies_insert as
begin
	begin try
		truncate table InsuranceCompanies;
		insert into InsuranceCompanies
		select insuranceCompany_ID,[name],license_code,manager,agent,phone_number,fax_number,website_address,manager_phone_number,agent_phone_number,[address],additional_info,active,case active 
																																														when 0 then 'Not Active'
																																														else 'Active'
																																														end as active_description
		from Hospital.dbo.InsuranceCompanies; 
		insert into Logs values
		(GETDATE(),'InsuranceCompanies',1,'InsuranceCompanies inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'InsuranceCompanies',0,'ERROR : InsuranceCompanies may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Insurances_insert as
begin
	begin try
		truncate table Insurances;
		insert into Insurances
		select insurance_ID,insuranceCompany_ID,code,insurer,insurer_phone_number,expire_date,medicine_reduction,appointment1_reduction,appointment2_reduction,appointment3_reduction,hospitalization_reduction,surgery_reduction,test_reduction,dentistry_reduction,radiology_reduction,additional_info
		from Hospital.dbo.Insurances; 
		insert into Logs values
		(GETDATE(),'Insurances',1,'Insurances inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Insurances',0,'ERROR : Insurances may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Departments_insert as
begin
	begin try
		truncate table Departments;
		insert into Departments
		select department_ID,[name],[description],chairman,assistant,chairman_phone_number,assistant_phone_number,chairman_room,assistant_room,reception_phone_number,budget,additional_info
		from Hospital.dbo.Departments; 
		insert into Logs values
		(GETDATE(),'Departments',1,'Departments inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Departments',0,'ERROR : Departments may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure IllnessTypes_insert as
begin
	begin try
		truncate table IllnessTypes;
		insert into IllnessTypes
		select illnessType_ID,[name],[description],related_department_ID
		from Hospital.dbo.IllnessTypes; 
		insert into Logs values
		(GETDATE(),'IlnessTypes',1,'IlnessTypes inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'IlnessTypes',0,'ERROR : IlnessTypes may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Illnesses_insert as
begin
	begin try
		truncate table Illnesses;
		insert into Illnesses
		select illness_ID,illnessType_ID,[name],scientific_name,special_illness,case special_illness
																				when 0 then 'not special'
																				else 'special'
																				end as special_illness_description,killing_status,case killing_status
																								when 0 then 'not killing'
																								else 'killing'
																								end as killing_description,chronic,case chronic
																															when 0 then 'Not chronic'
																															else 'chronic'
																															end as chronic_description
		from Hospital.dbo.Illnesses; 
		insert into Logs values
		(GETDATE(),'Ilnesses',1,'Ilnesses inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Ilnesses',0,'ERROR : Ilnesses may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Patients_insert as
begin
	begin try
		truncate table Patients;
		insert into Patients
		select patient_ID,national_code,insurance_ID,first_name,last_name,birthdate,height,[weight],gender,phone_number,postal_code,[address],death_date,death_reason,additional_info
		from Hospital.dbo.Patients; 
		insert into Logs values
		(GETDATE(),'Patients',1,'Patients inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Patients',0,'ERROR : Patients may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Doctors_insert as
begin
	begin try
		truncate table Doctors;
		insert into Doctors
		select doctor_ID,doctorContract_ID,department_ID,national_code,license_code,first_name,last_name,birthdate,gender,religion,nationality,marital_status,case marital_status
																																								when 0 then 'single'
																																								else 'married'
																																								end as marital_status_description,phone_number,postal_code,[address],education_degree,specialty_description,graduation_date,university,additional_info
		from Hospital.dbo.Doctors; 
		insert into Logs values
		(GETDATE(),'Doctors',1,'Doctors inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Doctors',0,'ERROR : Doctors may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure DoctorContracts_insert as
begin
	begin try
		truncate table DoctorContracts;
		insert into DoctorContracts
		select doctorContract_ID,contract_start_date,contract_end_date,appointment_portion,salary,active,case active
																											when 0 then 'not active'
																											else 'active'
																											end as active_description,additional_info
		from Hospital.dbo.DoctorContracts; 
		insert into Logs values
		(GETDATE(),'DoctorContracts',1,'DoctorContracts inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'DoctorContracts',0,'ERROR : DoctorContracts may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure MedicineFactories_insert as
begin
	begin try
		truncate table MedicineFactories;
		insert into MedicineFactories
		select medicineFactory_ID,[name],license_code,manager,agent,phone_number,fax_number,website_address,manager_phone_number,agent_phone_number,[address],additional_info,active,case active when 0 then 'not active'
																																														else 'active'
																																														end as active_description
		from Hospital.dbo.MedicineFactories; 
		insert into Logs values
		(GETDATE(),'MedicineFactories',1,'MedicineFactories inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'MedicineFactories',0,'ERROR : MedicineFactories may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure Medicines_insert as
begin
	begin try
		truncate table Medicines;
		insert into Medicines
		select medicine_ID,medicineFactory_ID,[name],latin_name,dose,side_effects,production_date,expire_date,purchase_price,sales_price,stock,[description],medicine_type,case medicine_type
																																											when 0 then 'normal'
																																											when 1 then 'beauty'
																																											else 'special' 
																																											end as medicine_type_description,additional_info
		from Hospital.dbo.Medicines; 
		insert into Logs values
		(GETDATE(),'Medicines',1,'Medicines inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Medicines',0,'ERROR : Medicines may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure  MedicineOrder_insert as 
begin
	begin try
		declare @temp_cur_date date;
		declare @end_date date;
		declare @tmp_order table(
			medicineOrderHeader_ID int ,
			patient_ID int ,
			order_date date ,
			total_price int ,
			payment_method bit , -- credit card / cash
			payment_method_description varchar(50) ,
			credit_card_number varchar(16) , 
			payer varchar(50) ,
			payer_phone_number varchar(15) ,
			additional_info varchar(200) 
		);
		set @end_date=(
			select max(order_date)
			from Hospital.dbo.MedicineOrderHeaders
		);
		set @temp_cur_date=isnull((
			select dateadd(day,1,max(order_date))
			from MedicineOrderHeaders
		),(
			select min(order_date)
			from Hospital.dbo.MedicineOrderHeaders
		));
		while @temp_cur_date<=@end_date begin
			begin try
				--read this day OrderHeader
				insert into @tmp_order
				select medicineOrderHeader_ID, patient_ID, order_date, total_price,payment_method,case payment_method
																									when 0 then 'credit card'
																									else 'cash'
																									end as payment_method_description,credit_card_number,payer,payer_phone_number,additional_info
				from Hospital.dbo.MedicineOrderHeaders
				where order_date=@temp_cur_date;
				--insert to MedicineOrderHeaders
				insert into MedicineOrderHeaders
				select medicineOrderHeader_ID, patient_ID, order_date, total_price,payment_method,payment_method_description,credit_card_number,payer,payer_phone_number,additional_info
				from @tmp_order;
				insert into Logs values
				(GETDATE(),'MedicineOrderHeaders',1,'OrderHeaders of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
				--read and insert this day OrderDetails
				insert into MedicineOrderDetails
				select src.medicineOrderDetails_ID, src.medicineOrderHeader_ID, src.medicine_ID, src.[count], src.unit_price,src.purchase_unit_price,src.insurance_portion
				from @tmp_order as tmp inner join Hospital.dbo.MedicineOrderDetails as src on (tmp.medicineOrderHeader_ID=src.medicineOrderHeader_ID);
				insert into Logs values
				(GETDATE(),'MedicineOrderDetails',1,'OrderDetails of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
				--add a day 
				set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);
				--clear tmp
				delete from @tmp_order;
			end try
			begin catch
				insert into Logs values
				(GETDATE(),'MedicineOrder',0,'ERROR : Orders of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
			end catch
		end
		insert into Logs values
		(GETDATE(),'MedicineOrder',1,'MedicineOrder inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'MedicineOrder',0,'ERROR : MedicineOrder may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure  Appointments_insert as 
begin
	begin try
		declare @temp_cur_date date;
		declare @end_date date;

		set @end_date=(
			select max(appointment_date)
			from Hospital.dbo.Appointments
		);
		set @temp_cur_date=isnull((
			select dateadd(day,1,max(appointment_date))
			from Appointments
		),(
			select min(appointment_date)
			from Hospital.dbo.Appointments
		));
		while @temp_cur_date<=@end_date begin
			begin try
				--read and insert this day appointments
				insert into Appointments
				select appointment_ID,patient_ID,doctor_ID,main_detected_illness,appointment_number,appointment_date,price,doctor_share,insurance_share,payment_method,case payment_method
																																										when 0 then 'credit card'
																																										else 'cash'
																																										end as payment_method_description,credit_card_number,payer,payer_phone_number,additional_info
				from Hospital.dbo.Appointments
				where appointment_date=@temp_cur_date;
				--log
				insert into Logs values
				(GETDATE(),'Appointments',1,'Appointments of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
				--add a day 
				set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);
			end try
			begin catch
				insert into Logs values
				(GETDATE(),'Appointments',0,'ERROR : Appointments of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
			end catch
		end

		insert into Logs values
		(GETDATE(),'Appointments',1,'Appointments inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'Appointments',0,'ERROR : Appointments may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure  PatientIlnesses_insert as 
begin
	begin try
		truncate table PatientIlnesses;
		insert into PatientIlnesses
		select patient_ID,ilness_ID,[detection_date],severity,additional_info
		from Hospital.dbo.PatientIlnesses 
		insert into Logs values
		(GETDATE(),'PatientIlnesses',1,'PatientIlnesses inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'PatientIlnesses',0,'ERROR : PatientIlnesses may not inserted',@@ROWCOUNT);
	end catch
	/*begin try
		declare @temp_cur_date date;
		declare @end_date date;

		set @end_date=(
			select max(detection_date)
			from Hospital.dbo.PatientIlnesses
		);
		set @temp_cur_date=isnull((
			select dateadd(day,1,max(detection_date))
			from PatientIlnesses
		),(
			select min(detection_date)
			from Hospital.dbo.PatientIlnesses
		));
		while @temp_cur_date<=@end_date begin
			begin try
				--read and insert this day appointments
				insert into PatientIlnesses
				select patient_ID,ilness_ID,[detection_date],severity,additional_info
				from Hospital.dbo.PatientIlnesses
				where detection_date=@temp_cur_date;
				--log
				insert into Logs values
				(GETDATE(),'PatientIlnesses',1,'PatientIlnesses of '+convert(varchar,@temp_cur_date)+' inserted',@@ROWCOUNT);
				--add a day 
				set @temp_cur_date=DATEADD(day, 1, @temp_cur_date);
			end try
			begin catch
				insert into Logs values
				(GETDATE(),'PatientIlnesses',0,'ERROR : PatientIlnesses of '+convert(varchar,@temp_cur_date)+' may not inserted',@@ROWCOUNT);
			end catch
		end

		insert into Logs values
		(GETDATE(),'PatientIlnesses',1,'PatientIlnesses inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'PatientIlnesses',0,'ERROR : PatientIlnesses may not inserted',@@ROWCOUNT);
	end catch*/
end
go

create or alter procedure InsertToSA as
begin
	begin try
		exec InsuranceCompanies_insert;
		exec Insurances_insert;
		exec Departments_insert;
		exec IllnessTypes_insert;
		exec Illnesses_insert;
		exec Patients_insert;
		exec Doctors_insert;
		exec DoctorContracts_insert;
		exec MedicineFactories_insert;
		exec Medicines_insert;
		exec MedicineOrder_insert;
		exec Appointments_insert;
		exec PatientIlnesses_insert;
		insert into Logs values
		(GETDATE(),'All Tables',1,'All insertions done!',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'All Tables',0,'ERROR : All insertions may not done!',@@ROWCOUNT);
	end catch
end
go

--exec InsertToSA;