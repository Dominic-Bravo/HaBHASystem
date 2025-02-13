using Microsoft.AspNetCore.Identity;

namespace HaBHAServer.Models.User
{
    public class ApplicationUser : IdentityUser
    {
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? MiddleInitial { get; set; }
        public string? ContactNumber { get; set; }
        public string? Location { get; set; }
        public bool IsApproved { get; set; } = false;
    }
}
