using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol.Core.Types;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TenantAmenityController : ControllerBase
    {
        private readonly ITenantAmenityRepository _tenantAmenityRepository;
        public TenantAmenityController(ITenantAmenityRepository tenantAmenityRepository)
        {
            _tenantAmenityRepository = tenantAmenityRepository;
        }

        [HttpGet("ByBoardinghouse/{boardinghouseId}")]
        public async Task<IActionResult> GetAmenitiesByBoardinghouseId(int boardinghouseId)
        {
            var amenities = await _tenantAmenityRepository.GetAmenitiesByBoardinghouseIdAsync(boardinghouseId);

            if (amenities == null || !amenities.Any())
            {
                return NotFound($"No amenities found for BoardinghouseId: {boardinghouseId}");
            }

            return Ok(amenities);
        }

        [HttpPost]
        public async Task<IActionResult> AddAmenity([FromBody] TenantAmenity amenity)
        {
            if (amenity == null)
            {
                return BadRequest("Invalid amenity data.");
            }

            var newAmenityId = await _tenantAmenityRepository.AddAmenityAsync(amenity);

            return CreatedAtAction(nameof(GetAmenitiesByBoardinghouseId), new { boardinghouseId = amenity.BoardinghouseId }, new { AmenityId = newAmenityId, Message = "Successfully Added amenities." });
        }

        [HttpPut("Update")]
        public async Task<IActionResult> UpdateAmenity([FromBody] TenantAmenity amenity)
        {
            var result = await _tenantAmenityRepository.UpdateAmenityAsync(amenity);

            if (result == 0)
            {
                return NotFound("Amenity not found.");
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAmenity(int id)
        {
            var result = await _tenantAmenityRepository.DeleteAmenityAsync(id);

            if (result == 0)
            {
                return NotFound($"Amenity with ID {id} not found.");
            }

            return NoContent(); 
        }
    }
}
