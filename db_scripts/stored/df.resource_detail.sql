USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_detail]    Script Date: 12/08/2019 11:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Single Resource Details
-- =============================================
ALTER PROCEDURE [df].[resource_detail] 
	
	--Input parameters
	@Name varchar(50) = ''
	,@Surname varchar(50) = ''
	,@Username varchar(50) = ''
	,@Email varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int

	-- Check by name and surname
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		
		EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
		IF @Identity != -1
			BEGIN
				SELECT 
					[id_resource] as ID
					,[name] as Name
					,[surname] as Surname
					,[email] as Email
					,[username] as Username
					,[status] as Status
					,[admin] as Admin
					,[insert_date] as Insert_Date
					,[update_date] as Update_Date
				FROM df.Resources
				WHERE
					trim(lower(name)) = trim(lower(@Name))
					AND trim(lower(surname)) = trim(lower(@Surname))

				SET @Result = 1
			END
		ELSE
			BEGIN
			SET @Result = -1
			END
				
	--Check by username
	IF @Username IS NOT NULL

		EXEC @Identity = df.resource_getID NULL, NULL, @Username, NULL
			
		IF @Identity != -1

			BEGIN
				SELECT 
					[id_resource] as ID
					,[name] as Name
					,[surname] as Surname
					,[email] as Email
					,[username] as Username
					,[status] as Status
					,[admin] as Admin
					,[insert_date] as Insert_Date
					,[update_date] as Update_Date
				FROM df.Resources
				WHERE
					id_resource = @Identity

				SET @Result = 1
			END
		ELSE
			BEGIN
			 SET @Result = -1
			END

	--Check by email
	IF @Email IS NOT NULL
		EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
			
		IF @Identity != -1
	BEGIN
		SELECT 
			[id_resource] as ID
			,[name] as Name
			,[surname] as Surname
			,[email] as Email
			,[username] as Username
			,[status] as Status
			,[admin] as Admin
			,[insert_date] as Insert_Date
			,[update_date] as Update_Date
		FROM df.Resources
		WHERE
			id_resource = @Identity

		SET @Result = 1
		END
	ELSE
		BEGIN

			SET @Result = -1
		END	

	return @Result
			
END
