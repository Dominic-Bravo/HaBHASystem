CREATE PROCEDURE GetBoardingHousesByTenantId
    @TenantId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM BoardingHouses
    WHERE TenantId = @TenantId;
END;
