using Dapper;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface ITenantAmenityRepository
    {
        Task<IEnumerable<TenantAmenity>> GetAmenitiesByBoardinghouseIdAsync(int boardinghouseId);
        Task<int> AddAmenityAsync(TenantAmenity amenity);
        Task<int> UpdateAmenityAsync(TenantAmenity amenity);
        Task<int> DeleteAmenityAsync(int amenityId);
    }

    public class TenantAmenitiesRepository : ITenantAmenityRepository
    {
        private readonly IDbConnection _dbConnection;
        public TenantAmenitiesRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> AddAmenityAsync(TenantAmenity amenity)
        {
            const string storedProcedure = "AddAmenity"; 

            var parameters = new
            {
                BoardinghouseId = amenity.BoardinghouseId,
                Name = amenity.Name,
                Price = amenity.Price
            };

            var newAmenityId = await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return newAmenityId;
        }

        public async Task<int> DeleteAmenityAsync(int amenityId)
        {
            const string storedProcedure = "DeleteAmenity";  

            var parameters = new { AmenityId = amenityId };

            var result = await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<IEnumerable<TenantAmenity>> GetAmenitiesByBoardinghouseIdAsync(int boardinghouseId)
        {
            const string storedProcedure = "GetAmenitiesByBoardinghouseId";

            var parameters = new { BoardinghouseId = boardinghouseId };

            return await _dbConnection.QueryAsync<TenantAmenity>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> UpdateAmenityAsync(TenantAmenity amenity)
        {
            const string storedProcedure = "UpdateAmenity"; 

            var parameters = new
            {
                AmenityId = amenity.AmenityId,
                Name = amenity.Name,
                Price = amenity.Price
            };

            var result = await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }
    }
}
