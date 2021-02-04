/**************************************************************************
DataBase2 Project		: Create Source Tables
Authors						: Sajede Nicknadaf, Maryam Saeedmehr
Student Numbers		: 9637453, 9629373
Semester						: fall 1399
version							: 5
***************************************************************************/
drop database if exists Hospital
go

create database Hospital
go

use Hospital
go

exec sp_changedbowner 'sa'
go

create table InsuranceCompanies(
insuranceCompany_ID int primary key,
[name] varchar(50) not null,
license_code varchar(15) not null,
manager varchar(50) null,
agent varchar(50) null,
phone_number varchar(15) null,
fax_number varchar(15) not null,
website_address varchar(200) null,
manager_phone_number varchar(15) null,
agent_phone_number varchar(15) null,
[address] varchar(200) null,
additional_info varchar(200) null,
active bit not null
);

create table Insurances(
insurance_ID int primary key,
insuranceCompany_ID int not null,
code varchar(15) not null,
insurer varchar(50) not null,
insurer_phone_number varchar(15) null,
expire_date date null,
medicine_reduction int not null,
appointment1_reduction int not null, --General doctor
appointment2_reduction int not null, --Specialist doctor
appointment3_reduction int not null, --Subspecialty doctor
hospitalization_reduction int not null,
surgery_reduction int not null,
test_reduction int not null,
dentistry_reduction int not null,
radiology_reduction int not null,
additional_info varchar(200) null,
foreign key(insuranceCompany_ID) references InsuranceCompanies(insuranceCompany_ID)
);

create table Departments(
department_ID int primary key,
[name] varchar(20) not null,
[description] varchar(200) null,
chairman varchar(50) not null,
assistant varchar(50) null,
chairman_phone_number varchar(15) not null,
assistant_phone_number varchar(15) null,
chairman_room int not null,
assistant_room int null,
reception_phone_number varchar(15) not null,
budget int not null,
additional_info varchar(200) null
);

create table IllnessTypes(
illnessType_ID int primary key,
[name] varchar(50) not null,
[description] varchar(200) null,
related_department_ID int not null,
foreign key(related_department_ID) references Departments(department_ID)
);

create table Illnesses(
illness_ID int primary key,
illnessType_ID int not null,
[name] varchar(100) not null,
scientific_name varchar(100) not null,
special_illness bit not null, --0 for not special / 1 for special illnesses
killing_status smallint not null,
chronic bit not null,
foreign key(illnessType_ID) references IllnessTypes(illnessType_ID)
);

create table Patients(
patient_ID int primary key,
national_code varchar(10) not null,
insurance_ID int not null,
first_name varchar(20) not null,
last_name varchar(50) not null,
birthdate date not null,
height int null,
[weight] int null,
gender varchar(10) Check (gender in('Male','Female','Bi_sexual')),
phone_number varchar(15) null,
postal_code varchar(12) null,
[address] varchar(200) null,
death_date date null,
death_reason int null,
additional_info varchar(200) null,
foreign key(insurance_ID) references Insurances(insurance_ID),
foreign key(death_reason) references Illnesses(illness_ID)
);

create table DoctorContracts(
doctorContract_ID int primary key,
contract_start_date date not null,
contract_end_date date not null,
appointment_portion int not null,
salary int not null,
active bit not null,
additional_info varchar(200) null
);

create table Doctors(
doctor_ID int primary key,
doctorContract_ID int not null,
department_ID int not null,
national_code varchar(10) not null,
license_code varchar(15) not null,
first_name varchar(20) not null,
last_name varchar(50) not null,
birthdate date null,
gender varchar(10) Check (gender in('Male','Female','Bi_sexual')),
religion varchar(100) not null,
nationality varchar(50) not null,
marital_status bit not null,
phone_number varchar(15) null,
postal_code varchar(12) null,
[address] varchar(200) null,
education_degree int not null, --[1-3]
specialty_description varchar(100) null,
graduation_date date not null,
university varchar(100) null,
additional_info varchar(200) null,
foreign key(department_ID) references Departments(department_ID),
foreign key(doctorContract_ID) references DoctorContracts(doctorContract_ID)
);

create table PatientIllnesses(
patient_ID int not null,
illness_ID int not null,
detection_date date not null,
severity int null,--[1-5]
additional_info varchar(200) null,
primary key(patient_ID, illness_ID,detection_date),
foreign key(illness_ID) references Illnesses(illness_ID),
foreign key(patient_ID) references Patients(patient_ID)
);

create table Nurses(
nurse_ID int primary key,
national_code varchar(10) not null,
license_code varchar(15) not null,
department_ID int not null,
first_name varchar(20) not null,
last_name varchar(50) not null,
birthdate date null,
gender varchar(10) Check (gender in('Male','Female','Bi_sexual')),
phone_number varchar(15) not null,
postal_code varchar(12) null,
[address] varchar(200) null,
religion varchar(100) not null,
nationality varchar(50) not null,
marital_status bit not null,
education_degree int not null,
specialty_description varchar(100) null,
graduation_date date not null,
university varchar(100) null,
contract_start_date date not null,
contract_end_date date not null,
payment_base int not null,
additional_info varchar(200) null,
foreign key(department_ID) references Departments(department_ID)
);

