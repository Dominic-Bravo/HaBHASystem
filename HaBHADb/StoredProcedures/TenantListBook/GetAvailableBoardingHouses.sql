    CREATE PROCEDURE GetAvailableBoardingHouses
AS
BEGIN
    SELECT 
        b.BoardinghouseId,
        b.RoomNumber,
        b.RoomSize,
        b.PricePerMonth,
        b.IsAvailble,
        b.Descriptions,
        b.ClientId,     
        b.TenantId,   
        a.AmenityId,
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
        b.PricePerMonth, 
        b.IsAvailble, 
        b.Descriptions,
        b.ClientId,     
        b.TenantId,
        a.AmenityId
END
GO
