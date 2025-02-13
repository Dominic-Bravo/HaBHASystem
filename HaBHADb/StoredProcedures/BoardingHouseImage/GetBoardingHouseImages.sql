CREATE PROCEDURE GetBoardingHouseImages
    @BoardinghouseId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ImageId, ImageBase64, Description
    FROM BoardingHouseImages
    WHERE BoardinghouseId = @BoardinghouseId;
END;
