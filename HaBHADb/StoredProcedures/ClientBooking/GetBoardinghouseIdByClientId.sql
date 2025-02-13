CREATE PROCEDURE GetNewestBoardinghouseIdByClientId
    @ClientId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 BoardinghouseId
    FROM Bookings
    WHERE ClientId = @ClientId
    ORDER BY CheckInDate DESC; 
END;
