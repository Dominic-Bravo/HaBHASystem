CREATE PROCEDURE GetAllBoardingHouses
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM BoardingHouses;
END;
