-- DATABASE DESIGN 1 3981 @ IUT
-- YOUR NAME:   Maryam Saeedmehr
-- YOUR STUDENT NUMBER:   9629373


---- Q4-A

create table country(
	country_id integer primary key,
	country varchar(50) not null
);

create table province(
	province_id integer primary key,
	province varchar(50) not null,
	country_id integer references country(country_id)
);

create table city(
	city_id integer primary key,
	city varchar(50) not null,
	province_id integer references province(province_id)
);

create table airport(
	airport_id char(3) primary key,
	airport_name varchar(50) not null,
	city_id integer references city(city_id),
	latitude numeric(8,4),
	longitude numeric(8,4)
);

create table airline(
	airline_id char(2) primary key,
	airline_name varchar(50) not null
);

create table passenger(
	passenger_id integer primary key,
	firstname varchar(50) not null,
	lastname varchar(50) not null,
	age integer,
	gender varchar(7),
	check(gender in('male','female'))
);

create table flight(
	flight_id integer primary key,
	flight_date date,
	source_airport_id char(3) references airport(airport_id),
	destination_airport_id char(3) references airport(airport_id),
	flight_time time,
	airline_id char(2) references airline(airline_id),
	flight_number integer,
	last_price numeric(8,2),
	last_capacity integer
);

create table ticket(
	ticket_id integer primary key,
	flight_id integer references flight(flight_id),
	passenger_id integer references passenger(passenger_id),
	seat_number integer,
	totalPrice numeric(8,2)
);

create table price_capacity(
	flight_id integer references flight(flight_id),
	time_date timestamp, 
	price numeric(8,2),
	capacity integer,
	channel varchar(7),
	primary key(flight_id,time_date),
	check( channel in('web','system','phone'))
);

CREATE FUNCTION update_price_capacity_func()
  RETURNS trigger AS
$BODY$
BEGIN
       IF nrow.time_date > all(select time_date
								from price_capacity
					   			where price_capacity.flight_id=nrow.flight_id)
	   THEN
			update flight
			set last_price=nrow.price,last_capacity=nrow.capacity
			where flight.flight_id=nrow.flight_id; 
	   END IF;
   RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE -- Says the function is implemented in the plpgsql language; VOLATILE says the function has side effects.
COST 100; -- Estimated execution cost of the function.

CREATE TRIGGER update_price_capacity
	AFTER INSERT OR UPDATE
	OF time_date
	ON price_capacity
	FOR EACH ROW
	EXECUTE PROCEDURE update_price_capacity_func();

--Data is imported to the tables from the CSV files attached to the answere sheet

---- Q4-B

CREATE VIEW Flight_Date_Num
AS(WITH TempTable AS (SELECT flight.* , province AS Source_Province
						FROM flight 
							INNER JOIN airport ON airport.airport_id=flight.source_airport_id
							INNER JOIN city USING(city_id)
							INNER JOIN province USING(province_id))
	select flight_date , Source_Province , province AS destination_Province , COUNT(*) AS numberOfFlights
	FROM TempTable 
		INNER JOIN airport ON airport.airport_id=TempTable.destination_airport_id
		INNER JOIN city USING(city_id)
		INNER JOIN province USING(province_id)
	GROUP BY(flight_date , Source_Province , destination_Province)
	HAVING(EXTRACT(YEAR FROM flight_date)=1992))

SELECT * FROM Flight_Date_Num

---- Q4-C

CREATE VIEW Flight_Last_Price
AS(select flight_id, flight_date, source_airport_id
  	  ,destination_airport_id, flight_time, airline_id
   	  ,flight_number,price_capacity.price,price_capacity.capacity
   FROM flight INNER JOIN price_capacity USING(flight_id))

CREATE VIEW Flight_Last_Price_Diff
AS(select flight.* , flight.last_price - Flight_Last_Price.price AS Diffrences
   FROM flight INNER JOIN Flight_Last_Price USING(flight_id)
   WHERE flight.last_price <> Flight_Last_Price.price)

---- Q4-D

CREATE VIEW Source_airports
AS(WITH TempTable AS(
		SELECT airport_id , airport_name , city_id , city , province_id
		FROM airport 
			INNER JOIN city USING(city_id)
			INNER JOIN province USING(province_id)
		)
	SELECT airport_id , airport_name , 
   			CASE WHEN COUNT(province_id)=1  THEN -1
				  ELSE city_id
   			END AS city_id,
   			CASE WHEN COUNT(province_id)=1  THEN '-1' 
				  ELSE city
   			END AS city
	FROM TempTable
  	GROUP BY(airport_id,airport_name,city_id,city))

