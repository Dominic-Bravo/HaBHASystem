using Dapper;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface ITenantApproveRepository
    {
        Task<int> ApproveOrRejectBookingAsync(int bookingId, string approvalStatus, int boardinghouseId, string clientId);
        Task<IEnumerable<Booking>> GetPendingBookingsByTenantIdAsync(string tenantId);

    }

    public class TenantApproveRepository : ITenantApproveRepository
    {
        private readonly IDbConnection _dbConnection;

        public TenantApproveRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> ApproveOrRejectBookingAsync(int bookingId, string approvalStatus, int boardinghouseId, string clientId)
        {
            const string storedProcedure = "ApproveOrRejectBooking";

            var parameters = new
            {
                BookingId = bookingId,
                ApprovalStatus = approvalStatus,
                BoardinghouseId = boardinghouseId,
                ClientId = clientId
            };

            return await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }


        public async Task<IEnumerable<Booking>> GetPendingBookingsByTenantIdAsync(string tenantId)
        {
            const string storedProcedure = "GetPendingBookingsByTenantId";

            var parameters = new
            {
                TenantId = tenantId
            };

            return await _dbConnection.QueryAsync<Booking>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

    }
}
