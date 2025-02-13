using HaBHAServer.Models.Transactions;
using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookingTransactionsController : ControllerBase
    {
        private readonly IBookingTransactionRepository _transactionRepository;

        public BookingTransactionsController(IBookingTransactionRepository bookingTransaction)
        {
            _transactionRepository = bookingTransaction;
        }

        [HttpPost("AddBookingTransaction")]
        [Authorize]
        public async Task<IActionResult> AddBookingTransaction([FromBody] BookingTransactionDto dto)
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized("User ID not found.");
            }

            dto.ClientId = userId;

            var newId = await _transactionRepository.AddBookingTransactionAsync(dto);

            return CreatedAtAction(nameof(GetBookingTransactionById), new { id = newId }, new { BoardinghouseId = newId, Message = "Successfully added." });
        }

        [HttpGet("GetBookingTransactionById/{transactionId}")]
        public async Task<IActionResult> GetBookingTransactionById(int transactionId)
        {
            var bookingTransaction = await _transactionRepository.GetBookingTransactionByIdAsync(transactionId);

            if (bookingTransaction == null)
            {
                return NotFound(new { Message = "Booking transaction not found." });
            }

            return Ok(bookingTransaction);
        }

    }
}
