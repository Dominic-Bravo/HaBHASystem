CREATE PROCEDURE [dbo].[GetTotalPriceForBoardingHouse]
    @MinimumPrice DECIMAL(18, 2),
    @MaximumPrice DECIMAL(18, 2)
AS
BEGIN
    SELECT 
        b.BoardinghouseId,
        b.RoomNumber,
        b.RoomSize,
        b.PricePerMonth,
        b.IsAvailble,
        b.ClientId,
        b.TenantId,
        b.Descriptions,
        ISNULL(SUM(a.Price), 0) AS TotalAmenitiesPrice, 
        (b.PricePerMonth + ISNULL(SUM(a.Price), 0)) AS TotalPrice 
    FROM 
        dbo.BoardingHouses b
    LEFT JOIN 
        dbo.Amenities a ON b.BoardinghouseId = a.BoardinghouseId
    WHERE 
        b.IsAvailble = 1  
    GROUP BY 
        b.BoardinghouseId, 
        b.RoomNumber,   
        b.RoomSize, 
        b.ClientId,
        b.TenantId,
        b.PricePerMonth, 
        b.IsAvailble, 
        b.Descriptions
    HAVING 
        (b.PricePerMonth + ISNULL(SUM(a.Price), 0)) BETWEEN @MinimumPrice AND @MaximumPrice; 
END
GO
