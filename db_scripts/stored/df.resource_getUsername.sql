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
-- Create date: 06/08/2019
-- Description:	Get Resource Username
-- =============================================
CREATE PROCEDURE df.resource_getUsername 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '',
	@Surname varchar(50) = '',
	@Email varchar(50) = ''
	
AS
BEGIN

	SET NOCOUNT ON;

	--1. get id using name, surname, email
	--2. use id to search and get username

	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int

	-- Check by name and surname
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		
		EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
		IF @Identity > 0
			BEGIN
				SET @Result = (SELECT TOP 1
					[username]
				FROM df.Resources
				WHERE
					id_resource = @Identity)

			END
		ELSE
			BEGIN
			SET @Result = NULL
			END

	IF @Email IS NOT NULL
		EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
			
		IF @Identity > 0
	BEGIN
		SET @Result = (SELECT 
			[username]
		FROM df.Resources
		WHERE
			id_resource = @Identity)

		END
	ELSE
		BEGIN

			SET @Result = NULL
		END	

	return @Result

END
GO
