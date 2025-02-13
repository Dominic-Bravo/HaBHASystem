CREATE PROCEDURE [dbo].[CreateLocation]
    @Latitude FLOAT,
    @Longitude FLOAT,
    @BoardinghouseId INT = NULL
AS
BEGIN
    INSERT INTO [dbo].[Locations] (Latitude, Longitude, BoardinghouseId)
    VALUES (@Latitude, @Longitude, @BoardinghouseId);
    
    SELECT SCOPE_IDENTITY() AS NewLocationId;
END
