CREATE PROCEDURE DeleteAllBoardingHouseImages
    @BoardinghouseId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM BoardingHouseImages
    WHERE BoardinghouseId = @BoardinghouseId;
END;
