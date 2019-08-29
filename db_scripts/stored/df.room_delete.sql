USE [RBS]
GO
/****** Object:  StoredProcedure [df].[building_delete]    Script Date: 29/08/2019 11:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Delete building already exist
-- =============================================
CREATE PROCEDURE [df].[room_delete] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Room_name varchar(50)
	
	EXEC @Identity = df.room_getID @Name = @Name

    -- Remove by name and surname
	IF @Identity > 0 AND @Identity IS NOT NULL
		BEGIN
			
			--Remove all the rooms associated with the building
			DELETE FROM df.Rooms where id_room = @Identity

			--On cascade all the Reservation associated with the building and the room will be deleted

			print('Room deleted with:' + @Name + ' and ID: ' + cast(@Identity as varchar(2)))
			return 1
		END
	ELSE
		BEGIN
			print('No room available, impossible to remove the room that you are looking for...')
			return -1
		END

	
	print('Impossible to remove the room that you looking for..')

END
