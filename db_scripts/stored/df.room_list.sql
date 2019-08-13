USE [RBS]
GO
/****** Object:  StoredProcedure [df].[room_list]    Script Date: 06/08/2019 12:28:00 ******/
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
				r.id_room as Room_ID
				,r.name as RoomName
				,r.sittings as Sittings
				,b.id_building as Building_ID
				,b.name as BuildingName
			FROM df.Rooms as r
			INNER JOIN df.Buildings as b
			ON r.id_building = b.id_building
			where r.id_building = @Building_ID
		END
	ELSE
		
		BEGIN
			--Get all the rooms for all the buildings
			SELECT
				r.id_room as Room_ID
				,r.name as RoomName
				,r.sittings as Sittings
				,b.id_building as Building_ID
				,b.name as BuildingName
			FROM df.Rooms as r
			INNER JOIN df.Buildings as b
			ON r.id_building = b.id_building
			
		END
END
