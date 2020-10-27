---------------------------------------------------------------------------------------------
CREATE TABLE [Trn_Src_Des](
    [VoucherId] [varchar](21) NULL,
    [TrnDate] [date] NULL,
    [TrnTime] [varchar](6) NULL,
    [Amount] [bigint] NULL,
    [SourceDep] [int] NULL,
    [DesDep] [int] NULL
);

DELETE FROM [Trn_Src_Des];

INSERT INTO [Trn_Src_Des] VALUES ('10','2019-01-01',101000,1000,45,23);
INSERT INTO [Trn_Src_Des] VALUES ('11','2019-01-01',101000,1000,45,23);
INSERT INTO [Trn_Src_Des] VALUES ('12','2019-01-01',091000,200,345,NULL);
INSERT INTO [Trn_Src_Des] VALUES ('14','2019-01-02',080023,300,NULL,45);
INSERT INTO [Trn_Src_Des] VALUES ('15','2019-01-05',151201,700,438,259);
INSERT INTO [Trn_Src_Des] VALUES ('16','2019-01-05',151201,700,438,259);
INSERT INTO [Trn_Src_Des] VALUES ('25','2019-02-15',132022,1700,876,2000);

---------------------------------------------------------------------------------------------
CREATE PROCEDURE MergeDup
AS
BEGIN
		DECLARE @MyTempTable TABLE (
		[VoucherId] [varchar](21) NULL,
		[TrnDate] [date] NULL,
		[TrnTime] [varchar](6) NULL,
		[Amount] [bigint] NULL,
		[SourceDep] [int] NULL,
		[DesDep] [int] NULL
		);
		WITH A AS (SELECT * , ROW_NUMBER() OVER (PARTITION BY [TrnDate],[TrnTime],[Amount],[SourceDep],[DesDep] ORDER BY [VoucherId]) AS [RN_NUM]
							FROM [Trn_Src_Des]), B AS (SELECT A.*, LEAD([VoucherId], 1,0) OVER (ORDER BY [VoucherId]) AS [NextVo], LEAD([RN_NUM], 1,0) OVER (ORDER BY [VoucherId]) AS [NextRn]
							FROM A)
		INSERT  INTO @MyTempTable  
		SELECT *
		FROM(
		SELECT CASE 
						WHEN [NextRn] = 2 THEN [VoucherId] + '|' + [NextVo]
						ELSE [VoucherId]
					END AS [VoucherId],[TrnDate],[TrnTime],[Amount],[SourceDep],[DesDep]
		FROM B
		WHERE [RN_NUM] <> 2) AS C;
		DELETE FROM [Trn_Src_Des];
		INSERT INTO [Trn_Src_Des] SELECT * FROM @MyTempTable;
END
---------------------------------------------------------------------------------------------
SELECT * FROM [Trn_Src_Des];
EXEC MergeDup;
SELECT * FROM [Trn_Src_Des];
