--CREATE PROCEDURE RemoveClientFromBoardingHouse
--    @BoardinghouseId INT,
--    @ClientId NVARCHAR(450)
--AS
--BEGIN
--    SET NOCOUNT ON;

--    UPDATE Bookings
--    SET ClientId = NULL, ApprovalStatus = 'Cancelled'  
--    WHERE BoardinghouseId = @BoardinghouseId AND ClientId = @ClientId AND ApprovalStatus = 'Pending';

--    UPDATE BoardingHouses
--    SET IsAvailble = 1
--    WHERE BoardinghouseId = @BoardinghouseId;

--    DELETE FROM ClientRequests
--    WHERE BoardinghouseId = @BoardinghouseId AND ClientId = @ClientId;

--    SELECT 'Client removed and boarding house marked as unavailable, ClientRequest deleted.' AS Message;
--END;
CREATE PROCEDURE RemoveClientFromBoardingHouse
    @BoardinghouseId INT,
    @ClientId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Bookings
    WHERE BoardinghouseId = @BoardinghouseId 
      AND ClientId = @ClientId 
      AND ApprovalStatus = 'Approved';

    UPDATE BoardingHouses
    SET IsAvailble = 1
    WHERE BoardinghouseId = @BoardinghouseId;

    DELETE FROM ClientRequests
    WHERE BoardinghouseId = @BoardinghouseId 
      AND ClientId = @ClientId;

    SELECT 'Client removed, bookings deleted, boarding house marked as available, and client requests deleted.' AS Message;
END;

