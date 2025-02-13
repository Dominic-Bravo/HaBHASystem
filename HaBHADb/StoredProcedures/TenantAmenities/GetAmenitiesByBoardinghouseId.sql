CREATE PROCEDURE GetAmenitiesByBoardinghouseId
    @BoardinghouseId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT * 
    FROM Amenities
    WHERE BoardinghouseId = @BoardinghouseId;
END;
