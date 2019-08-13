USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_delete]    Script Date: 05/08/2019 18:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Delete resource already exist
-- =============================================
ALTER PROCEDURE [df].[resource_delete] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Username varchar(50) = '',
	@Email varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int

    -- Remove by name and surname
	IF @Name IS NOT NULL AND @Surname IS NOT NULL

		EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
		IF @Identity != -1
			BEGIN
				DELETE from df.Resources where id_resource = @Identity
				print('Resource deleted with:' + @Name +' and ' + @Surname )
				SET @Result = 1
			END
			BEGIN
				SET @Result = -1
			END


	--Remove by username
	IF @Username IS NOT NULL

		EXEC @Identity = df.resource_getID NULL, NULL, @Username, NULL

		IF @Identity != -1
			BEGIN
				DELETE from df.Resources where id_resource = @Identity
				print('Resource deleted with:' + @Username )
				SET @Result = 1
			END
			BEGIN
				SET @Result = -1
			END

	--Remove by email
	IF @Email IS NOT NULL

		EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
								
		IF @Identity != -1
			BEGIN
				DELETE from df.Resources where id_resource = @Identity
				print('Resource deleted with:' + @Email )
				SET @Result = 1
			END
		ELSE
			BEGIN
				SET @Result = -1
			END

	IF @Name IS NULL AND @Surname IS NULL AND @Username IS NULL AND @Email IS NULL
		print('Please insert valid informations to search and delete a resource')
		SET @Result = -1



	return @Result

END
