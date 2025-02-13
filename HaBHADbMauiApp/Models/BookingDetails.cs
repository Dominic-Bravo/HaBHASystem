using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models
{
    public class BookingDetails
    {
        public AppUser User { get; set; }
        public BoardingHouse BoardingHouse { get; set; }
    }
}
