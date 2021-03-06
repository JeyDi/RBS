USE [RBS]
GO
/****** Object:  StoredProcedure [df].[building_detail]    Script Date: 15/08/2019 22:25:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Single Building Details
-- =============================================
ALTER PROCEDURE [df].[building_detail] 
	
	--Input parameters
	@Name varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity INT
	EXEC @Identity = df.building_getID @Name = @Name

	-- Check by name and surname
	IF @Identity IS NOT NULL
			BEGIN
				SELECT 
					[id_building] as id_building
					,[name] as name
					,[address] as address
					,[status] as status
					,[insert_date] as insert_date
					,[update_date] as update_date
				FROM df.Buildings
				WHERE
					id_building = @Identity

			END
		ELSE
			BEGIN
				print('There is no Buildings with this name')
				return -1
			END	
END
