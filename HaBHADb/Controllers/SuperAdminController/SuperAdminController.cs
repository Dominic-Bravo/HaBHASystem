using HaBHAServer.Models.User;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Mvc;

namespace HaBHAServer.Controllers.SuperAdminController
{
    [Route("api/[controller]")]
    [ApiController]
    public class SuperAdminController : ControllerBase
    {
        private readonly SuperAdminRepository _superAdminRepository;

        public SuperAdminController(SuperAdminRepository adminRepository)
        {
            _superAdminRepository = adminRepository;
        }

        [HttpGet("UnapprovedTenants")]
        public async Task<ActionResult<IEnumerable<ApplicationUser>>> GetUnapprovedTenants()
        {
            var unapprovedTenants = await _superAdminRepository.GetUnapprovedTenantsAsync();
            return Ok(unapprovedTenants);
        }

        [HttpPut("ApproveTenant/{tenantId}")]
        public async Task<IActionResult> ApproveTenant(string tenantId)
        {
            var tenant = await _superAdminRepository.GetTenantByIdAsync(tenantId);
            if (tenant == null)
            {
                return NotFound($"Tenant with ID '{tenantId}' not found.");
            }

            var success = await _superAdminRepository.ApproveTenantAsync(tenant);
            if (!success)
            {
                return StatusCode(500, "Failed to approve the tenant.");
            }

            return Ok($"Tenant with ID '{tenantId}' has been approved.");
        }

        [HttpDelete("RejectTenant/{tenantId}")]
        public async Task<IActionResult> RejectTenant(string tenantId)
        {
            var tenant = await _superAdminRepository.GetTenantByIdAsync(tenantId);
            if (tenant == null)
            {
                return NotFound($"Tenant with ID '{tenantId}' not found.");
            }

            var success = await _superAdminRepository.RejectTenantAsync(tenant);
            if (!success)
            {
                return StatusCode(500, "An error occurred while rejecting the tenant.");
            }

            return Ok($"Tenant with ID '{tenantId}' has been rejected.");
        }
    }
}