create table Sections(
section_ID int primary key,
supervisor_ID int not null,
head_nurse_ID int not null,
department_ID int not null,
supervisor_phone_number varchar(15) not null,
head_nurse_phone_number varchar(15) not null,
supervisor_room int not null,
head_nurse_room int not null,
total_room int not null,
budget int not null,
[description] varchar(500),
additional_info varchar(200) null,
foreign key(supervisor_ID) references Doctors(doctor_ID),
foreign key(head_nurse_ID) references Nurses(nurse_ID),
foreign key(department_ID) references Departments(department_ID)
);

create table Hospitalization(
hospitalization_ID int primary key,
patient_ID int not null,
doctor_ID int not null,
hospitalization_reason int not null,
admit_date date not null,
section_ID int not null,
room_number int null,
accompanied_by varchar(50) null,
accompany_phone_number varchar(15) null,
dietary_recommendations varchar(MAX) null,
medication_recommendations varchar(MAX) null,
additional_info varchar(200) null,
foreign key(hospitalization_reason) references Illnesses(illness_ID),
foreign key(patient_ID) references Patients(patient_ID),
foreign key(doctor_ID) references Doctors(doctor_ID),
foreign key(section_ID) references Sections(section_ID)
);

create table Hospitalization_checkout(
hospitalization_checkout_ID int primary key,
hospitalization_ID int not null,
discharg_date date not null,
payment_method bit not null, -- credit card / cash
credit_card_number varchar(16) null, 
payer varchar(50) not null,
payer_phone_number varchar(15) null,
checkout_status bit not null, -- for Installment payment
additional_info varchar(200) null,
foreign key(hospitalization_ID) references Hospitalization(hospitalization_ID)
);

create table Surgeries(
surgery_ID int primary key,
patient_ID int not null,
main_doctor_ID int not null,
anesthesiologist int not null,
surgery_nurse int not null,
[start_date] datetime not null,
duration smallint not null,
main_doctor_portion int not null,
anesthesiologist_portion int not null,
surgery_nurse_portion int not null,
base_price int not null,
paid int not null,
additional_info varchar(200) null,
foreign key(patient_ID) references Patients(patient_ID),
foreign key(main_doctor_ID) references Doctors(doctor_ID),
foreign key(anesthesiologist) references Doctors(doctor_ID),
foreign key(surgery_nurse) references Nurses(nurse_ID)
);

create table MedicineFactories(
medicineFactory_ID int primary key,
[name] varchar(50) not null,
license_code varchar(15) not null,
manager varchar(50) null,
agent varchar(50) null,
phone_number varchar(15) null,
fax_number varchar(15) not null,
website_address varchar(200) null,
manager_phone_number varchar(15) null,
agent_phone_number varchar(15) null,
[address] varchar(200) null,
additional_info varchar(200) null,
active bit not null
);

create table Medicines(
medicine_ID int primary key,
medicineFactory_ID int not null,
[name] varchar(20) not null,
latin_name varchar(50) not null,
dose float not null,
side_effects varchar(100) null,
production_date date not null,
expire_date date not null,
purchase_price int not null,
sales_price int not null,
stock int not null,
[description] varchar(100) null,
medicine_type smallint not null,--0:normal(with reduction with insurance) / 1:beauty(without reduction) / 2:special(free)
additional_info varchar(200) null,
foreign key (medicineFactory_ID) references MedicineFactories(medicineFactory_ID)
);

create table MedicineOrderHeaders(
medicineOrderHeader_ID int primary key,
patient_ID int not null,
order_date date not null,
total_price int not null,
payment_method bit not null, -- credit card / cash
credit_card_number varchar(16) null, 
payer varchar(50) not null,
payer_phone_number varchar(15) null,
additional_info varchar(200) null,
foreign key (patient_ID) references Patients(patient_ID)
);

create table MedicineOrderDetails(
medicineOrderDetails_ID int primary key,
medicineOrderHeader_ID int not null,
medicine_ID int not null,
[count] int not null,
unit_price int not null,
purchase_unit_price int not null,
insurance_portion int not null,
foreign key (medicineOrderHeader_ID) references MedicineOrderHeaders(medicineOrderHeader_ID),
foreign key (medicine_ID) references Medicines(medicine_ID)
);

create table Appointments(
appointment_ID int primary key,
patient_ID int not null,
doctor_ID int not null, 
main_detected_illness int not null,
appointment_number int not null,
appointment_date date not null,
price int not null,
doctor_share int not null,
insurance_share int not null,
payment_method bit not null, -- credit card / cash
credit_card_number varchar(16) null, 
payer varchar(50) not null,
payer_phone_number varchar(15) null,
additional_info varchar(200) null,
foreign key(patient_ID) references Patients(patient_ID),
foreign key(doctor_ID) references Doctors(doctor_ID),
foreign key(main_detected_illness) references Illnesses(illness_ID)
);