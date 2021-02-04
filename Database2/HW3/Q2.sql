--------------------------------------------------------------------------------------
--DDL Scripts
--------------------------------------------------------------------------------------
CREATE TABLE Stations(
  ID         INT,
  City       NVARCHAR(20),
  State      NVARCHAR(20),
  Latitude   FLOAT,
  Longtitude FLOAT 
)
GO

INSERT INTO Stations VALUES (1,'Asheville','North Carolina',35.6,82.6)
INSERT INTO Stations VALUES (2,'Burlington','North Carolina',36.1,79.4)
INSERT INTO Stations VALUES (3,'Chapel Hill','North Carolina',35.9,79.1)
INSERT INTO Stations VALUES (4,'Davidson','North Carolina',35.5,80.8)
INSERT INTO Stations VALUES (5,'Elizabeth City','North Carolina',36.3,76.3)
INSERT INTO Stations VALUES (6,'Fargo','North Dakota',46.9,96.8)
INSERT INTO Stations VALUES (7,'Grand Forks','North Dakota',47.9,97.0)
INSERT INTO Stations VALUES (8,'Hettinger','North Dakota',46.0,102.6)
INSERT INTO Stations VALUES (9,'Inkster','North Dakota',48.2,97.6)

--------------------------------------------------------------------------------------
--Desired Scripts
--------------------------------------------------------------------------------------
SELECT * FROM Stations;

WITH T AS (
	SELECT State,
				Latitude,
				ROW_NUMBER() OVER (
					 PARTITION BY State
					 ORDER BY Latitude ASC) AS RowAsc,
				ROW_NUMBER() OVER (
					 PARTITION BY State
					 ORDER BY Latitude DESC) AS RowDesc
   FROM Stations)
SELECT State,
			 AVG(Latitude) AS MEDIAN_LATITUDE
FROM T
WHERE RowAsc IN (RowDesc, RowDesc - 1, RowDesc + 1)
GROUP BY State
ORDER BY State;

