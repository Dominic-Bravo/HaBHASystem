CREATE TABLE [dbo].[ImageFiles] (
    [ImageId]         INT IDENTITY(1,1) NOT NULL, 
    [FileName]        NVARCHAR (255)  NULL,
    [ContentType]     NVARCHAR (100)  NULL,
    [ImageData]       VARBINARY (MAX) NULL,
    [BoardinghouseId] int NULL,
    PRIMARY KEY CLUSTERED ([ImageId] ASC)
    --CONSTRAINT FK_Images_Boardinghouse FOREIGN KEY ([BoardinghouseId])
    --    REFERENCES [dbo].[Boardinghouses] ([BoardinghouseId])
    --    ON DELETE CASCADE
);
