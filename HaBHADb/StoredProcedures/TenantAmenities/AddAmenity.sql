CREATE PROCEDURE AddAmenity
    @BoardinghouseId INT,
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Amenities (BoardinghouseId, Name, Price)
    VALUES (@BoardinghouseId, @Name, @Price);

    SELECT SCOPE_IDENTITY() AS AmenityId;
END;
