USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_delete]    Script Date: 29/08/2019 16:38:33 ******/
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
	DECLARE @Result int = 0

    -- Remove by name and surname
	IF @Result != 1 AND ((@Name IS NOT NULL AND @Surname IS NOT NULL) OR (@Name != '' AND @Surname != ''))
		BEGIN
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
		END

	--Remove by username
	IF @Result != 1 AND (@Username IS NOT NULL OR @Username != '')
		BEGIN
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
		END

	--Remove by email
	IF @Result != 1 AND (@Email IS NOT NULL OR @Email != '')
		BEGIN
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
		END

	IF @Name IS NULL AND @Surname IS NULL AND @Username IS NULL AND @Email IS NULL
		BEGIN
			print('Please insert valid informations to search and delete a resource')
			SET @Result = -1
		END


	return @Result

END
