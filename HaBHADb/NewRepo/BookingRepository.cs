using Dapper;
using HaBHAServer.NewModels;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Data.Common;

namespace HaBHAServer.NewRepo
{
    public interface IBookingRepository
    {
        Task<IEnumerable<AmenityDTO>> GetAmenitiesByBookingIdAsync(int bookingId);
        Task<IEnumerable<Booking>> GetPendingBookingsAsync();
        Task<int> AddBookingAsync(Booking booking);
        Task<Booking> GetBookingByIdAsync(int bookingId);
        Task<bool> CheckIfClientHasBookingAsync(string clientId);
        Task<IEnumerable<Booking>> GetPendingBookingsByTenantIdAsync(string tenantId);
        Task<int> DeleteBookingByClientAsync(int? bookingId, int? boardinghouseId, string clientId );
        Task<int?> GetNewestBoardinghouseIdByClientIdAsync(string clientId);
        Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByClientIdAsync(string clientId);
    }

    public class BookingRepository : IBookingRepository
    {
        private readonly IDbConnection _dbConnection;

        public BookingRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<IEnumerable<TenantBoardingHouse>> GetBoardingHousesByClientIdAsync(string clientId)
        {
            const string storedProcedure = "GetClientBoardingHouse";

            var parameters = new { ClientId = clientId };

            return await _dbConnection.QueryAsync<TenantBoardingHouse>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<bool> CheckIfClientHasBookingAsync(string clientId)
        {
            const string storedProcedure = "CheckIfClientHasBookingByClientId";

            var parameters = new { ClientId = clientId };

            var result = await _dbConnection.QuerySingleAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result == 1;
        }

        public async Task<int> AddBookingAsync(Booking booking)
        {
            const string storedProcedure = "AddBooking"; 

            var parameters = new
            {
                BoardinghouseId = booking.BoardinghouseId,
                ClientId = booking.ClientId,
                TenantId = booking.TenantId,
                CheckInDate = booking.CheckInDate,
                CheckOutDate = booking.CheckOutDate,
                TotalAmount = booking.TotalAmount,
                Status = booking.ApprovalStatus
            };

            return await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<AmenityDTO>> GetAmenitiesByBookingIdAsync(int bookingId)
        {
            const string storedProcedure = "GetAmenitiesByBookingId";  

            var parameters = new { BookingId = bookingId };

            return await _dbConnection.QueryAsync<AmenityDTO>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<Booking> GetBookingByIdAsync(int bookingId)
        {
            const string query = "SELECT * FROM Bookings WHERE BookingId = @BookingId";

            var parameters = new { BookingId = bookingId };

            return await _dbConnection.QueryFirstOrDefaultAsync<Booking>(query, parameters);
        }

        public async Task<IEnumerable<Booking>> GetPendingBookingsAsync()
        {
            const string storedProcedure = "GetPendingBookings";

            return await _dbConnection.QueryAsync<Booking>(
                storedProcedure,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<Booking>> GetPendingBookingsByTenantIdAsync(string tenantId)
        {
            const string storedProcedure = "GetPendingBookingsByTenantId";

            var parameters = new { TenantId = tenantId };

            return await _dbConnection.QueryAsync<Booking>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int?> GetNewestBoardinghouseIdByClientIdAsync(string clientId)
        {
            const string storedProcedure = "GetNewestBoardinghouseIdByClientId";  

            var parameters = new { ClientId = clientId };

            var result = await _dbConnection.ExecuteScalarAsync<int?>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<int> DeleteBookingByClientAsync(int? bookingId, int? boardinghouseId, string clientId)
        {
            const string storedProcedure = "DeleteBookingByClient";

            var parameters = new
            {
                BookingId = bookingId,           
                BoardinghouseId = boardinghouseId, 
                ClientId = clientId
            };

            return await _dbConnection.ExecuteAsync(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
