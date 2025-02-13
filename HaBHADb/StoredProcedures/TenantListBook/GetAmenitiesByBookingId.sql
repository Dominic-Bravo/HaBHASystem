CREATE PROCEDURE GetAmenitiesByBookingId
    @BookingId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        a.Name AS AmenityName,
        a.Price AS AmenityPrice
    FROM BookingAmenities ba
    INNER JOIN Amenities a ON a.AmenityId = ba.AmenityId
    WHERE ba.BookingId = @BookingId;
END;

