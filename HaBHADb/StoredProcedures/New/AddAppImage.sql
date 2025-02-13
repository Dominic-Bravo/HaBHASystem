CREATE PROCEDURE [dbo].[AddAppImage]
    @BoardinghouseId INT = NULL,  
    @QRCodeImageId INT = NULL,    
    @UserId NVARCHAR(450) = NULL, 
    @ImageData VARBINARY(MAX),     
    @Description NVARCHAR(255) = NULL
AS
BEGIN
    
    INSERT INTO [dbo].[AppImages] 
        ([BoardinghouseId], [QRCodeImageId], [UserId], [ImageData], [Description])
    VALUES
        (@BoardinghouseId, @QRCodeImageId, @UserId, @ImageData, @Description);

    SELECT SCOPE_IDENTITY() AS ImageId; 
END
GO
