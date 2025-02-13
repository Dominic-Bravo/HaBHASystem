using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models.Authentication
{
    public class ResetPasswordDto
    {
        public string EmailAddress { get; set; }
        public string NewPassword { get; set; }
    }
}
