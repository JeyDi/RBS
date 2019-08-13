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
-- Description:	Delete a previous single reservation
-- =============================================
ALTER PROCEDURE df.reservation_delete_single
	-- Add the parameters for the stored procedure here
	@Date datetime2,
	@Username varchar(50)


AS
BEGIN
	
	DECLARE @Identifier INT

	SET NOCOUNT ON;
	
	exec @Identifier = df.reservation_getID @Date, @Username

	IF @Identifier IS NOT NULL
		BEGIN
			--Delete the reservation that you found (possibile because foreign key is in CASCADE mode for Update and Delete)
			DELETE FROM df.Reservations where id_reservation = @Identifier
			return 1
		END
	ELSE
		BEGIN
			print('Impossible to find a reservation, please retry')
			return -1
		END

END
GO
