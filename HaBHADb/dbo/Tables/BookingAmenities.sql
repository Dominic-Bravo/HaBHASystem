CREATE TABLE [dbo].[BookingAmenities] (
    [BookingAmenityId] INT IDENTITY(1,1) NOT NULL,
    [BookingId] INT NOT NULL,
    [AmenityId] INT NOT NULL,
    CONSTRAINT [PK_BookingAmenities] PRIMARY KEY CLUSTERED ([BookingAmenityId] ASC),
    CONSTRAINT [FK_BookingAmenities_Bookings] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Bookings] ([BookingId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BookingAmenities_Amenities] FOREIGN KEY ([AmenityId]) REFERENCES [dbo].[Amenities] ([AmenityId]) ON DELETE CASCADE
);

