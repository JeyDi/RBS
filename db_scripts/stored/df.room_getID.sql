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
-- Description:	Get Room ID
-- =============================================
CREATE PROCEDURE df.room_getID 
	
	@Name varchar(50) = ''

AS
BEGIN
	
	DECLARE @Identifier INT

	SET NOCOUNT ON;

    IF @Name IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Rooms WHERE TRIM(LOWER(name)) = TRIM(LOWER(@Name)) )
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_room from df.Rooms where TRIM(LOWER(name)) = TRIM(LOWER(@Name)))
				print('Room with:' + @Name + ' has ID: ' + CAST(@Identifier as varchar(2)))
				return @Identifier
			END
		ELSE
			BEGIN
				print('No Room available, impossible to remove the building that you are looking for...')
				SET @Identifier = -1
				return @Identifier
			END
	
END
GO
