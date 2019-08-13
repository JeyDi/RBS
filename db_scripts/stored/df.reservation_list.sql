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
-- Description:	Get Reservation List
-- =============================================
CREATE PROCEDURE df.reservation_list 
	
	@Start_Date datetime2 NULL
	,@End_Date datetime2 NULL
	,@Resource_username varchar(50) NULL
AS
BEGIN
	
	DECLARE @Resource_ID INT
	
	SET NOCOUNT ON;

	IF @Resource_username IS NOT NULL
		BEGIN
			
			--Check if the person already exist
			EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL

			IF @Resource_ID > 0
				BEGIN
					
					IF @Start_Date IS NOT NULL AND @End_Date IS NOT NULL
						BEGIN
								
							--Get the reservation (using the udf to check duplicates)

							SELECT
								r.id_reservation as ID
								,r.event as EventName
								,r.description as Description
								,r.start_date as StartDate
								,r.end_date as EndDate
								,rms.name as RoomName
								,b.name as BuildingName
							FROM df.Reservations as r
							INNER JOIN [df].[udf_reservation_search_byUser](@Start_Date,@End_Date,@Resource_ID) as s
							ON r.id_reservation = s.ID
							INNER JOIN df.Rooms as rms
							ON r.id_room = rms.id_room
							INNER JOIN df.Buildings as b
							ON rms.id_building = b.id_building


						END
					ELSE
						BEGIN
							print('Please specify valid start and end dates...')
							return NULL
						END

				END
			ELSE
				BEGIN
					print('Username not valid..')
					return NULL
				END

		END
	ELSE
		BEGIN
			print('You can''t all the Reservation, please insert a valid username')
			return NULL
		END

    
	
END
GO
