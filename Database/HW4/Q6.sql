
CREATE TABLE CityUnitPrice (
                CityID INTEGER NOT NULL,
                CityName VARCHAR(40) NOT NULL,
                UnitPrice REAL NOT NULL,
                CONSTRAINT cityunitprice_pk PRIMARY KEY (CityID)
);


CREATE TABLE Cab (
                CabID VARCHAR(17) NOT NULL,
                LicensePlate VARCHAR(11) NOT NULL,
                Model VARCHAR(20) NOT NULL,
                Color VARCHAR(20) NOT NULL,
                CONSTRAINT cab_pk PRIMARY KEY (CabID)
);
COMMENT ON TABLE Cab IS 'Used to store Cab info';
COMMENT ON COLUMN Cab.CabID IS 'Vehicle Identification Number ';


CREATE TABLE CabDriver (
                DriverID NUMERIC(11) NOT NULL,
                CabID VARCHAR(17) NOT NULL,
                CONSTRAINT cabdriver_pk PRIMARY KEY (DriverID, CabID)
);
COMMENT ON TABLE CabDriver IS 'Used to show who drives each cab';


CREATE TABLE Driver (
                PhoneNum NUMERIC(11) NOT NULL,
                FirstName VARCHAR(20) NOT NULL,
                LastName VARCHAR(30) NOT NULL,
                Account NUMERIC(12,2),
                Status INTEGER DEFAULT 1 NOT NULL,
                CONSTRAINT driver_pk PRIMARY KEY (PhoneNum)
);
COMMENT ON TABLE Driver IS 'A Table to store Drivers'' info';
COMMENT ON COLUMN Driver.Status IS '0 : Deactive
1 : Active';


CREATE TABLE Customer (
                PhoneNum NUMERIC(11) NOT NULL,
                FirstName VARCHAR(20) NOT NULL,
                LastName VARCHAR(30) NOT NULL,
                Charge NUMERIC(12,2),
                CONSTRAINT phonenum PRIMARY KEY (PhoneNum)
);
COMMENT ON TABLE Customer IS 'A Table to store customer info.';


CREATE SEQUENCE travel_travelid_seq;

CREATE TABLE Travel (
                TravelID INTEGER NOT NULL DEFAULT nextval('travel_travelid_seq'),
                CustomerID NUMERIC(11) NOT NULL,
                DriverID NUMERIC(11) NOT NULL,
                SourceCity INTEGER NOT NULL,
                SourceAddr_X_Demention REAL NOT NULL,
                SourceAddr_Y_Demention REAL NOT NULL,
                DriverPoint INTEGER,
                ClientPoint INTEGER,
                ClientComment VARCHAR(70),
                Mileages NUMERIC(4,3) NOT NULL,
                Price REAL NOT NULL,
                PaymentType INTEGER DEFAULT 1 NOT NULL,
                Discount INTEGER DEFAULT 0 NOT NULL,
                CONSTRAINT travelid PRIMARY KEY (TravelID)
);
COMMENT ON TABLE Travel IS 'A Table to store travel info';
COMMENT ON COLUMN Travel.PaymentType IS '0 : Incash
1 : Online';


ALTER SEQUENCE travel_travelid_seq OWNED BY Travel.TravelID;

CREATE SEQUENCE destination_destinationid_seq;

CREATE TABLE Destination (
                DestinationID INTEGER NOT NULL DEFAULT nextval('destination_destinationid_seq'),
                TravelID INTEGER NOT NULL,
                Addr_X_Demention REAL NOT NULL,
                Addr_Y_Demention REAL NOT NULL,
                CONSTRAINT destination_pk PRIMARY KEY (DestinationID, TravelID)
);
COMMENT ON TABLE Destination IS 'Used to store different destinations a travel has';


ALTER SEQUENCE destination_destinationid_seq OWNED BY Destination.DestinationID;

CREATE SEQUENCE defaultaddresses_addressid_seq;

CREATE TABLE DefaultAddresses (
                AddressID INTEGER NOT NULL DEFAULT nextval('defaultaddresses_addressid_seq'),
                CustomerID NUMERIC(11) NOT NULL,
                Addr_X_Demention REAL NOT NULL,
                Addr_Y_Demention REAL NOT NULL,
                CONSTRAINT defaultaddresses_pk PRIMARY KEY (AddressID, CustomerID)
);
COMMENT ON TABLE DefaultAddresses IS 'Used to store Default Addresses';


ALTER SEQUENCE defaultaddresses_addressid_seq OWNED BY DefaultAddresses.AddressID;

ALTER TABLE Travel ADD CONSTRAINT cityunitprice_travel_fk
FOREIGN KEY (SourceCity)
REFERENCES CityUnitPrice (CityID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE CabDriver ADD CONSTRAINT cab_cabdriver_fk
FOREIGN KEY (CabID)
REFERENCES Cab (CabID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Travel ADD CONSTRAINT driver_travel_fk
FOREIGN KEY (DriverID)
REFERENCES Driver (PhoneNum)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE DefaultAddresses ADD CONSTRAINT customer_defaultaddresses_fk
FOREIGN KEY (CustomerID)
REFERENCES Customer (PhoneNum)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Travel ADD CONSTRAINT customer_travel_fk
FOREIGN KEY (CustomerID)
REFERENCES Customer (PhoneNum)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Destination ADD CONSTRAINT travel_destination_fk
FOREIGN KEY (TravelID)
REFERENCES Travel (TravelID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
