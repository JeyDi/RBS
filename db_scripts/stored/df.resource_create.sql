USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_create]    Script Date: 12/08/2019 10:31:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	CreateResource
-- =============================================
ALTER PROCEDURE [df].[resource_create] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Admin bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Check if the person already exist (we are not using the duplicate system for people)
	IF EXISTS (SELECT 1 FROM df.Resources WHERE name = @Name and surname = @Surname)
		BEGIN
			print('Sorry this person already exist')
			return -1
		END
	ELSE
		BEGIN
			--Define username and email
			DECLARE @username varchar(50) = (select LEFT(LOWER(@Surname), 5) + LEFT(LOWER(@Name), 2) + '1' as username)
			DECLARE @email varchar(50) = (select LOWER(@Name) + '.' + LOWER(@Surname) + '@' + 'reti.it')

			--Insert into the table
			INSERT INTO df.Resources(name,surname,email,status,admin,username)
			values(@Name,@Surname,@email,1,@Admin,@username);

			print('New resource inserted')

			--Check if the person was inserted correctly
			select [id_resource], [name], [surname], [email], [username], [admin], [status], [insert_date], [update_date]
			from df.Resources
			where username = @username

			return 1
		END


END
