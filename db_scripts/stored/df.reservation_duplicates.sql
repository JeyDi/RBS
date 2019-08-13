-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and count how many Reservations by date, building and room, useful to check duplicates
-- =============================================
CREATE PROCEDURE df.reservation_duplicates
(	
	-- Add the parameters for the function here
	@Building int = NULL,
	@Room int = NULL,
	@Start_date datetime2 = NULL, 
	@End_date datetime2 = NULL
)

AS
BEGIN 

	DECLARE @ReservationNumbers INT

	SET @ReservationNumbers = (
		SELECT COUNT(s.id_reservation) as ReservationNumbers 
			--s.id_reservation as ID
		FROM df.Reservations as s
		INNER JOIN df.Rooms as r
		ON s.id_room = r.id_room
		INNER JOIN df.Buildings as b
		ON r.id_building = b.id_building
		WHERE start_date BETWEEN @Start_date AND @End_date
		AND end_date BETWEEN @Start_date AND @End_date
		)

END
GO
