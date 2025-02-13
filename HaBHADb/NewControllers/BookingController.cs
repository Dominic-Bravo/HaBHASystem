using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol.Core.Types;
using System.Security.Claims;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookingController : ControllerBase
    {
        private readonly IBookingRepository _bookingRepository;
        public BookingController(IBookingRepository bookingRepository)
        {
            _bookingRepository = bookingRepository;
        }

        [HttpGet("Amenities/{bookingId}")]
        public async Task<IActionResult> GetAmenitiesByBookingId(int bookingId)
        {
            var amenities = await _bookingRepository.GetAmenitiesByBookingIdAsync(bookingId);

            if (amenities == null || !amenities.Any())
            {
                return NotFound($"No amenities found for BookingId: {bookingId}");
            }

            return Ok(amenities);
        }

        [HttpGet("Pending")]
        public async Task<IActionResult> GetPendingBookings()
        {
            var pendingBookings = await _bookingRepository.GetPendingBookingsAsync();

            if (pendingBookings == null || !pendingBookings.Any())
            {
                return NotFound("No pending bookings found.");
            }

            return Ok(pendingBookings);
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> AddBooking([FromBody] Booking booking)
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { Message = "User not authenticated." });
            }

            booking.ClientId = userId;

            if (booking == null)
            {
                return BadRequest(new { Message = "Invalid booking data." });
            }

            var hasPendingBooking = await _bookingRepository.CheckIfClientHasBookingAsync(userId);
            if (hasPendingBooking)
            {
                return BadRequest(new { Message = "You already have a pending booking." });
            }

            var bookingId = await _bookingRepository.AddBookingAsync(booking);

            return CreatedAtAction(nameof(GetBookingById), new { id = bookingId }, new { Message = "Booking created successfully.", BookingId = bookingId });
        }



        [HttpGet("{id}")]
        public async Task<IActionResult> GetBookingById(int id)
        {
            var booking = await _bookingRepository.GetBookingByIdAsync(id);

            if (booking == null)
            {
                return NotFound($"Booking with ID {id} not found.");
            }

            return Ok(booking);
        }

        [HttpGet("newestBoardinghouse")]
        [Authorize]
        public async Task<IActionResult> GetNewestBoardinghouseIdByClientIdAsync()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            var boardinghouseId = await _bookingRepository.GetNewestBoardinghouseIdByClientIdAsync(userId);

            if (boardinghouseId.HasValue)
            {
                return Ok(new { BoardinghouseId = boardinghouseId.Value });
            }

            return NotFound(new { Message = "No boardinghouse found for the given client." });
        }

        [HttpDelete("DeleteBooking/{bookingId}")]
        [Authorize] 
        public async Task<IActionResult> DeleteBooking([FromQuery] int? bookingId, [FromQuery] int? boardinghouseId)
        {
            var claimsIdentity = User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { Message = "Client not authenticated." });
            }

            try
            {
                var rowsAffected = await _bookingRepository.DeleteBookingByClientAsync(bookingId, boardinghouseId, userId);

                if (rowsAffected == 0)
                {
                    return NotFound(new { Message = "Booking not found or you do not have permission to delete it." });
                }

                return Ok(new { Message = "Booking deleted successfully." });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    new { Message = "An error occurred while deleting the booking.", Error = ex.Message });
            }
        }
    }
}
