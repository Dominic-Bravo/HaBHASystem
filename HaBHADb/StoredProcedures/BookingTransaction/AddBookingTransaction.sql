CREATE PROCEDURE AddBookingTransaction
    @BoardinghouseId INT,
    @ClientId NVARCHAR(450),
    @Image NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[BookingTransactions] (
        [BoardinghouseId], 
        [ClientId], 
        [Image], 
        [RequestDate], 
        [Status],
        [Message] 
    )
    VALUES (
        @BoardinghouseId,
        @ClientId,
        @Image,
        GETDATE(),
        'Pending',
        @Message 
    );

    SELECT SCOPE_IDENTITY() AS TransactionId;
END;
GO
