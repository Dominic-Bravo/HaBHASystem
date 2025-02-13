CREATE TABLE [dbo].[Locations]
(
	Id INT IDENTITY PRIMARY KEY,
    Latitude FLOAT,
    Longitude FLOAT, 
    [BoardinghouseId] int NULL,
    CONSTRAINT [FK_Locations_ToTable] FOREIGN KEY ([BoardinghouseId]) REFERENCES [dbo].[BoardingHouses] ([BoardinghouseId])
)
