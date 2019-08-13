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
-- Description:	Search and get Reservations by date
-- =============================================
CREATE FUNCTION df.udf_reservation_search_count 
(	
	-- Add the parameters for the function here
	@Start_date datetime2 = NULL, 
	@End_date datetime2 = NULL
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT COUNT(*) as ReservationNumbers 
		--s.id_reservation as ID
	FROM df.Reservations as s
	WHERE start_date BETWEEN @Start_date AND @End_date
	AND end_date BETWEEN @Start_date AND @End_date
)
GO
