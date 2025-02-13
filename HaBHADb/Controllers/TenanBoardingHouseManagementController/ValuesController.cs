using HaBHAServer.Data;
using HaBHAServer.Models.Dto;
using HaBHAServer.Models.Images;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace HaBHAServer.Controllers.TenanBoardingHouseManagementController
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ValuesController(ApplicationDbContext dbContext)
        {
            _context = dbContext;
        }


        [HttpPost("NewImageupload")]
        public async Task<IActionResult> UploadImage([FromForm] IFormFile file, [FromQuery] int BhId)
        {

            if (file == null || file.Length == 0)
                return BadRequest("File not selected");

            using var memoryStream = new MemoryStream();
            await file.CopyToAsync(memoryStream);

            var imageFile = new EstablishmentImageFile
            {
                FileName = file.FileName,
                ContentType = file.ContentType,
                ImageData = memoryStream.ToArray(),
                BoardinghouseId = BhId
            };

            _context.ImageFiles.Add(imageFile);
            await _context.SaveChangesAsync();

            return Ok(new { imageFile.ImageId });
        }

        [HttpPost("NewImageuploadwithBoardinghouse")]
        public async Task<IActionResult> UploadImagewithboardinghosue([FromForm] ImageUploadDto dto)
        {

            if (dto.File == null || dto.File.Length == 0)
                return BadRequest("File not selected");

            var boardingHouse = await _context.BoardingHouses.FindAsync(dto.BoardinghouseId);
            if (boardingHouse == null)
                return NotFound("BoardingHouse not found");

            using var memoryStream = new MemoryStream();
            await dto.File.CopyToAsync(memoryStream);

            var imageFile = new EstablishmentImageFile
            {
                FileName = dto.File.FileName,
                ContentType = dto.File.ContentType,
                ImageData = memoryStream.ToArray(),
                BoardinghouseId = dto.BoardinghouseId
            };

            _context.ImageFiles.Add(imageFile);
            await _context.SaveChangesAsync();

            return Ok(new { imageFile.ImageId });
        }

        [HttpGet("Image/{imageId}")]
        public async Task<IActionResult> GetImage(int imageId)
        {
            var image = await _context.ImageFiles.FindAsync(imageId);

            if (image == null)
                return NotFound();

            return File(image.ImageData, image.ContentType, image.FileName);
        }

        [HttpGet("ImagesByBoardinghouseId/{BoardingHouseId}")]
        public async Task<IActionResult> GetImagesByBoardingHouseId(int BoardingHouseId)
        {
            var images = await _context.ImageFiles
                .Where(i => i.BoardinghouseId == BoardingHouseId)
                .ToListAsync();

            if (images == null || !images.Any())
                return NotFound("No images found for the specified BoardingHouseId.");

            var imageList = images.Select(image => new
            {
                image.ImageId,
                image.FileName,
                image.ContentType,
                ImageBase64 = Convert.ToBase64String(image.ImageData)
            });

            return Ok(imageList);
        }

    }
}
