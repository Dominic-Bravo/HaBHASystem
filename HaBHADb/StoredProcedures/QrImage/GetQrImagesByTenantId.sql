CREATE PROCEDURE [dbo].[GetQrImagesByTenantId]
    @TenantId NVARCHAR(450)
AS
BEGIN
    SELECT QrImageId, BoardingHouseId, QrCodeImage, TenantId
    FROM [dbo].[QrImages]
    WHERE TenantId = @TenantId;
END
GO
