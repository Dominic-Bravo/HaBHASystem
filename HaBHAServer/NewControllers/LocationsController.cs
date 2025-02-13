using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationsController : ControllerBase
    {
        private readonly ILocationRepository _locationRepository;

        public LocationsController(ILocationRepository locationRepository)
        {
            _locationRepository = locationRepository;
        }

        [HttpGet("GetAllLocations")]
        public async Task<IActionResult> GetAllLocations()
        {
            var locations = await _locationRepository.GetAllLocationsAsync();

            if (locations == null || !locations.Any())
            {
                return NotFound(new { Message = "No locations found." });
            }

            return Ok(locations);
        }

        [HttpPost("CreateLocation")]
        public async Task<IActionResult> CreateLocation([FromBody] BhLocation location)
        {
            if (location == null || location.Latitude == 0 || location.Longitude == 0)
            {
                return BadRequest(new { Message = "Invalid location data." });
            }
            
            var newLocationId = await _locationRepository.CreateLocationAsync(location.Latitude, location.Longitude, location.BoardinghouseId);

            return CreatedAtAction(nameof(GetLocationById), new { id = newLocationId }, new { Message = "Location created successfully.", LocationId = newLocationId });
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetLocationById(int id)
        {
            var location = await _locationRepository.GetLocationByIdAsync(id);
            if (location == null)
            {
                return NotFound(new { Message = "Location not found." });
            }

            return Ok(location);
        }

        [HttpDelete("DeleteLocation/{locationId}")]
        [Authorize]
        public async Task<IActionResult> DeleteLocation(int locationId)
        {
            var rowsAffected = await _locationRepository.DeleteLocationAsync(locationId);

            if (rowsAffected == 0)
            {
                return NotFound(new { Message = "Location not found." });
            }

            return Ok(new { Message = "Location deleted successfully.", LocationId = locationId });
        }

        [HttpGet("GetLocationsByBoardinghouseId/{boardinghouseId}")]
        public async Task<IActionResult> GetLocationsByBoardinghouseId(int boardinghouseId)
        {
            var locations = await _locationRepository.GetLocationsByBoardinghouseIdAsync(boardinghouseId);

            if (locations == null || !locations.Any())
            {
                return NotFound(new { Message = "No locations found for the given boarding house." });
            }

            return Ok(locations);
        }
    }
}
