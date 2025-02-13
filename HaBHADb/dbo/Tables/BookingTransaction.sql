CREATE TABLE [dbo].[BookingTransactions] (
    [TransactionId] INT IDENTITY(1,1) NOT NULL,
    [BoardinghouseId] INT NOT NULL,
    [ClientId] NVARCHAR(450) NULL,  
    [TenantId] NVARCHAR(450) NULL,  
    [Image] NVARCHAR(MAX) NULL,  
    [RequestDate] DATETIME NOT NULL DEFAULT GETDATE(),  
    [ApprovalDate] DATETIME NULL,  
    [Status] NVARCHAR(50) NOT NULL DEFAULT 'Pending',  
    [ApprovalStatus] NVARCHAR(50) NULL,
    [Message] NVARCHAR(MAX) NULL,
    CONSTRAINT [PK_BookingTransactions] PRIMARY KEY CLUSTERED ([TransactionId] ASC),
    --CONSTRAINT [FK_BookingTransactions_BoardinghouseId] FOREIGN KEY ([BoardinghouseId]) REFERENCES [dbo].[BoardingHouses]([BoardinghouseId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BookingTransactions_AspNetUsers_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[AspNetUsers]([Id]) ON DELETE CASCADE
);

GO

CREATE NONCLUSTERED INDEX [IX_BookingTransactions_ClientId]
    ON [dbo].[BookingTransactions]([ClientId] ASC);
