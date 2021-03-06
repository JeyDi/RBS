USE [RBS]
GO
/****** Object:  StoredProcedure [df].[resource_list]    Script Date: 15/08/2019 20:21:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	List of all resources
-- =============================================
ALTER PROCEDURE [df].[resource_list] 
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		[id_resource] as id_resource
		,[name] as name
		,[surname] as surname
		,[email] as email
		,[username] as username
		,[status] as status
		,[admin] as admin
		,[insert_date] as insert_date
		,[update_date] as update_date
	FROM df.Resources
END
