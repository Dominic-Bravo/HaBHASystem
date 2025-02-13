using Dapper;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface IBoardingHouseImageRepository
    {
        Task<IEnumerable<BoardingHouseImage>> GetBoardingHouseImagesByBoardinghouseIdAsync(int boardinghouseId);
        Task<int> UpdateBoardingHouseImageAsync(BoardingHouseImage image);
        Task<int> DeleteBoardingHouseImageAsync(int imageId);
        Task<int> DeleteAllBoardingHouseImagesAsync(int boardinghouseId);
        Task<int> AddBoardingHouseImageAsync(BoardingHouseImage image);
    }

    public class BoardingHouseImageRepository : IBoardingHouseImageRepository
    {
        private readonly IDbConnection _dbConnection;

        public BoardingHouseImageRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> AddBoardingHouseImageAsync(BoardingHouseImage image)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@BoardinghouseId", image.BoardinghouseId);
            parameters.Add("@ImageBase64", image.ImageBase64);
            parameters.Add("@Description", image.Description);

            var result = await _dbConnection.ExecuteAsync("AddBoardingHouseImage", parameters, commandType: CommandType.StoredProcedure);

            return result;
        }


        public async Task<int> DeleteAllBoardingHouseImagesAsync(int boardinghouseId)
        {
            const string storedProcedure = "DeleteAllBoardingHouseImages"; 

            var parameters = new { BoardinghouseId = boardinghouseId };

            return await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> DeleteBoardingHouseImageAsync(int imageId)
        {
            const string storedProcedure = "DeleteBoardingHouseImage";  

            var parameters = new { ImageId = imageId };

            return await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<BoardingHouseImage>> GetBoardingHouseImagesByBoardinghouseIdAsync(int boardinghouseId)
        {
            const string storedProcedure = "GetBoardingHouseImages";

            var parameters = new { BoardinghouseId = boardinghouseId };

            return await _dbConnection.QueryAsync<BoardingHouseImage>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> UpdateBoardingHouseImageAsync(BoardingHouseImage image)
        {
            const string storedProcedure = "UpdateBoardingHouseImage";  

            var parameters = new BoardingHouseImage
            {
                ImageId = image.ImageId,
                BoardinghouseId = image.BoardinghouseId,
                ImageBase64 = image.ImageBase64,
                Description = image.Description
            };

            return await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
