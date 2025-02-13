CREATE PROCEDURE UpdateBoardingHouseImage
    @ImageId INT,               
    @BoardinghouseId INT,      
    @ImageBase64 NVARCHAR(MAX) = NULL,  
    @Description NVARCHAR(255) = NULL   
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BoardingHouseImages
    SET 
        ImageBase64 = @ImageBase64, 
        Description = @Description
    WHERE ImageId = @ImageId AND BoardinghouseId = @BoardinghouseId;
END;
