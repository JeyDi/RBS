USE [RBS]
GO
/****** Object:  StoredProcedure [df].[check_names]    Script Date: 26/08/2019 16:59:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Check same names
-- =============================================
ALTER PROCEDURE [df].[check_names] 
	
	--TODO: Need to create a function to better generalize the Count

	@Name varchar(50) = ''
	,@Surname varchar(50) = ''

	--Define the table that you want to use for the check
	-- R = rooms
	-- B = buildings
	-- S = resources
	,@Table varchar(2) = ''

AS
BEGIN

	DECLARE @Count int
	DECLARE @Result int

	SET NOCOUNT ON;

	--Case 1: Rooms
	IF TRIM(LOWER(@Table)) like 'r'
		BEGIN
			SET @Count = ( SELECT Count(*)
							FROM df.Rooms
							WHERE TRIM(LOWER(name)) = TRIM(LOWER(@Name))
							)
			IF @Count > 0
				BEGIN
					print('Duplicate found in rooms')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in rooms')
					SET @Result = 0
				END
		END


	--Case 2: Buildings
	IF TRIM(LOWER(@Table)) like 'b'
		BEGIN
			SET @Count = (SELECT Count(*)
							FROM df.Buildings
							WHERE TRIM(LOWER(name)) LIKE TRIM(LOWER(@Name))
							)
			IF @Count > 0
				BEGIN
					print('Duplicate found in buildings')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in buildings')
					SET @Result = 0
				END
		END	

	--Case 3: Resources --> use to check if there is Homonyms
	IF TRIM(LOWER(@Table)) like 's'
		BEGIN
			SET @Count = (SELECT Count(*)
							FROM df.Resources
							WHERE TRIM(LOWER(name)) LIKE TRIM(LOWER(@Name)) AND
									TRIM(LOWER(surname)) LIKE TRIM(LOWER(@Surname))
							)
				IF @Count > 0
				BEGIN
					print('Duplicate found in resource')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in resource')
					SET @Result = 0
				END
		END

	----Case: Invalid
	--IF TRIM(LOWER(@Table)) NOT LIKE 'r' OR TRIM(LOWER(@Table)) NOT LIKE 'b' OR TRIM(LOWER(@Table)) NOT LIKE 's'
	--	BEGIN
	--		print('Please define a correct Table Like: b,s,r')
	--		SET @Result = 0
	--	END

	
	RETURN @Result

END
