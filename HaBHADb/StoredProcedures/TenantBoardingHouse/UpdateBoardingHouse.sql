CREATE PROCEDURE UpdateBoardingHouse
    @BoardinghouseId INT,
    @RoomNumber INT = NULL,
    @RoomSize INT = NULL,
    @PricePerMonth DECIMAL(18, 2) = NULL,
    @IsAvailable BIT,
    @Descriptions NVARCHAR(MAX) = NULL,
    @TenantId NVARCHAR(450) = NULL,
    @ClientId NVARCHAR(450) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BoardingHouses
    SET 
        RoomNumber = @RoomNumber,
        RoomSize = @RoomSize,
        PricePerMonth = @PricePerMonth,
        IsAvailble = @IsAvailable,
        Descriptions = @Descriptions,
        TenantId = @TenantId,
        ClientId = @ClientId
    WHERE BoardinghouseId = @BoardinghouseId;
END;
