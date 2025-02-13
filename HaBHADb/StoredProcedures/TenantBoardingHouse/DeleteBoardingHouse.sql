CREATE PROCEDURE DeleteBoardingHouse
    @BoardinghouseId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM BoardingHouses
    WHERE BoardinghouseId = @BoardinghouseId;
END;
