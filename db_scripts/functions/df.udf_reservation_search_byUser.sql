USE [RBS]
GO
/****** Object:  UserDefinedFunction [df].[udf_reservation_search]    Script Date: 06/08/2019 16:59:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and get Reservations by date
-- =============================================
CREATE FUNCTION [df].[udf_reservation_search_byUser] 
(	
	-- Add the parameters for the function here
	@Start_date datetime2, 
	@End_date datetime2,
	@Resource_ID INT

)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT 
		s.id_reservation as ID
	FROM df.Reservations as s
	WHERE start_date BETWEEN @Start_date AND @End_date
	AND end_date BETWEEN @Start_date AND @End_date
	AND id_resource = @Resource_ID
)
