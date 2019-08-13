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
-- Description:	Get ID of a Reservation
-- =============================================
ALTER PROCEDURE df.reservation_getID 
	
	@Date datetime2 NULL
	,@Resource_username varchar(50) NULL

AS
BEGIN
	
	DECLARE @Resource_ID INT
	DECLARE @Identifier INT
	
	SET NOCOUNT ON;

	IF @Resource_username IS NOT NULL
		BEGIN
			
			--Check if the person already exist
			EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL

			IF @Resource_ID > 0
				BEGIN
					
					IF @Date IS NOT NULL
						BEGIN
								
							--Get the reservation (using the udf to check duplicates)
							SET @Identifier = (
							SELECT
								TOP 1 --Warning
								r.id_reservation as ID
							FROM df.Reservations as r
							INNER JOIN [df].[udf_reservation_search_byUser](@Date,@Date,@Resource_ID) as s
							ON r.id_reservation = s.ID
							INNER JOIN df.Rooms as rms
							ON r.id_room = rms.id_room
							INNER JOIN df.Buildings as b
							ON rms.id_building = b.id_building)

							return @Identifier
						END
					ELSE
						BEGIN
							print('Please specify valid date')
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