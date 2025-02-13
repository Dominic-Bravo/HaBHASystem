CREATE PROCEDURE [dbo].[DeleteLocation]
    @LocationId INT
AS
BEGIN
    DELETE FROM [dbo].[Locations]
    WHERE Id = @LocationId;
    
    SELECT @@ROWCOUNT AS RowsAffected;
END
