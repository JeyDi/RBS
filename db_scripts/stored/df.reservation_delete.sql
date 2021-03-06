USE [RBS]
GO
/****** Object:  StoredProcedure [df].[reservation_delete_single]    Script Date: 29/08/2019 12:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Delete a previous single reservation with id
-- =============================================
CREATE PROCEDURE [df].[reservation_delete]
	-- Add the parameters for the stored procedure here
	@Identifier int


AS
BEGIN
	

	SET NOCOUNT ON;
	
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
