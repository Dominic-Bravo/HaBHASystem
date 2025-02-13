using Dapper;
using HaBHAServer.NewModels;
using Microsoft.Data.SqlClient;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface IAppImageRepository
    {
        int AddAppImage(int? boardinghouseId, int? qrCodeImageId, string? userId, byte[] imageData, string description);
        Task<IEnumerable<AppImage>> GetImagesByIdsAsync(int? boardinghouseId, int? qrCodeImageId, string? userId);
        Task<IEnumerable<AppImage>> GetImagesByBoardinghouseIdAsync(int boardinghouseId);
        Task<IEnumerable<AppImage>> GetImagesByQRCodeImageIdAsync(int qrCodeImageId);
        Task<IEnumerable<AppImage>> GetImagesByUserIdAsync(string userId);
        Task<IEnumerable<AppImage>> GetAllAppImagesAsync();

    }

    public class AppImageRepository : IAppImageRepository
    {
        private readonly IDbConnection _dbConnection;

        public AppImageRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public int AddAppImage(int? boardinghouseId, int? qrCodeImageId, string? userId, byte[] imageData, string description)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@BoardinghouseId", boardinghouseId);
            parameters.Add("@QRCodeImageId", qrCodeImageId);
            parameters.Add("@UserId", userId);
            parameters.Add("@ImageData", imageData);
            parameters.Add("@Description", description);

            var result = _dbConnection.ExecuteScalar<int>("AddAppImage", parameters, commandType: CommandType.StoredProcedure);

            return result;
        }

        public async Task<IEnumerable<AppImage>> GetAllAppImagesAsync()
        {
            var query = "SELECT * FROM AppImages";
            return await _dbConnection.QueryAsync<AppImage>(query);
        }

        public async Task<IEnumerable<AppImage>> GetImagesByBoardinghouseIdAsync(int boardinghouseId)
        {
            var parameters = new
            {
                BoardinghouseId = boardinghouseId,
                QRCodeImageId = (int?)null,  
                UserId = (string?)null        
            };

            var images = await _dbConnection.QueryAsync<AppImage>(
                "dbo.GetImagesByIds",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return images;
        }

        public async Task<IEnumerable<AppImage>> GetImagesByIdsAsync(int? boardinghouseId, int? qrCodeImageId, string? userId)
        {
            var parameters = new
            {
                BoardinghouseId = boardinghouseId,
                QRCodeImageId = qrCodeImageId,
                UserId = userId
            };

            var result = await _dbConnection.QueryAsync<AppImage>(
                "GetImagesByIds",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<IEnumerable<AppImage>> GetImagesByQRCodeImageIdAsync(int qrCodeImageId)
        {
            var parameters = new { QRCodeImageId = qrCodeImageId, BoardinghouseId = (int?)null, UserId = (string?)null };
            var images = await _dbConnection.QueryAsync<AppImage>(
                "dbo.GetImagesByIds",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return images;
        }

        public async Task<IEnumerable<AppImage>> GetImagesByUserIdAsync(string userId)
        {
            var parameters = new { UserId = userId, BoardinghouseId = (int?)null, QRCodeImageId = (int?)null };
            var images = await _dbConnection.QueryAsync<AppImage>(
                "dbo.GetImagesByIds",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return images;
        }
    }
}
