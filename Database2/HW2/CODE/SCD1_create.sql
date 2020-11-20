CREATE TABLE [dbo].[SCD_1](
	[customer_code] [int] NOT NULL,
	[name] [varchar](200) NULL,
	[branch] [int] NULL,
	[type] [int] NULL,
	[id_code] [varchar](12) NULL,
	[phone] [varchar](12) NULL,
	[job] [varchar](100) NULL,
	primary key (customer_code)
)

