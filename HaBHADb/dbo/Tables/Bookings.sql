CREATE TABLE [dbo].[Bookings] (
    [BookingId] INT IDENTITY(1,1) NOT NULL,
    [BoardinghouseId] INT NOT NULL,
    [ClientId] NVARCHAR(450) NOT NULL,
    [TenantId] NVARCHAR(450) NULL,
    [BookingDate] DATETIME NOT NULL DEFAULT GETDATE(),
    [CheckInDate] DATETIME NULL,
    [CheckOutDate] DATETIME NULL,
    [TotalAmount] DECIMAL(18, 2) NULL,
    ApprovalStatus NVARCHAR(50) DEFAULT 'Pending' NOT NULL,
    CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED ([BookingId] ASC),
    CONSTRAINT [FK_Bookings_BoardingHouses] FOREIGN KEY ([BoardinghouseId]) REFERENCES [dbo].[BoardingHouses] ([BoardinghouseId]),
    CONSTRAINT [FK_Bookings_AspNetUsers] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[AspNetUsers] ([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Bookings_BoardinghouseId] ON [dbo].[Bookings]([BoardinghouseId] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_Bookings_ClientId] ON [dbo].[Bookings]([ClientId] ASC);