---- Q4-E
--POSTGRESQL10 does not support procedures so that I wrote function instead :)
CREATE TABLE flightLog(
	flight_id integer ,
    source_airport_id character(3) ,
    destination_airport_id character(3) ,
    flight_time time without time zone,
    airline_id character(2) ,
    flight_number integer,
    last_price numeric(8,2),
    last_capacity integer,
    modification_dateTime timestamp
);

CREATE FUNCTION log_flight_changes()
  RETURNS trigger AS
$BODY$
BEGIN
       INSERT INTO flightLog
       VALUES(OLD.flight_id,
			  OLD.source_airport_id,
			  OLD.destination_airport_id,
			  OLD.flight_time,
			  OLD.airline_id,
			  OLD.flight_number,
			  OLD.last_price,
			  OLD.last_capacity,
			  NOW());
   RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE -- Says the function is implemented in the plpgsql language; VOLATILE says the function has side effects.
COST 100; -- Estimated execution cost of the function.

CREATE TRIGGER update_flight
	AFTER UPDATE
	ON flight
	FOR EACH ROW
	EXECUTE PROCEDURE log_flight_changes();

---- Q4-F
--POSTGRESQL10 does not support procedures so that I wrote function instead :)
CREATE FUNCTION update_last_priceANDcapacity()
  RETURNS trigger AS
$BODY$
BEGIN
       UPDATE fligh
	   SET last_price = NEW.last_price;
	   UPDATE fligh
	   SET last_capacity = NEW.last_capacity;	  
   RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE -- Says the function is implemented in the plpgsql language; VOLATILE says the function has side effects.
COST 100; -- Estimated execution cost of the function.

CREATE TRIGGER update_priceANDcapacity_flight
	AFTER INSERT
	ON price_capacity
	FOR EACH ROW
	EXECUTE PROCEDURE update_last_priceANDcapacity();

---- Q4-G


????????????????????????????



---- Q4-H

CREATE TABLE TravelLog(
	flight_id integer ,
    source_airport_id character(3) ,
    destination_airport_id character(3) ,
    flight_time time without time zone,
    airline_id character(2) ,
    flight_number integer
);

CREATE FUNCTION TravelLogFunc()
  RETURNS VOID AS $$
	  INSERT INTO TravelLog
	  SELECT flight_id,source_airport_id,destination_airport_id,flight_time,airline_id,flight_number
	  FROM flight
	  WHERE flight_date < CURRENT_DATE OR ( flight_date = CURRENT_DATE AND flight_time < CURRENT_TIME );

	  DELETE
	  FROM flight
	  WHERE flight_date < CURRENT_DATE OR ( flight_date = CURRENT_DATE AND flight_time < CURRENT_TIME );
	  
$$ LANGUAGE SQL;

---- Q4-I

CREATE ROLE TicketSeller
GRANT INSERT,DELETE,UPDATE ON ticket TO TicketSeller;
GRANT SELECT ON flight TO TicketSeller;
GRANT SELECT ON passenger TO TicketSeller;
GRANT SELECT ON price_capacity TO TicketSeller;

---- Q5

create recursive view fact(num,factorial) as(
	values(0,cast(1 as numeric(38,0)))
	union all
		select num+1,cast((num+1)*factorial as numeric(38,0))
		from fact
		where num<33
);
select num,factorial
from fact

---- Q7-A

CREATE MATERIALIZED VIEW CategoryBaseRental
AS
	with SourceTable as(
		SELECT store_id,name,amount
		FROM inventory 
			 INNER JOIN rental USING(inventory_id)
			 INNER JOIN film_category USING(film_id)
			 INNER JOIN category USING(category_id)
			 INNER JOIN payment USING(rental_id))
	SELECT distinct store_id AS Store,name AS Category,sum(amount)over(partition by store_id,name) AS TotalSales
	FROM SourceTable
	GROUP BY store_id,name,amount 
	ORDER BY store_id,name ASC
WITH NO DATA;

REFRESH MATERIALIZED VIEW CategoryBaseRental;-- Used for refreshing MATERIALIZED VIEW 

DROP MATERIALIZED VIEW CategoryBaseRental;-- Used for deleting MATERIALIZED VIEW 

---- Q7-B

CREATE VIEW NewFilm
AS
	SELECT film_id, title, description,
			release_year, language_id,
			rental_duration -1 as rental_duration,
			rental_rate,length, replacement_cost,
			rating,special_features, fulltext,name
	FROM film INNER JOIN language USING(language_id)
	WHERE name='English';

---- Q7-C

CREATE ROLE SalesStaff;
GRANT SELECT ON inventory TO SalesStaff;
CREATE ROLE StoreManagement;
GRANT SalesStaff TO StoreManagement;
GRANT SELECT,UPDATE,INSERT,DELETE ON staff TO StoreManagement;
GRANT UPDATE,INSERT,DELETE ON inventory TO StoreManagement;

