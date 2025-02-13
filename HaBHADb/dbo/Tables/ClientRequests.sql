CREATE TABLE [dbo].[ClientRequests] (
    [ClientRequestId] INT IDENTITY(1,1) NOT NULL,
    [BoardinghouseId] INT  NULL,
    [ClientId]        NVARCHAR (450) NOT NULL,
    [RequestDate]     DATETIME       DEFAULT (getdate()) NOT NULL, 
    [InputDate]       DATETIME       NULL, 
    [Status]          NVARCHAR (50)  DEFAULT ('Pending') NOT NULL,
    [Message]         NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([ClientRequestId] ASC),
    CONSTRAINT [FK_ClientRequests_AspNetUsers_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[AspNetUsers] ([Id]),
    CONSTRAINT [FK_ClientRequests_BoardingHouses] FOREIGN KEY ([BoardinghouseId]) REFERENCES [dbo].[BoardingHouses] ([BoardinghouseId])
);

GO

CREATE NONCLUSTERED INDEX [IX_ClientRequests_BoardinghouseId]
    ON [dbo].[ClientRequests]([BoardinghouseId] ASC);

GO

CREATE NONCLUSTERED INDEX [IX_ClientRequests_ClientId]
    ON [dbo].[ClientRequests]([ClientId] ASC);
GO
