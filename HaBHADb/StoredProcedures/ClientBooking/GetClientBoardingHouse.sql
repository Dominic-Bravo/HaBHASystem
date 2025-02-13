CREATE PROCEDURE GetClientBoardingHouse
    @ClientId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM BoardingHouses
    WHERE ClientId = @ClientId;
END;