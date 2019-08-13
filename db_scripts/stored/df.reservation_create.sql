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
-- Description:	Insert and Create a new reservation
-- =============================================
ALTER PROCEDURE df.reservation_create 
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
GO

