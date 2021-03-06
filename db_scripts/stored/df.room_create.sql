USE [RBS]
GO
/****** Object:  StoredProcedure [df].[room_create]    Script Date: 15/08/2019 21:41:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Create a new room
-- =============================================
ALTER PROCEDURE [df].[room_create] 
	
	@Name varchar(50) = ''
	,@Sittings int = 0
	,@Building_Name varchar(50) = ''
	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Name_Check INT
	DECLARE @Building_ID INT
	
	IF @Name IS NOT NULL AND @Sittings != 0
		BEGIN
			
			--Check if the building already exist
			EXEC @Building_ID = df.building_getID @Building_Name

			IF @Building_ID > 0 AND @Building_ID IS NOT NULL
				BEGIN 
					
					--Check if the name already exist
					EXEC @Name_Check = df.check_names @Name, NULL, 'r'

					IF @Name_Check = 0
						BEGIN
						INSERT INTO df.Rooms(name,sittings,id_building)
						VALUES(@Name, @Sittings, @Building_ID)
						print('New room inserted in the building: ' + CAST(@Building_ID as varchar(2)))

						--Check the room inserted
						DECLARE @Room_Id int = null
						exec @Room_Id = df.room_getID @Name

						SELECT 
							r.id_room as room_id
							,r.name as room_name
							,r.sittings as room_sittings
							,r.id_building as build_id
							,b.name as build_name
						
						FROM
							df.Rooms as r
							INNER JOIN df.Buildings as b
							ON r.id_building = b.id_building
						where r.id_room = @Room_Id AND r.id_building = @Building_ID


						return 1

						END
					ELSE
						BEGIN
						print('Another room found, please change the name if you want to create a new one')
						return -1
						END
				END
			ELSE
				BEGIN
					print('Impossibile to find a valid building for the room, please insert a valid building name')
					return -1
				END

		END

END
