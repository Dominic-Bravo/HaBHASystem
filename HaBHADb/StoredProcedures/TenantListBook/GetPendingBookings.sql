CREATE PROCEDURE GetPendingBookings
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM Bookings
    WHERE ApprovalStatus = 'Pending';
END;
