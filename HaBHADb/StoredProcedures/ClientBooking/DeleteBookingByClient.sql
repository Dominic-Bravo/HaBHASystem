CREATE PROCEDURE DeleteBookingByClient
    @BookingId INT = NULL,         
    @BoardinghouseId INT = NULL,     
    @ClientId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Bookings
    WHERE ClientId = @ClientId
      AND (@BookingId IS NULL OR BookingId = @BookingId)  
      AND (@BoardinghouseId IS NULL OR BoardinghouseId = @BoardinghouseId);

    SELECT @@ROWCOUNT AS RowsAffected; 
END;
