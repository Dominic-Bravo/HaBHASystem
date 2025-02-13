CREATE PROCEDURE [dbo].[DeleteQrImage]
    @QrImageId INT
AS
BEGIN
    DELETE FROM [dbo].[QrImages]
    WHERE QrImageId = @QrImageId;
    
    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
