USE [AdventureWorks2012]
GO
/****** Object:  Trigger [Production].[UpdateLog]    Script Date: 12/9/2019 12:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maryam Saeedmehr
-- Create date: 12/8/2019 11:02PM
-- Description:	Make Logs for 'UPDATE'
-- =============================================
ALTER TRIGGER [Production].[UpdateLog]
   ON [Production].[Product]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		DECLARE @ModificationType VARCHAR(50)

		IF UPDATE([Name])
		BEGIN
		SET @ModificationType = 'Updated Name'
		END

		IF UPDATE(ProductNumber)
		BEGIN
		SET @ModificationType = 'Updated ProductNumber'
		END
					
		IF UPDATE(MakeFlag)
		BEGIN
		SET @ModificationType = 'Updated MakeFlag'
		END

		IF UPDATE(FinishedGoodsFlag)
		BEGIN
		SET @ModificationType = 'Updated FinishedGoodsFlag'
		END

		IF UPDATE(Color)
		BEGIN
		SET @ModificationType = 'Updated Color'
		END

		IF UPDATE(SafetyStockLevel)
		BEGIN
		SET @ModificationType = 'Updated SafetyStockLevel'
		END

		IF UPDATE(ReorderPoint)
		BEGIN
		SET @ModificationType = 'Updated ReorderPoint'
		END

		IF UPDATE(StandardCost)
		BEGIN
		SET @ModificationType = 'Updated StandardCost'
		END

		IF UPDATE(ListPrice)
		BEGIN
		SET @ModificationType = 'Updated ListPrice'
		END

		IF UPDATE(Size)
		BEGIN
		SET @ModificationType = 'Updated Size'
		END

		IF UPDATE(SizeUnitMeasureCode)
		BEGIN
		SET @ModificationType = 'Updated SizeUnitMeasureCode'
		END

		IF UPDATE(WeightUnitMeasureCode)
		BEGIN
		SET @ModificationType = 'Updated WeightUnitMeasureCode'
		END

		IF UPDATE([Weight])
		BEGIN
		SET @ModificationType = 'Updated Weight'
		END

		IF UPDATE(DaysToManufacture)
		BEGIN
		SET @ModificationType = 'Updated DaysToManufacture'
		END

		IF UPDATE(ProductLine)
		BEGIN
		SET @ModificationType = 'Updated ProductLine'
		END

		IF UPDATE(Class)
		BEGIN
		SET @ModificationType = 'Updated Class'
		END

		IF UPDATE(Style)
		BEGIN
		SET @ModificationType = 'Updated Style'
		END

		IF UPDATE(ProductSubcategoryID)
		BEGIN
		SET @ModificationType = 'Updated ProductSubcategoryID'
		END

		IF UPDATE(ProductModelID)
		BEGIN
		SET @ModificationType = 'Updated ProductModelID'
		END

		IF UPDATE(SellStartDate)
		BEGIN
		SET @ModificationType = 'Updated SellStartDate'
		END

		IF UPDATE(SellEndDate)
		BEGIN
		SET @ModificationType = 'Updated SellEndDate'
		END

		--IF UPDATE(DiscontinuedDate)
		--BEGIN
		--SET @ModificationType = 'Updated DiscontinuedDate'
		--END

		IF UPDATE(rowguid)
		BEGIN
		SET @ModificationType = 'Updated rowguid'
		END

		--IF UPDATE(ModifiedDate)
		--BEGIN
		--SET @ModificationType = 'Updated ModifiedDate'
		--END

		INSERT INTO ProductLog 
		SELECT * , @ModificationType
		FROM inserted

END