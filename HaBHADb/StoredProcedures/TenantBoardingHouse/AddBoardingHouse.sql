CREATE PROCEDURE AddBoardingHouse
    @RoomNumber INT = NULL,
    @RoomSize INT = NULL,
    @PricePerMonth DECIMAL(18, 2) = NULL,
    @IsAvailable BIT = 1, 
    @Descriptions NVARCHAR(MAX) = NULL,
    @TenantId NVARCHAR(450) = NULL,
    @ClientId NVARCHAR(450) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO BoardingHouses (RoomNumber, RoomSize, PricePerMonth, IsAvailble, Descriptions, TenantId, ClientId)
    VALUES (@RoomNumber, @RoomSize, @PricePerMonth, @IsAvailable, @Descriptions, @TenantId, @ClientId);

    SELECT SCOPE_IDENTITY() AS BoardinghouseId;
END;
GO
