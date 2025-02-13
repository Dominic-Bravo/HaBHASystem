CREATE PROCEDURE [dbo].[CreateQrImage]
    @BoardingHouseId INT = NULL,    
    @QrCodeImage NVARCHAR(MAX),
    @TenantId NVARCHAR(450) = NULL,
    @Description NVARCHAR(255) = NULL 
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dbo].[QrImages] (BoardingHouseId, QrCodeImage, TenantId, Description)
    VALUES (@BoardingHouseId, @QrCodeImage, @TenantId, @Description);

    SELECT SCOPE_IDENTITY();
END
GO
