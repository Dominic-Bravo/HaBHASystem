CREATE PROCEDURE GetBookingWithAmenities
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
        b.ApprovalStatus,
        a.Name AS AmenityName,
        a.Price AS AmenityPrice
    FROM Bookings b
    LEFT JOIN BookingAmenities ba ON ba.BookingId = b.BookingId
    LEFT JOIN Amenities a ON a.AmenityId = ba.AmenityId
    WHERE b.BookingId = @BookingId;
END;
