CREATE PROCEDURE [dbo].[GetBoardingHouseById]
    @BoardinghouseId INT
AS
BEGIN
    SELECT 
        [BoardinghouseId],
        [RoomNumber],
        [RoomSize],
        [PricePerMonth],
        [IsAvailble],
        [Descriptions],
        [TenantId],
        [ClientId]
    FROM 
        [dbo].[BoardingHouses]
    WHERE 
        [BoardinghouseId] = @BoardinghouseId;
END;
