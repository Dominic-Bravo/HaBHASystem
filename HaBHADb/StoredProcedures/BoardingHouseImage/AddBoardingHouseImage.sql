CREATE PROCEDURE AddBoardingHouseImage
    @BoardinghouseId INT,
    @ImageBase64 NVARCHAR(MAX), 
    @Description NVARCHAR(255) = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO BoardingHouseImages (BoardinghouseId, ImageBase64, Description)
    VALUES (@BoardinghouseId, @ImageBase64, @Description);
END;
GO
