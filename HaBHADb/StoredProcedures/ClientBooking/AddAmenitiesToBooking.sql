CREATE PROCEDURE AddAmenitiesToBooking
    @BookingId INT,
    @AmenityIds NVARCHAR(MAX) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AmenityId INT;
    DECLARE @Pos INT = 0;
    DECLARE @Delimiter CHAR(1) = ',';

    WHILE CHARINDEX(@Delimiter, @AmenityIds) > 0
    BEGIN
        SET @Pos = CHARINDEX(@Delimiter, @AmenityIds);
        SET @AmenityId = CAST(SUBSTRING(@AmenityIds, 1, @Pos - 1) AS INT);
        SET @AmenityIds = SUBSTRING(@AmenityIds, @Pos + 1, LEN(@AmenityIds));

        INSERT INTO BookingAmenities (BookingId, AmenityId)
        VALUES (@BookingId, @AmenityId);
    END

    SET @AmenityId = CAST(@AmenityIds AS INT);
    INSERT INTO BookingAmenities (BookingId, AmenityId)
    VALUES (@BookingId, @AmenityId);
END;
