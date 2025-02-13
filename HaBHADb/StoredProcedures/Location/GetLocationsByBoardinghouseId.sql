CREATE PROCEDURE [dbo].[GetLocationsByBoardinghouseId]
    @BoardinghouseId INT
AS
BEGIN
    SELECT Id, Latitude, Longitude, BoardinghouseId
    FROM [dbo].[Locations]
    WHERE BoardinghouseId = @BoardinghouseId;
END
