CREATE PROCEDURE CheckIfClientHasBookingByClientId
    @ClientId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM Bookings
        WHERE ClientId = @ClientId
          AND ApprovalStatus = 'Pending'
    )
    BEGIN
        SELECT 1 AS HasPendingBooking;
    END
    ELSE
    BEGIN
        SELECT 0 AS HasPendingBooking;
    END
END;
