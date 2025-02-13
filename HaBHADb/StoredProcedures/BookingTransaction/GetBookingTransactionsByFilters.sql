CREATE PROCEDURE GetBookingTransactionsByFilters
    @TenantId NVARCHAR(450) = NULL,
    @ClientId NVARCHAR(450) = NULL,
    @BoardinghouseId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TransactionId,
        BoardinghouseId,
        ClientId,
        TenantId,
        Image,
        RequestDate,
        ApprovalDate,
        Status,
        ApprovalStatus
    FROM 
        [dbo].[BookingTransactions]
    WHERE 
        (@TenantId IS NULL OR TenantId = @TenantId)
        AND (@ClientId IS NULL OR ClientId = @ClientId)
        AND (@BoardinghouseId IS NULL OR BoardinghouseId = @BoardinghouseId)
    ORDER BY 
        ApprovalDate DESC, 
        RequestDate DESC;  
END
GO
