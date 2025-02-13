using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models.Authentication
{
    public class AppUser
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleInitial { get; set; }
        public string ContactNumber { get; set; }
        public string Location { get; set; }
        public bool IsApproved { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
    }
}
