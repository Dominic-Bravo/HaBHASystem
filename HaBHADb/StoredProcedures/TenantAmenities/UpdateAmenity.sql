CREATE PROCEDURE UpdateAmenity
    @AmenityId INT,
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Amenities
    SET 
        Name = @Name,
        Price = @Price
    WHERE AmenityId = @AmenityId;
END;
