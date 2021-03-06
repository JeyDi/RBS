USE [RBS]
GO
/****** Object:  StoredProcedure [df].[building_getID]    Script Date: 05/08/2019 19:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get Resource ID
-- =============================================
ALTER PROCEDURE [df].[building_getID] 
	@Name varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identifier INT

    
    -- Get ID by building name
	IF @Name IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Buildings WHERE TRIM(LOWER(name)) = TRIM(LOWER(@Name)) )
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_building from df.Buildings where TRIM(LOWER(name)) = TRIM(LOWER(@Name)))
				print('Resource with:' + @Name + ' has ID: ' + CAST(@Identifier as varchar(2)))
				return @Identifier
			END
		ELSE
			BEGIN
				print('No buildings available, impossible to remove the building that you are looking for...')
				SET @Identifier = -1
				return @Identifier
			END
END
