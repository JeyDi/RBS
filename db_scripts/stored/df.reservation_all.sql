USE [RBS]
GO
/****** Object:  StoredProcedure [df].[reservation_list]    Script Date: 26/08/2019 21:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get Reservation List
-- =============================================
CREATE PROCEDURE [df].[reservation_all] 
	
	@Resource_username varchar(50)
	
AS
BEGIN
	
	DECLARE @Resource_ID INT

	SET NOCOUNT ON;

	--Check if the person already exist
	EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL
			
	--print('Resource ID:' + CAST(@Resource_ID as varchar(2)))

	print('Start searching')
	--Get the reservations for a specific user (using the udf to check duplicates)
							
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
			,rms.name as room_name
			,rms.sittings as room_sittings
			,rms.id_building as build_id
			,b.name as build_name
		FROM 
		df.Reservations as r
		--INNER JOIN [df].[udf_reservation_search_byUser](@Start_Date,@End_Date,@Resource_ID) as s_udf
		--	ON r.id_reservation = s_udf.ID
		INNER JOIN df.Resources as s
			ON r.id_resource = s.id_resource
		INNER JOIN df.Rooms as rms
			ON r.id_room = rms.id_room
		INNER JOIN df.Buildings as b
			ON rms.id_building = b.id_building
		where
			r.id_resource = @Resource_ID
			
	print('Search completed..')
    
	
END
