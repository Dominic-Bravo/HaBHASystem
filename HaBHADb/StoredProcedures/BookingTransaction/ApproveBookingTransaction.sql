CREATE PROCEDURE ApproveBookingTransaction
    @TransactionId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[BookingTransactions]
    SET 
        [Status] = 'Received',
        [ApprovalDate] = GETDATE()
    WHERE [TransactionId] = @TransactionId;

    IF @@ROWCOUNT > 0
    BEGIN
        SELECT 'Booking Transaction Approved' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Booking Transaction Not Found' AS Message;
    END
END;
GO
