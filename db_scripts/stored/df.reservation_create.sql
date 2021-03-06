USE [RBS]
GO
/****** Object:  StoredProcedure [df].[reservation_create]    Script Date: 16/08/2019 19:13:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Insert and Create a new reservation
-- =============================================
ALTER PROCEDURE [df].[reservation_create] 
	-- Add the parameters for the stored procedure here
	@Event varchar(50) = NULL
	,@Description varchar(50) = NULL
	,@Resource_username varchar(50) = NULL
	,@Room_name varchar(50) = NULL
	,@Start_date datetime2 = NULL
	,@End_date datetime2 = NULL
AS
BEGIN
	
	DECLARE @Previous_Reservation INT = 0
	DECLARE @Building_ID INT = -1
	DECLARE @Room_ID INT = -1
	DECLARE @Resource_ID INT = -1

	SET NOCOUNT ON;

	--Check if event and description are populated in input
	IF @Event IS NOT NULL AND @Description IS NOT NULL
		BEGIN
			--Check if the room is populated in input
			IF @Room_name IS NOT NULL
				BEGIN

					--Get the Room ID and Building ID
					exec @Room_ID = df.room_getID @Room_name
					SET @Building_ID = (SELECT id_building from df.Rooms where id_room = @Room_ID)

					--Exec only if the start date and end date are corrected
					IF @Start_date IS NOT NULL AND @End_date IS NOT NULL
					BEGIN
						--Check if there is no other reservation for that room and building in the period
						exec @Previous_Reservation = df.reservation_duplicates @Building_ID, @Room_ID, @Start_date, @End_date

						--If there aren't other previous reservation continue
						IF @Previous_Reservation <= 0
							BEGIN

								--Check if there is the correct username in input
								IF @Resource_username iS NOT NULL
									BEGIN

									--Check if the person already exist
									EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL

									--Create a new reservation
									INSERT INTO df.Reservations(event,description,start_date,end_date,id_resource, id_room)
									VALUES(@Event,@Description,@Start_date,@End_date, @Resource_ID, @Room_ID)

									print('New reservation inserted correctly for the event: ' + @Event)

									--Check reservation inserted
									SELECT
										r.id_reservation as reserv_id
										,r.event as reserv_event
										,r.description as reserv_description
										,r.start_date as reserv_start_date
										,r.end_date as reserv_end_date
										,r.id_resource as resource_id
										,s.name as resource_name
										,s.surname as resource_surname
										,s.username as resource_username
										,s.email as resource_email
										,r.id_room as room_id
										,o.name as room_name
										,o.sittings as room_sittings
										,o.id_building as build_id
										,b.name as build_name
										
									FROM 
										df.Reservations as r
										INNER JOIN df.Resources as s
											ON r.id_resource = s.id_resource
										INNER JOIN df.Rooms as o
											ON r.id_room = o.id_room
										INNER JOIN df.Buildings as b
											ON o.id_building = b.id_building

									WHERE 
										r.id_resource = @Resource_ID 
										AND r.id_room = @Room_ID 
										AND @Start_date = @Start_date


									return 1

									END
								ELSE
									BEGIN
										print('impossibile to find the person for the reservation')
										return -1
									END
							END
						ELSE
							BEGIN
								print('there are other reservations on this date, impossible to create a new one')
								return -1
							END
					END
				END
			ELSE
				BEGIN
					print('please insert a valid room id that you want to use for your reservation')
					return -1
				END
		END
	ELSE
		BEGIN
		print('Invalid parameters, impossibile to create a new appointment with this info')
		return -1
		END
   
END
