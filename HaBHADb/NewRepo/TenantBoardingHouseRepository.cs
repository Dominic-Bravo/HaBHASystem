using Dapper;
using HaBHAServer.Models.Dto;
using HaBHAServer.Models.Establishments;
using HaBHAServer.NewModels;
using Microsoft.Data.SqlClient;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface ITenantBoardingHouseRepository
    {
        Task<TenantBoardingHouse?> GetByIdAsync(int id);
        Task<IEnumerable<TenantBoardingHouse>> GetAllBoardingHousesAsync();
        Task<int> AddBoardingHouseAsync(TenantBoardingHouse boardingHouse);
        Task<int> DeleteBoardingHouseAsync(int boardingHouseId);
        Task<int> UpdateBoardingHouseAsync(TenantBoardingHouse boardingHouse);
        Task<string> RemoveClientFromBoardingHouseAsync(int boardinghouseId, string clientId);
        Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByTenantIdAsync(string tenantId);
        Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByClientIdAsync(string tenantId);
        Task<IEnumerable<BoardingHouseWithTotalPrice>> GetBoardingHouseWithTotalPriceAsync(decimal minimumPrice, decimal maximumPrice);
        Task<IEnumerable<BoardingHouseWithTotalPrice>> GetAvailableBoardingHousesAsync();
        Task<BoardingHouseWithTotalPrice> GetBoardingHouseByIdAsync(int boardingHouseId);
        Task<TenantProfileCount> GetTenantBoardingHouseCountsByTenantIdAsync(string tenantId);


    }

    public class TenantBoardingHouseRepository : ITenantBoardingHouseRepository
    {
        private readonly IDbConnection _dbConnection;

        public TenantBoardingHouseRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> AddBoardingHouseAsync(TenantBoardingHouse boardingHouse)
        {
            const string storedProcedure = "AddBoardingHouse";

            var parameters = new
            {
                RoomNumber = boardingHouse.RoomNumber,
                RoomSize = boardingHouse.RoomSize,
                PricePerMonth = boardingHouse.PricePerMonth,
                IsAvailable = boardingHouse.IsAvailable,
                Descriptions = boardingHouse.Descriptions,
                TenantId = boardingHouse.TenantId,
                ClientId = boardingHouse.ClientId
            };

            var result = await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<int> DeleteBoardingHouseAsync(int boardingHouseId)
        {
            const string storedProcedure = "DeleteBoardingHouse";

            var parameters = new { BoardinghouseId = boardingHouseId };

            var result = await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<IEnumerable<TenantBoardingHouse>> GetAllBoardingHousesAsync()
        {
            const string storedProcedure = "GetAllBoardingHouses";

            return await _dbConnection.QueryAsync<TenantBoardingHouse>(
                storedProcedure,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<BoardingHouseWithTotalPrice>> GetAvailableBoardingHousesAsync()
        {
            const string storedProcedure = "GetAvailableBoardingHouses";

            var result = await _dbConnection.QueryAsync<BoardingHouseWithTotalPrice>(
                storedProcedure,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<BoardingHouseWithTotalPrice> GetBoardingHouseByIdAsync(int boardingHouseId)
        {
            const string storedProcedure = "GetBoardingHouseById";

            var parameters = new { BoardinghouseId = boardingHouseId };

            var result = await _dbConnection.QueryFirstOrDefaultAsync<BoardingHouseWithTotalPrice>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
    }

        public async Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByTenantIdAsync(string tenantId)
        {
            const string storedProcedure = "GetBoardingHousesByTenantId";

            var parameters = new { TenantId = tenantId };

            return await _dbConnection.QueryAsync<TenantBoardingHouse>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByClientIdAsync(string tenantId)
        {
            const string storedProcedure = "GetClientBoardingHouse";

            var parameters = new { TenantId = tenantId };

            return await _dbConnection.QueryAsync<TenantBoardingHouse>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }


        //public async Task<BoardingHouseWithTotalPrice> GetBoardingHouseWithTotalPriceAsync(decimal minimumPrice, decimal maximumPrice)
        //{
        //    const string storedProcedure = "GetTotalPriceForBoardingHouse";

        //    var parameters = new
        //    {
        //        MinimumPrice = minimumPrice,
        //        MaximumPrice = maximumPrice
        //    };

        //    var result = await _dbConnection.QuerySingleOrDefaultAsync<BoardingHouseWithTotalPrice>(
        //        storedProcedure,
        //        parameters,
        //        commandType: CommandType.StoredProcedure
        //    );

        //    return result;
        //}

        public async Task<IEnumerable<BoardingHouseWithTotalPrice>> GetBoardingHouseWithTotalPriceAsync(decimal minimumPrice, decimal maximumPrice)
        {
            const string storedProcedure = "GetTotalPriceForBoardingHouse";

            var parameters = new
            {
                MinimumPrice = minimumPrice,
                MaximumPrice = maximumPrice
            };

            var result = await _dbConnection.QueryAsync<BoardingHouseWithTotalPrice>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }



        public async Task<TenantBoardingHouse?> GetByIdAsync(int id)
        {
            const string query = "SELECT * FROM BoardingHouses WHERE BoardinghouseId = @Id";
            return await _dbConnection.QueryFirstOrDefaultAsync<TenantBoardingHouse>(query, new { Id = id });
        }

        public async Task<TenantBoardingHouse?> GetClientByIDAsync(int id)
        {
            const string query = "SELECT * FROM BoardingHouses WHERE ClientId = @Id";
            return await _dbConnection.QueryFirstOrDefaultAsync<TenantBoardingHouse>(query, new { Id = id });
        }


        public async Task<TenantProfileCount> GetTenantBoardingHouseCountsByTenantIdAsync(string tenantId)
        {
            const string storedProcedure = "dbo.GetTenantBoardingHouseCountsByTenantId"; 

            var parameters = new { TenantId = tenantId };

            return await _dbConnection.QuerySingleOrDefaultAsync<TenantProfileCount>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<string> RemoveClientFromBoardingHouseAsync(int boardinghouseId, string clientId)
        {
            const string storedProcedure = "RemoveClientFromBoardingHouse";

            var parameters = new { BoardinghouseId = boardinghouseId, ClientId = clientId };

            var result = await _dbConnection.ExecuteScalarAsync<string>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result ?? "No data returned from the stored procedure.";
        }

        public async Task<int> UpdateBoardingHouseAsync(TenantBoardingHouse boardingHouse)
        {
            const string storedProcedure = "UpdateBoardingHouse";

            var parameters = new
            {
                BoardinghouseId = boardingHouse.BoardinghouseId,
                RoomNumber = boardingHouse.RoomNumber,
                RoomSize = boardingHouse.RoomSize,
                PricePerMonth = boardingHouse.PricePerMonth,
                IsAvailable = boardingHouse.IsAvailable,
                Descriptions = boardingHouse.Descriptions,
                TenantId = boardingHouse.TenantId,
                ClientId = boardingHouse.ClientId
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
