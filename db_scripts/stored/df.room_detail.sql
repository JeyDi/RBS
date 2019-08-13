USE [RBS]
GO
/****** Object:  StoredProcedure [df].[room_detail]    Script Date: 06/08/2019 12:13:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get details for a room
-- =============================================
ALTER PROCEDURE [df].[room_detail] 
	-- Add the parameters for the stored procedure here
	
	@RoomName varchar(50) = ''
AS
BEGIN
	
	
	SET NOCOUNT ON;
	DECLARE @Identity INT
	EXEC @Identity = df.room_getID @RoomName

	--Get room detail by ID
	IF @Identity > 0 AND @Identity IS NOT NULL
		BEGIN
			SELECT
				r.id_room as Room_ID
				,r.name as RoomName
				,r.sittings as Sittings
				,b.id_building as Building_ID
				,b.name as BuildingName
			FROM df.Rooms as r
			INNER JOIN df.Buildings as b
			ON r.id_building = b.id_building
			WHERE r.id_room = @Identity
		END

	ELSE
		
		BEGIN
		--No room founded
		print('Impossibile to find a room with those parameters, please retry..')
		return -1
		END

END
