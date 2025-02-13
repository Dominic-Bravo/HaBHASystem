CREATE PROCEDURE DeleteAmenity
    @AmenityId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Amenities
    WHERE AmenityId = @AmenityId;
END;
