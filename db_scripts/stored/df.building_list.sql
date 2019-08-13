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
-- Create date: 05/08/2019
-- Description:	List of all Buildings
-- =============================================
CREATE PROCEDURE df.building_list 
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		[id_building] as ID
		,[name] as Name
		,[address] as Surname
		,[status] as Email
		
	FROM df.Buildings
END
GO

