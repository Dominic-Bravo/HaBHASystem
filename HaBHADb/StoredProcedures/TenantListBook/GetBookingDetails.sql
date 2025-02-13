CREATE PROCEDURE GetBookingDetails
    @BookingId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BoardinghouseId,
        b.ClientId,
        b.BookingDate,
        b.CheckInDate,
        b.CheckOutDate,
        b.TotalAmount,
        b.ApprovalStatus
    FROM Bookings b
    WHERE b.BookingId = @BookingId;
END;

