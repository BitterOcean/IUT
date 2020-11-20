CREATE TABLE [dbo].[SCD_2](
	[customer_code] [int] NULL,
	[name] [varchar](200) NULL,
	[branch] [int] NULL,
	[type] [int] NULL,
	[id_code] [varchar](12) NULL,
	[job] [varchar](100) NULL,
	[phone] [varchar](12) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[current_flag] [int] NULL,
	[su_key] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY
) ON [PRIMARY];