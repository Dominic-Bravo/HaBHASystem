CREATE TABLE [dbo].[QrImages]
(
    QrImageId INT IDENTITY PRIMARY KEY,             
    BoardingHouseId INT,                             
    QrCodeImage NVARCHAR(MAX), 
    [Description] NVARCHAR(255) NULL,
    TenantId NVARCHAR(450),  
    CONSTRAINT FK_QrImages_BoardingHouse FOREIGN KEY (BoardingHouseId) 
        REFERENCES dbo.BoardingHouses(BoardingHouseId),
    CONSTRAINT FK_QrImages_Tenant FOREIGN KEY (TenantId) 
        REFERENCES dbo.AspNetUsers(Id)
);
