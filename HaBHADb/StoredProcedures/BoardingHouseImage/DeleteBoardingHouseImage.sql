CREATE PROCEDURE DeleteBoardingHouseImage
    @ImageId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM BoardingHouseImages
    WHERE ImageId = @ImageId;
END;
