using HaBHAServer.Models.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HaBHAServer.NewRepo
{
    public interface ISuperAdminRepository
    {
        Task<IEnumerable<ApplicationUser>> GetUnapprovedTenantsAsync();
        Task<ApplicationUser?> GetTenantByIdAsync(string tenantId);
        Task<bool> ApproveTenantAsync(ApplicationUser tenant);
        Task<bool> RejectTenantAsync(ApplicationUser tenant);
    }
    public class SuperAdminRepository : ISuperAdminRepository
    {
        private readonly UserManager<ApplicationUser> _userManager;

        public SuperAdminRepository(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }

        public async Task<IEnumerable<ApplicationUser>> GetUnapprovedTenantsAsync()
        {
            var unapprovedTenants = await (from user in _userManager.Users
                                           where user.IsApproved
                                           select user).ToListAsync();

            var tenantsInRole = new List<ApplicationUser>();
            foreach (var tenant in unapprovedTenants)
            {
                if (await _userManager.IsInRoleAsync(tenant, "Tenant"))
                {
                    tenantsInRole.Add(tenant);
                }
            }

            return tenantsInRole;
        }

        public async Task<ApplicationUser?> GetTenantByIdAsync(string tenantId)
        {
            return await _userManager.FindByIdAsync(tenantId.ToString());
        }

        public async Task<bool> ApproveTenantAsync(ApplicationUser tenant)
        {
            tenant.IsApproved = true;
            var result = await _userManager.UpdateAsync(tenant);
            return result.Succeeded;
        }

        public async Task<bool> RejectTenantAsync(ApplicationUser tenant)
        {
            var result = await _userManager.DeleteAsync(tenant);
            return result.Succeeded;
        }
    }
}
