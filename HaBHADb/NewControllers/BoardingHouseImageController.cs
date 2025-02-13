using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol.Core.Types;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BoardingHouseImageController : ControllerBase
    {
        private readonly IBoardingHouseImageRepository _boardingHouseImageRepository;
        public BoardingHouseImageController(IBoardingHouseImageRepository boardingHouseImageRepository)
        {
            _boardingHouseImageRepository = boardingHouseImageRepository;
        }

        [HttpGet("ByBoardinghouse/{boardinghouseId}")]
        public async Task<IActionResult> GetBoardingHouseImagesByBoardinghouseId(int boardinghouseId)
        {
            var images = await _boardingHouseImageRepository.GetBoardingHouseImagesByBoardinghouseIdAsync(boardinghouseId);

            if (images == null || !images.Any())
            {
                return NotFound(new { Message = "No image found." });
            }

            return Ok(images);
        }

        [HttpPut("Update")]
        public async Task<IActionResult> UpdateBoardingHouseImage([FromBody] BoardingHouseImage image)
        {
            if (image == null)
            {
                return BadRequest(new { Message = "Invalid image data." });
            }

            var result = await _boardingHouseImageRepository.UpdateBoardingHouseImageAsync(image);

            if (result == 0)
            {
                return NotFound(new { Message = "No image found." });
            }

            return NoContent();
        }

        [HttpDelete("{imageId}")]
        public async Task<IActionResult> DeleteBoardingHouseImage(int imageId)
        {
            var result = await _boardingHouseImageRepository.DeleteBoardingHouseImageAsync(imageId);

            if (result == 0)
            {
                return NotFound(new { Message = "Image not found." });
            }

            return NoContent(); 
        }

        [HttpPost("Add")]
        public async Task<IActionResult> AddBoardingHouseImage([FromBody] BoardingHouseImage image)
        {
            if (image == null || string.IsNullOrEmpty(image.ImageBase64))
            {
                return BadRequest(new { Message = "Invalid image data." });
            }

            var result = await _boardingHouseImageRepository.AddBoardingHouseImageAsync(image);

            if (result == 0)
            {
                return BadRequest(new { Message = "Failed to add image." });
            }

            return CreatedAtAction(nameof(GetBoardingHouseImagesByBoardinghouseId), new { boardinghouseId = image.BoardinghouseId }, new { ImageBase64 = image.ImageBase64 });
        }


        [HttpDelete("DeleteAll/{boardinghouseId}")]
        public async Task<IActionResult> DeleteAllBoardingHouseImages(int boardinghouseId)
        {
            var result = await _boardingHouseImageRepository.DeleteAllBoardingHouseImagesAsync(boardinghouseId);

            if (result == 0)
            {
                return NotFound(new { Message = $"No images found for BoardinghouseId: {boardinghouseId}" });
            }

            return Ok(new { Message = "All images for the Boardinghouse have been deleted successfully." });
        }

    }
}
