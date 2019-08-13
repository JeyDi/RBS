-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Create and define a new Building
-- =============================================
CREATE PROCEDURE df.building_create 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Address varchar(50) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Identity INT

	--Check if the person already exist (we are not using the duplicate system for people)
	IF EXISTS (SELECT 1 FROM df.Buildings WHERE name = @Name and LOWER(TRIM(address)) = LOWER(TRIM(@Address)) )
		BEGIN
			print('Sorry this building already exist')
			return -1
		END
	ELSE
		BEGIN
			

			--Insert into the table
			INSERT INTO df.Buildings(name,address,status)
			values(@Name,@Address,1)

			--Get the ID inserted
			SET @Identity = Scope_Identity()

			print('New building created')

			--Check if the building was inserted correctly
			select [name], [address], [status], [insert_date]
			from df.Buildings
			where id_building = @Identity

			return 1
		END


END
GO
