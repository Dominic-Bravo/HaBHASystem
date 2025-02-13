CREATE PROCEDURE [dbo].[GetTenantBoardingHouseCountsByTenantId]
    @TenantId NVARCHAR(450)
AS
BEGIN
    SELECT 
        u.FirstName, 
        u.LastName, 
        u.ContactNumber,
        u.Email,
        u.Location,
        COUNT(b.BoardinghouseId) AS NumberOfBoardingHouses,
        COUNT(CASE WHEN b.IsAvailble = 1 THEN 1 END) AS AvailableBoardingHouses,
        COUNT(CASE WHEN b.IsAvailble = 0 THEN 1 END) AS NotAvailableBoardingHouses
    FROM 
        dbo.AspNetUsers u
    LEFT JOIN 
        dbo.BoardingHouses b ON u.Id = b.TenantId
    WHERE 
        u.Id = @TenantId 
    GROUP BY 
        u.Id, u.FirstName, u.LastName, u.ContactNumber, u.Email, u.Location;
END;
