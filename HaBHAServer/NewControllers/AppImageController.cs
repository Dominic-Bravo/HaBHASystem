using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Configuration;
using System.Security.Claims;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AppImageController : ControllerBase
    {
        private readonly IAppImageRepository _appImageRepository;
        private readonly string _connectionString;

        public AppImageController(IAppImageRepository appImageRepository, IConfiguration configuration)
        {
            _appImageRepository = appImageRepository;
            _connectionString = configuration.GetConnectionString("NewDefaultConnection");
        }

        [HttpGet("dataonlyGetImageById/{imageId}")]
        public async Task<IActionResult> GetImageById(int imageId)
        {
            if (imageId <= 0)
            {
                return BadRequest("Invalid image ID.");
            }

            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    var query = "SELECT ImageData, Description, BoardinghouseId, QRCodeImageId, UserId FROM AppImages WHERE ImageId = @ImageId";

                    using (var command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ImageId", imageId);

                        var reader = await command.ExecuteReaderAsync();

                        if (await reader.ReadAsync())
                        {
                            var imageData = reader["ImageData"] as byte[];

                            if (imageData == null || imageData.Length == 0)
                            {
                                return NotFound("Image not found.");
                            }

                            var description = reader["Description"].ToString();
                            var boardinghouseId = reader["BoardinghouseId"];
                            var qrCodeImageId = reader["QRCodeImageId"];
                            var userId = reader["UserId"].ToString();

                            var imageMetadata = new
                            {
                                ImageId = imageId,
                                ImageData = imageData,
                                Description = description,
                                BoardinghouseId = boardinghouseId,
                                QRCodeImageId = qrCodeImageId,
                                UserId = userId
                            };

                            return Ok(imageMetadata); 
                        }
                        else
                        {
                            return NotFound("Image not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetImageById/{imageId}")]
        public async Task<IActionResult> GetsasImageById(int imageId)
        {
            if (imageId <= 0)
            {
                return BadRequest("Invalid image ID.");
            }

            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    var query = "SELECT ImageData, Description, BoardinghouseId, QRCodeImageId, UserId FROM AppImages WHERE ImageId = @ImageId";

                    using (var command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ImageId", imageId);

                        var reader = await command.ExecuteReaderAsync();

                        if (await reader.ReadAsync())
                        {
                            var imageData = reader["ImageData"] as byte[];

                            if (imageData == null || imageData.Length == 0)
                            {
                                return NotFound("Image not found.");
                            }

                            var description = reader["Description"].ToString();
                            var boardinghouseId = reader["BoardinghouseId"];
                            var qrCodeImageId = reader["QRCodeImageId"];
                            var userId = reader["UserId"].ToString();

                            return File(imageData, "image/jpeg", $"{imageId}.jpg"); 
                        }
                        else
                        {
                            return NotFound("Image not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetImages(int? boardinghouseId, int? qrCodeImageId, string? userId)
        {
            var images = await _appImageRepository.GetImagesByIdsAsync(boardinghouseId, qrCodeImageId, userId);

            if (images == null || !images.Any())
            {
                return NotFound("No images found for the provided IDs.");
            }

            return Ok(images);
        }

        [HttpPost("AddImages")]
        public async Task<IActionResult> AddAppImage([FromForm] string? boardinghouseId, [FromForm] string? qrCodeImageId, [FromForm] string? userId, [FromForm] string description, [FromForm] IFormFile image)
        {
            try
            {
                //if (image == null || image.Length == 0)
                //{
                //    return BadRequest(new { Message = "Image is required" });
                //}

                if (string.IsNullOrEmpty(userId))
                {
                    userId = null;  
                }
                if (string.IsNullOrEmpty(boardinghouseId))
                {
                    boardinghouseId = null;
                }
                if (string.IsNullOrEmpty(qrCodeImageId))
                {
                    qrCodeImageId = null;
                }

                byte[] imageData;
                using (var memoryStream = new MemoryStream())
                {
                    await image.CopyToAsync(memoryStream);
                    imageData = memoryStream.ToArray();
                }

                var imageId = _appImageRepository.AddAppImage(int.Parse(boardinghouseId), int.Parse(qrCodeImageId), userId, imageData,  description);

                if (imageId > 0)
                {
                    return Ok(new { Message = "Image added successfully", ImageId = imageId });
                }
                else
                {
                    return BadRequest(new { Message = "Failed to add image" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetImagesByBoardinghouseId/{boardinghouseId}")]
        public async Task<IActionResult> GetImagesByBoardinghouseIdAsync(int boardinghouseId)
        {
            if (boardinghouseId <= 0)
            {
                return BadRequest("Invalid boardinghouse ID.");
            }

            try
            {
                var images = await _appImageRepository.GetImagesByBoardinghouseIdAsync(boardinghouseId);

                if (images == null || !images.Any())
                {
                    return NotFound("No images found for the given BoardinghouseId.");
                }

                return Ok(images);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetImagesByQRCodeImageId/{qrCodeImageId}")]
        public async Task<IActionResult> GetImagesByQRCodeImageIdAsync(int qrCodeImageId)
        {
            if (qrCodeImageId <= 0)
            {
                return BadRequest("Invalid QRCodeImageId.");
            }

            try
            {
                var images = await _appImageRepository.GetImagesByQRCodeImageIdAsync(qrCodeImageId);

                if (images == null || !images.Any())
                {
                    return NotFound("No images found for the given QRCodeImageId.");
                }

                return Ok(images);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetImagesByUserId/{userId}")]
        public async Task<IActionResult> GetImagesByUserIdAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                return BadRequest("Invalid UserId.");
            }

            try
            {
                var images = await _appImageRepository.GetImagesByUserIdAsync(userId);

                if (images == null || !images.Any())
                {
                    return NotFound("No images found for the given UserId.");
                }

                return Ok(images);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetImagesByUserIdviaToken")]
        [Authorize]
        public async Task<IActionResult> GetImagesByTokenUserIdAsync()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;

            try
            {
                var images = await _appImageRepository.GetImagesByUserIdAsync(userId);

                if (images == null || !images.Any())
                {
                    return NotFound("No images found for the given UserId.");
                }

                return Ok(images);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("GetAllImages")]
        public async Task<IActionResult> GetAllImagesAsync()
        {
            try
            {
                var appImages = await _appImageRepository.GetAllAppImagesAsync();
                if (appImages == null || !appImages.Any())
                {
                    return NotFound(new { Message = "No images found." });
                }
                return Ok(appImages);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }
    }
}
