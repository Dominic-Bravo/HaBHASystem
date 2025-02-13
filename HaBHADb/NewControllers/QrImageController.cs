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
    public class QrImageController : ControllerBase
    {
        private readonly IQrImageRepository _qrImageRepository;

        public QrImageController(IQrImageRepository qrImageRepository)
        {
            _qrImageRepository = qrImageRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetQrImage(int id)
        {
            var qrImage = await _qrImageRepository.GetQRImageByIdAsync(id);

            if (qrImage == null)
            {
                return NotFound(); 
            }

            return Ok(qrImage);
        }

        [HttpPost("create")]
        [Authorize]
        public async Task<IActionResult> CreateQrImageAsync([FromBody] QrImage request)
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            try
            {
                var newQrImageId = await _qrImageRepository.CreateQrImageAsync(
                    request.BoardingHouseId,
                    request.QrCodeImage,
                    userId,
                    request.Description
                );

                return CreatedAtAction(nameof(GetQrImage), new { id = newQrImageId }, new { ImageBase64 = request.QrCodeImage });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}"); 
            }
        }


        [HttpDelete("{qrImageId}")]
        public async Task<IActionResult> DeleteQrImage(int qrImageId)
        {
            var rowsAffected = await _qrImageRepository.DeleteQrImageAsync(qrImageId)   ;

            if (rowsAffected == 0)
            {
                return NotFound($"QR image with ID {qrImageId} not found.");
            }

            return Ok(new { Message = $"{rowsAffected} row(s) affected." });
        }

        [HttpGet("GetImageBy/{tenantId}")]
        public async Task<IActionResult> GetQrImagesByTenantId(string tenantId)
        {
            var qrImages = await _qrImageRepository.GetQrImagesByTenantIdAsync(tenantId);
            if (qrImages == null || !qrImages.Any())
            {
                return NotFound();  
            }

            return Ok(qrImages);  
        }
    }
}
