USE [RBS]
GO
/****** Object:  StoredProcedure [df].[room_list]    Script Date: 19/08/2019 17:59:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get the list of all rooms by building
-- =============================================
ALTER PROCEDURE [df].[room_list] 

	
	@Building_name varchar(50) = ''
	
AS
BEGIN
	
	DECLARE @Building_ID int
	
	EXEC @Building_ID = df.building_getID @Building_name

	SET NOCOUNT ON;

	IF @Building_ID > 0 AND @Building_ID IS NOT NULL
		BEGIN
			--Get the Rooms by Building ID
			SELECT 
				r.id_room as room_id
				,r.name as room_name
				,r.sittings as room_sittings
				,r.id_building as build_id
				,b.name as build_name
			FROM df.Rooms as r
			INNER JOIN df.Buildings as b
			ON r.id_building = b.id_building
			where r.id_building = @Building_ID
		END
	ELSE
		
		BEGIN
			print('Building not found, impossibile to see all the rooms')
			return null;
			
		END
END

