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
    public class TenantApproveController : ControllerBase
    {
        private readonly ITenantApproveRepository _tenantApproveRepository;
        public TenantApproveController(ITenantApproveRepository tenantApproveRepository)
        {
            _tenantApproveRepository = tenantApproveRepository;
        }

        [HttpPut("ApproveOrReject")]
        public async Task<IActionResult> ApproveOrRejectBooking([FromBody] ApproveRejectBookingRequest request)
        {
            if (request == null)
            {
                return BadRequest("Invalid request data.");
            }

            var result = await _tenantApproveRepository.ApproveOrRejectBookingAsync(request.BookingId, request.ApprovalStatus, request.BoardinghouseId, request.ClientId);

            if (result == 0)
            {
                return NotFound($"Booking with ID {request.BookingId} not found.");
            }

            return Ok(new { Message = "Booking status updated successfully." });
        }

        [HttpGet("PendingBookingsbytenantId")]
        [Authorize]
        public async Task<IActionResult> GetPendingBookingsByTenantId()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;


            if (string.IsNullOrEmpty(userId))
            {
                return BadRequest(new { Message = "TenantId cannot be null or empty." });
            }

            try
            {
                var bookings = await _tenantApproveRepository.GetPendingBookingsByTenantIdAsync(userId);

                if (bookings == null || !bookings.Any())
                {
                    return NotFound(new { Message = "No pending bookings found for the specified tenant." });
                }

                return Ok(bookings);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    new { Message = "An error occurred while fetching pending bookings.", Error = ex.Message });
            }
        }
    }
}
