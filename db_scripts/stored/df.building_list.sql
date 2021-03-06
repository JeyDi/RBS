USE [RBS]
GO
/****** Object:  StoredProcedure [df].[building_list]    Script Date: 15/08/2019 22:24:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	List of all Buildings
-- =============================================
ALTER PROCEDURE [df].[building_list] 
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		[id_building] as id_building
		,[name] as name
		,[address] as address
		,[status] as status
		,[insert_date] as insert_date
		,[update_date] as update_date
		
	FROM df.Buildings
END
