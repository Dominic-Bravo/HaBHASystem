using Dapper;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface IQrImageRepository
    {
        Task<int> CreateQrImageAsync(int? boardingHouseId, string qrCodeImage, string tenantId, string? description);
        Task<int> DeleteQrImageAsync(int qrImageId);
        Task<IEnumerable<QrImage>> GetQrImagesByTenantIdAsync(string tenantId);
        Task<QrImage?> GetQRImageByIdAsync(int qrImageId);
    }

    public class QrImageRepository : IQrImageRepository
    {
        private readonly IDbConnection _dbConnection;

        public QrImageRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> CreateQrImageAsync(int? boardingHouseId, string qrCodeImage, string tenantId, string? description)
        {
            const string storedProcedure = "dbo.CreateQrImage"; 

            var parameters = new
            {
                BoardingHouseId = boardingHouseId ?? (object)DBNull.Value, 
                QrCodeImage = qrCodeImage,
                TenantId = tenantId ?? (object)DBNull.Value,
                Description = description ?? (object)DBNull.Value 
            };

            var result = await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters, 
                commandType: CommandType.StoredProcedure 
            );

            return result; 
        }


        public async Task<int> DeleteQrImageAsync(int qrImageId)
        {
            const string storedProcedure = "DeleteQrImage";  

            var parameters = new { QrImageId = qrImageId };  
            
            return await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<QrImage>> GetQrImagesByTenantIdAsync(string tenantId)
        {
            const string storedProcedure = "GetQrImagesByTenantId"; 

            var parameters = new { TenantId = tenantId };

            return await _dbConnection.QueryAsync<QrImage>(
                storedProcedure,    
                parameters,         
                commandType: CommandType.StoredProcedure  
            );
        }

        public async Task<QrImage?> GetQRImageByIdAsync(int qrImageId)
        {
            const string query = "SELECT * FROM dbo.QrImages WHERE QrImageId = @QrImageId";

            var parameters = new { QrImageId = qrImageId };

            return await _dbConnection.QueryFirstOrDefaultAsync<QrImage>(query, parameters);
        }
    }
}
