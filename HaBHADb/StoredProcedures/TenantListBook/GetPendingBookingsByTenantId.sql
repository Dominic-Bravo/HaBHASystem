CREATE PROCEDURE GetPendingBookingsByTenantId
    @TenantId NVARCHAR(450)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM Bookings
    WHERE ApprovalStatus = 'Pending' 
      AND TenantId = @TenantId;
END;
