USE [RBS]
GO
/****** Object:  StoredProcedure [df].[room_list]    Script Date: 29/08/2019 11:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get the list of all rooms by building
-- =============================================
CREATE PROCEDURE [df].[room_all] 

	
AS
BEGIN
	
	SET NOCOUNT ON;

	--Get the Rooms by Building ID
	SELECT 
		r.id_room as room_id
		,r.name as room_name
		,r.sittings as room_sittings
		,r.id_building as build_id
		,b.name as build_name
	FROM df.Rooms as r
	INNER JOIN df.Buildings as b
	ON r.id_building = b.id_building


END

