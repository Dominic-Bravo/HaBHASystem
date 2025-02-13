using HaBHAServer.Data;
using HaBHAServer.Models.User;
using HaBHAServer.NewModels;
using HaBHAServer.NewRepo;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace HaBHAServer.Controllers.AuthenticationController
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        public AccountController(UserManager<ApplicationUser> userManager, ApplicationDbContext dbContext, IUserRepository userRepository)
        {
            _userManager = userManager;
            _context = dbContext;
            _userRepository = userRepository;
        }

        [HttpGet("GetUserByTenantId")]
        [Authorize]
        public async Task<IActionResult> GetUserByTenantId()
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
                return BadRequest(new { message = "TenantId is required." });

            var user = await _userManager.Users.FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
                return NotFound(new { message = $"No user found with TenantId '{userId}'." });

            return Ok(new
            {
                user.Id,
                user.FirstName,
                user.LastName,
                user.MiddleInitial,
                user.ContactNumber,
                user.Location,
                user.IsApproved,
                user.Email,
                user.PhoneNumber
            });
        }

        [HttpGet("GetUserByClientId/{clientId}")]
        public async Task<IActionResult> GetUserByClientId(string clientId)
        {
            if (string.IsNullOrEmpty(clientId))
                return BadRequest(new { message = "ClientId is required." });

            var user = await _userManager.Users.FirstOrDefaultAsync(u => u.Id == clientId);

            if (user == null)
                return NotFound(new { message = $"No user found with ClientId '{clientId}'." });
            
            return Ok(new
            {
                user.Id,
                user.FirstName,
                user.LastName,
                user.MiddleInitial,
                user.ContactNumber,
                user.Location,
                user.IsApproved,
                user.Email,
                user.PhoneNumber
            });
        }

        [HttpPost("AssignRole")]
        [Authorize]
        public async Task<IActionResult> AssignRoleToUser([FromBody] UserRole userRole)
        {
            var claimsIdentity = this.User.Identity as ClaimsIdentity;
            var userId = claimsIdentity?.FindFirst(ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { Message = "User not authenticated." });
            }

            try
            {
                var result = await _userRepository.AssignRoleToUserAsync(userId, userRole.RoleName);

                if (result.Succeeded)
                {
                    return Ok(new { message = "Role assigned successfully." });
                }

                return BadRequest(new { Message = "Failed to assign role." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Internal server error.", error = ex.Message });
            }
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterModel model)
        {
            var user = new ApplicationUser
            {
                UserName = model.Email,
                Email = model.Email,
                FirstName = model.FirstName,
                MiddleInitial = model.MiddleInitial,
                LastName = model.LastName,
                Location = model.Location,
                PhoneNumber = model.ContactNumber
            };

            var result = await _userRepository.CreateUserAsync(user, model.Password);

            if (result.Succeeded)
            {
                return Ok(new { Messsage = "User successfully Registered." });
            }

            return BadRequest(new { Message = "Registration Failed, Try Again." });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel model)
        {
            var user = await _userRepository.GetUserByEmailAsync(model.Email);

            if (user == null)
            {
                return Unauthorized(new { Message = "Invalid login attempt." });
            }

            if (await _userRepository.CheckPasswordAsync(user, model.Password))
            {
                var roles = await _userRepository.GetUserRolesAsync(user);

                var roleName = roles.FirstOrDefault();

                //if (roleName == null)
                //{
                //    return Unauthorized(new { Message = "User has no roles assigned." });
                //}

                var token = await _userRepository.GenerateJwtTokenAsync(user, roles);
                return Ok(new { Token = token, Username = user.UserName, RoleName = roleName });
            }   

            return Unauthorized(new { Message = "Invalid login attempt." });
        }


        [HttpGet("GetUser")]
        public async Task<List<ApplicationUser>> GetUsersAsync()
        {
            return await _context.Users.ToListAsync();
        }

        [HttpPut("UpdateProfileByEmail")]
        public async Task<IActionResult> UpdateProfileByEmail([FromBody] UpdateProfileDTO model)
        {
            var user = await _userManager.FindByEmailAsync(model.EmailAddress);

            if (user == null)
            {
                return NotFound(new { Message = "User not found." });
            }

            user.FirstName = model.FirstName;
            user.LastName = model.LastName;
            user.MiddleInitial = model.MiddleInitial;
            user.ContactNumber = model.ContactNumber;
            user.Location = model.Location;

            var result = await _userManager.UpdateAsync(user);

            if (result.Succeeded)
            {
                return Ok(new { Message = "Profile updated successfully." });
            }
            else
            {
                return BadRequest(new { Message = "Profile update failed.", Errors = result.Errors });
            }
        }


        //[HttpPost("ForgotPassword")]
        //public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordDTO model)
        //{
        //    if (string.IsNullOrEmpty(model.Email))
        //    {
        //        return BadRequest("Email is required.");
        //    }

        //    var user = await _userManager.FindByEmailAsync(model.Email);

        //    if (user == null)
        //    {
        //        return NotFound("User not found.");
        //    }

        //    var token = await _userManager.GeneratePasswordResetTokenAsync(user);

        //    var resetLink = Url.Action(
        //        "ResetPassword",
        //        "Account",
        //        new { token = token, email = user.Email },
        //        Request.Scheme);

        //    await _emailService.SendEmailAsync(user.Email, "Password Reset", $"Click here to reset your password: {resetLink}");

        //    return Ok("Password reset link has been sent to your email.");
        //}

        [HttpPost("UpdatePassword")]
        public async Task<IActionResult> UpdatePassword(ResetPasswordDTO dto)
        {

            var user = await _userManager.FindByEmailAsync(dto.EmailAddress);

            if (user == null)
            {
                return NotFound(new { Message = "User not found." });
            }

            var removePasswordResult = await _userManager.RemovePasswordAsync(user);

            if (!removePasswordResult.Succeeded)
            {
                return BadRequest(new { Message = "Failed to remove the old password.", Errors = removePasswordResult.Errors });
            }

            var addPasswordResult = await _userManager.AddPasswordAsync(user, dto.NewPassword);

            if (addPasswordResult.Succeeded)
            {
                return Ok(new { Message = "Password has been successfully updated." });
            }

            return BadRequest(new { Message = "Failed to set the new password.", Errors = addPasswordResult.Errors });
        }

    }
}
