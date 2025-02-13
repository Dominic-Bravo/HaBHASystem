CREATE TABLE [dbo].[AppImages] (
    [ImageId] INT IDENTITY(1,1) NOT NULL,
    [BoardinghouseId] INT NULL,  
    [QRCodeImageId] INT NULL, 
    [UserId] NVARCHAR(450) NULL,
    [ImageData] VARBINARY(MAX) NULL, 
    [Description] NVARCHAR(255) NULL,  
    
    CONSTRAINT [PK_AppImages] PRIMARY KEY CLUSTERED ([ImageId] ASC),

    -- Foreign key for BoardinghouseId
    CONSTRAINT [FK_AppImages_BoardingHouses] FOREIGN KEY ([BoardinghouseId])
        REFERENCES [dbo].[BoardingHouses] ([BoardinghouseId]) 
        ON DELETE CASCADE,

    CONSTRAINT [FK_AppImages_AspNetUsers] FOREIGN KEY ([UserId])
        REFERENCES [dbo].[AspNetUsers] ([Id]) 
        ON DELETE NO ACTION
);

GO

CREATE NONCLUSTERED INDEX [IX_AppImages_BoardinghouseId]
    ON [dbo].[AppImages]([BoardinghouseId] ASC);

GO

CREATE NONCLUSTERED INDEX [IX_AppImages_UserId]
    ON [dbo].[AppImages]([UserId] ASC);
GO
