CREATE PROCEDURE [dbo].[GetAllLocations]
AS
BEGIN
    SELECT Id, Latitude, Longitude, BoardinghouseId
    FROM [dbo].[Locations];
END;
