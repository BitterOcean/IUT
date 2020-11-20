create table customer_type(
	type int,
	type_description varchar(500),
	primary key (type)
);

create table customer(
	customer_code int,
	name varchar(200),
	branch int,
	type int,
	id_code varchar(12),
	job varchar(100),
	phone varchar(12),
	primary key (customer_code),
	foreign key  (type) references customer_type(type) 
);

insert into customer_type(type,type_description) values (1,'temporal');
insert into customer_type(type,type_description) values (2,'non-temporal');
insert into customer(
	customer_code,
	name,
	branch,
	type,
	id_code,
	job,
	phone
) values (1,'Nastaran Ashoori',2,1,'1272757811','Programmer','09136920097');
insert into customer(
	customer_code,
	name,
	branch,
	type,	
	id_code,
	job,
	phone
) values (2,'sajede niknadaf',2,2,'1272757812','Developer','09132764355');
insert into customer(
	customer_code,
	name,
	branch,
	type,
	id_code,
	job,
	phone
) values (3,'Maryam saeedmehr',2,1,'1272757813','Manager','09132224355');