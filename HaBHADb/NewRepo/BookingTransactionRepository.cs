using Dapper;
using HaBHAServer.Models.Transactions;
using HaBHAServer.NewModels;
using System.Data;

namespace HaBHAServer.NewRepo
{
    public interface IBookingTransactionRepository
    {
        Task<int> AddBookingTransactionAsync(BookingTransactionDto dto);
        Task<BookingTransaction?> GetBookingTransactionByIdAsync(int transactionId);
    }

    public class BookingTransactionRepository : IBookingTransactionRepository
    {
        private readonly IDbConnection _dbConnection;

        public BookingTransactionRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> AddBookingTransactionAsync(BookingTransactionDto dto)
        {
            const string storedProcedure = "AddBookingTransaction";

            var parameters = new
            {
                BoardinghouseId = dto.BoardinghouseId,
                ClientId = dto.ClientId,
                Image = dto.Image,
                Message = dto.Message
            };

            return await _dbConnection.ExecuteScalarAsync<int>(
                storedProcedure,
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<BookingTransaction?> GetBookingTransactionByIdAsync(int transactionId)
        {
            const string query = "SELECT * FROM [dbo].[BookingTransactions] WHERE TransactionId = @TransactionId";

            //var parameters = new { TransactionId = transactionId };

            //var bookingTransaction = await _dbConnection.QueryFirstOrDefaultAsync<BookingTransaction>(query, parameters);

            //return bookingTransaction;

            return await _dbConnection.QueryFirstOrDefaultAsync<BookingTransaction>(query, new { Id = transactionId }); 
        }

    }
}
