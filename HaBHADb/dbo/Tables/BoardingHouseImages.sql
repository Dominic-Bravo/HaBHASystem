CREATE TABLE [dbo].[BoardingHouseImages] (
    [ImageId] INT IDENTITY(1,1) NOT NULL,
    [BoardinghouseId] INT NOT NULL,
    [ImageBase64] NVARCHAR(MAX) NULL, 
    [Description] NVARCHAR(255) NULL,  
    CONSTRAINT [PK_BoardingHouseImages] PRIMARY KEY CLUSTERED ([ImageId] ASC),
    CONSTRAINT [FK_BoardingHouseImages_BoardingHouses] FOREIGN KEY ([BoardinghouseId]) REFERENCES [dbo].[BoardingHouses] ([BoardinghouseId]) ON DELETE CASCADE
);

GO
CREATE NONCLUSTERED INDEX [IX_BoardingHouseImages_BoardinghouseId]
    ON [dbo].[BoardingHouseImages]([BoardinghouseId] ASC);
