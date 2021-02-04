---------------------------------------------------------------------------
--DDL Scripts
---------------------------------------------------------------------------
 CREATE TABLE Turn_Over(
 DEP_ID     INT,
 TRN_TIME   DATETIME,
 TRN_OVER   INT
 )
 GO

 CREATE TABLE factdeptrn(
 DEP_ID     INT,
 TRN_TIME   DATETIME,
 TRN_OVER   INT,
 BALANCE    INT
 )
 GO

 CREATE TABLE factdeposit(
   DEP_ID   INT,
   TIMEKEY  DATE,
   BALANCE  INT
 )
 GO

 TRUNCATE TABLE Turn_Over
 INSERT INTO Turn_Over VALUES (1022,'2018-06-15 14:00',100)
 INSERT INTO Turn_Over VALUES (1022,'2018-06-15 14:28',-50)
 INSERT INTO Turn_Over VALUES (1022,'2018-06-16 14:58',25)
 INSERT INTO Turn_Over VALUES (1067,'2019-07-18 23:32',300)

 TRUNCATE TABLE factdeposit
 INSERT INTO factdeposit VALUES (1022, '2018-06-14', 0)
 INSERT INTO factdeposit VALUES (1022, '2018-06-15', 50)
 INSERT INTO factdeposit VALUES (1022, '2018-06-16', 75)
 INSERT INTO factdeposit VALUES (1067, '2019-07-17', 0)

---------------------------------------------------------------------------
--Desired Procedure
---------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE uspFactDepTrnLoader 
AS
BEGIN
    BEGIN TRY
	TRUNCATE TABLE factdeptrn;
	DECLARE @curr_date DATE;
	DECLARE @end_date DATE;
	DECLARE @last_date DATE;
	DECLARE @first_last_date DATE;
	DECLARE @all_today_trn TABLE(
            DEP_ID      INT,
            TRN_TIME    DATETIME,
            TRN_OVER    INT
        );
        DECLARE @today_last_remain TABLE(
            DEP_ID      INT,
            TRN_TIME    DATETIME,
            TRN_OVER    INT,
            BALANCE     INT
        );
        SET @end_date=(
			SELECT CONVERT(DATE, MAX(TRN_TIME))
			FROM Turn_Over
	);
	SET @last_date=(
			SELECT CONVERT(DATE, MAX(TRN_TIME))
			FROM factdeptrn 
	);
	SET @first_last_date=(
			 SELECT CONVERT(DATE, MIN(TRN_TIME)) 
			 FROM Turn_Over
	);
        SET @curr_date=(
            SELECT ISNULL(@last_date, @first_last_date)
        );
        --------------------------------------------------------
        WHILE @curr_date <= @end_date 
        BEGIN   
            DELETE FROM @all_today_trn
            DELETE FROM @today_last_remain

	    INSERT INTO @all_today_trn
            SELECT DEP_ID,
                   TRN_TIME,
                   TRN_OVER
            FROM Turn_Over
            WHERE TRN_TIME >= @curr_date AND 
                  TRN_TIME < DATEADD(DAY, 1, @curr_date) 
                  
            INSERT INTO @today_last_remain
            SELECT DEP_ID,
                   TRN_TIME,
                   TRN_OVER,
                   SUM(TRN_OVER) OVER (
                       PARTITION BY DEP_ID 
                       ORDER BY TRN_TIME ROWS 
                       BETWEEN UNBOUNDED PRECEDING 
                       AND CURRENT ROW
                       ) AS BALANCE
            FROM @all_today_trn
            GROUP BY DEP_ID, TRN_TIME, TRN_OVER
            
            INSERT INTO factdeptrn
            SELECT T.DEP_ID,
                   T.TRN_TIME,
                   T.TRN_OVER,
                   T.BALANCE + D.BALANCE AS BALANCE
            FROM @today_last_remain AS T INNER JOIN factdeposit AS D
                 ON T.DEP_ID = D.DEP_ID
            WHERE D.TIMEKEY = DATEADD(DAY, -1, @curr_date)
            
            SET @curr_date = DATEADD(DAY, 1, @curr_date)
        END
        --------------------------------------------------------
    END TRY
    BEGIN CATCH
        PRINT 'ERROR : Procedure FAILED!'
        RETURN
    END CATCH
END
GO

---------------------------------------------------------------------------
--Test the Procedure
---------------------------------------------------------------------------
 SELECT * FROM Turn_Over
 SELECT * FROM factdeposit
 EXEC uspFactDepTrnLoader
 SELECT * FROM factdeptrn
