CREATE PROCEDURE [dbo].[GetImagesByIds]
    @BoardinghouseId INT = NULL,  
    @QRCodeImageId INT = NULL,    
    @UserId NVARCHAR(450) = NULL
AS
BEGIN
    SELECT [ImageId], [BoardinghouseId], [QRCodeImageId], [UserId], [ImageData], [Description]
    FROM [dbo].[AppImages]
    WHERE 
        (@BoardinghouseId IS NULL OR [BoardinghouseId] = @BoardinghouseId)
        AND (@QRCodeImageId IS NULL OR [QRCodeImageId] = @QRCodeImageId)
        AND (@UserId IS NULL OR [UserId] = @UserId)
END
GO
