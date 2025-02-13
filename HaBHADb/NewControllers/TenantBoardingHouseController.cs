using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Humanizer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol.Core.Types;
using System.Security.Claims;

namespace HaBHAServer.NewControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TenantBoardingHouseController : ControllerBase
    {
        private readonly ITenantBoardingHouseRepository _tenantBoardingHouseRepository;

        public TenantBoardingHouseController(ITenantBoardingHouseRepository tenantBoardingHouseRepository)
        {
            _tenantBoardingHouseRepository = tenantBoardingHouseRepository;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllBoardingHouses()
        {
            var boardingHouses = await _tenantBoardingHouseRepository.GetAllBoardingHousesAsync();

            if (!boardingHouses.Any())
            {
                return NotFound("No boarding houses found.");
            }

            return Ok(boardingHouses);
        }

        [HttpPost("AddTenantBoardingHouse")]
        [Authorize]
        public async Task<IActionResult> AddBoardingHouse([FromBody] TenantBoardingHouse boardingHouse)
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized("User ID not found.");
            }

            boardingHouse.TenantId = userId;

            if (boardingHouse == null)
            {
                return BadRequest("Invalid boarding house data.");
            }

            var newId = await _tenantBoardingHouseRepository.AddBoardingHouseAsync(boardingHouse);

            return CreatedAtAction(nameof(GetById), new { id = newId }, new { BoardinghouseId = newId, Message = "Successfully added." });
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var boardingHouse = await _tenantBoardingHouseRepository.GetByIdAsync(id);
            if (boardingHouse == null)
            {
                return NotFound($"Boarding house with ID {id} not found.");
            }
            return Ok(boardingHouse);
        }

        //[HttpGet("ClientBy/{id}")]
        //public async Task<IActionResult> GetClientById(int id)
        //{
        //    var boardingHouse = await _tenantBoardingHouseRepository.GetClientByIDAsync(id);
        //    if (boardingHouse == null)
        //    {
        //        return NotFound($"Boarding house with ID {id} not found.");
        //    }
        //    return Ok(boardingHouse);
        //}

        [HttpGet("tenantBoardingHouse")]
        [Authorize]
        public async Task<IActionResult> GetBoardingHousesByTenantId()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;

            var boardingHouses = await _tenantBoardingHouseRepository.GetBoardingHousesByTenantIdAsync(userId);

            if (boardingHouses == null || !boardingHouses.Any())
                return NotFound(new { Message = "No boardign house found." });

            return Ok(boardingHouses);
        }

        [HttpGet("ClientBoardingHouse")]
        [Authorize]
        public async Task<IActionResult> GetBoardingHousesclieByTenantId()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity.FindFirst(ClaimTypes.Name)?.Value;

            var boardingHouses = await _tenantBoardingHouseRepository.GetBoardingHousesByTenantIdAsync(userId);

            if (boardingHouses == null || !boardingHouses.Any())
                return NotFound(new { Message = "No boardign house found." });

            return Ok(boardingHouses);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBoardingHouse(int id)
        {
            var result = await _tenantBoardingHouseRepository.DeleteBoardingHouseAsync(id);

            if (result == 0)
            {
                return NotFound($"Boarding house with ID {id} not found.");
            }

            return NoContent(); 
        }

        [HttpPut("UpdateBoardingHouse")]
        public async Task<IActionResult> UpdateBoardingHouse([FromBody] TenantBoardingHouse boardingHouse)  
        {
            var result = await _tenantBoardingHouseRepository.UpdateBoardingHouseAsync(boardingHouse);

            if (result == 0)
            {
                return NotFound("Boarding house not found.");
            }

            return Ok();
        }

        [HttpDelete("RemoveClient")]
        public async Task<IActionResult> RemoveClientFromBoardingHouse(int boardinghouseId, string clientId)
        {
            var resultMessage = await _tenantBoardingHouseRepository.RemoveClientFromBoardingHouseAsync(boardinghouseId, clientId);

            if (string.IsNullOrEmpty(resultMessage))
            {
                return NotFound(new { Message = "Failed to remove the client or boarding house not found." });
            }

            return Ok(new { Message = resultMessage });
        }



        [HttpGet("MinMaxPrice")]
        public async Task<IActionResult> GetTotalPrice(decimal minimumPrice, decimal maximumPrice)
        {
            var boardingHouseDetails = await _tenantBoardingHouseRepository.GetBoardingHouseWithTotalPriceAsync(minimumPrice, maximumPrice);

            if (boardingHouseDetails == null || !boardingHouseDetails.Any())
            {
                return NotFound("No boarding houses found within the specified price range.");
            }

            return Ok(boardingHouseDetails);
        }


        [HttpGet("available")]
        public async Task<IActionResult> GetAvailableBoardingHouses()
        {
            var boardingHouses = await _tenantBoardingHouseRepository.GetAvailableBoardingHousesAsync();
            return Ok(boardingHouses);
        }

        [HttpGet("GetBoardingHouseBy{id}")]
        public async Task<IActionResult> GetBoardingHouse(int id)
        {
            var boardingHouse = await _tenantBoardingHouseRepository.GetBoardingHouseByIdAsync(id);

            if (boardingHouse == null)
            {
                return NotFound(new { Message = $"Boarding House with ID {id} not found" });
            }

            return Ok(boardingHouse);
        }

        [HttpGet("GetTenantBoardingHouseCounts/{tenantId}")]
        public async Task<IActionResult> GetTenantBoardingHouseCountsByTenantId(string tenantId)
        {
            var tenantBoardingHouseCount = await _tenantBoardingHouseRepository.GetTenantBoardingHouseCountsByTenantIdAsync(tenantId);

            if (tenantBoardingHouseCount == null)
            {
                return NotFound(new { Message = "Tenant not found." });
            }

            return Ok(tenantBoardingHouseCount);
        }
    }
}
