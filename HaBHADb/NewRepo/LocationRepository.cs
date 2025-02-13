using Dapper;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface ILocationRepository
    {
        Task<IEnumerable<BhLocation>> GetAllLocationsAsync();
        Task<int> CreateLocationAsync(double latitude, double longitude, int? boardinghouseId = null);
        Task<BhLocation> GetLocationByIdAsync(int locationId);
        Task<int> DeleteLocationAsync(int locationId);
        Task<IEnumerable<BhLocation>> GetLocationsByBoardinghouseIdAsync(int boardinghouseId);

    }

    public class LocationRepository : ILocationRepository
    {
        private readonly IDbConnection _dbConnection;

        public LocationRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> CreateLocationAsync(double latitude, double longitude, int? boardinghouseId = null)
        {
            const string storedProcedure = "CreateLocation";

            var parameters = new
            {
                Latitude = latitude,
                Longitude = longitude,
                BoardinghouseId = boardinghouseId
            };

            var newLocationId = await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return newLocationId;
        }

        public async Task<BhLocation> GetLocationByIdAsync(int locationId)
        {
            const string query = "SELECT Id, Latitude, Longitude, BoardinghouseId FROM [dbo].[Locations] WHERE Id = @LocationId";

            return await _dbConnection.QuerySingleOrDefaultAsync<BhLocation>(
                query,
                new { LocationId = locationId }
            );
        }

        public async Task<IEnumerable<BhLocation>> GetAllLocationsAsync()
        {
            const string storedProcedure = "GetAllLocations"; 

            return await _dbConnection.QueryAsync <BhLocation>(
                storedProcedure,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> DeleteLocationAsync(int locationId)
        {
            const string storedProcedure = "DeleteLocation";

            var parameters = new { LocationId = locationId };

            var rowsAffected = await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return rowsAffected;
        }

        public async Task<IEnumerable<BhLocation>> GetLocationsByBoardinghouseIdAsync(int boardinghouseId)
        {
            const string storedProcedure = "GetLocationsByBoardinghouseId";

            var parameters = new { BoardinghouseId = boardinghouseId };

            return await _dbConnection.QueryAsync<BhLocation>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
