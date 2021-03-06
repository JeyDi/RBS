USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_getID]    Script Date: 05/08/2019 18:58:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get Resource ID
-- =============================================
ALTER PROCEDURE [df].[resource_getID] 
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Username varchar(50) = '',
	@Email varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identifier INT

    -- Get the ID using name and surname (useless using only name or surname, that's why it's need both)
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(name)) Like trim(lower(@Name)) and trim(lower(surname)) like trim(lower(@Surname)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(name)) = trim(lower(@Name)) AND trim(lower(surname)) = trim(lower(@Surname)) )
				
				print('Resource with:' + @Name +' and ' + @Surname + ' has ID: ' + CAST(@Identifier as varchar(2)) )
				return @Identifier
			END
		ELSE
			BEGIN	
				print('No resources avaiable with name and surname')
				SET @Identifier = -1
				return @Identifier
			END

				--Get the ID using the username
	IF @Username IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(username)) like trim(lower(@Username)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(username)) = trim(lower(@Username)) )
				print('Resource with:' + @Username + ' has ID: ' + CAST(@Identifier as varchar(2)))
				return @Identifier
			END
		ELSE
			BEGIN			
				print('No resources avaiable with username')
				SET @Identifier = -1
				return @Identifier
			END

	--Get the ID using the email
	IF @Email IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(email)) like trim(lower(@Email)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(email)) = trim(lower(@Email)) )
				print('Resource with:' + @Email + ' has ID: ' + CAST(@Identifier as varchar(2)) )
				return @Identifier
			END
		ELSE
			BEGIN
				--If no one was found
				print('No resource available, impossible to find the person that you are looking for...')
				SET @Identifier = -1
				return @Identifier
			END

END
