using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models
{
    public class BookingApprovalDto
    {
        public int BookingId { get; set; }
        public string ApprovalStatus { get; set; }
        public int BoardinghouseId { get; set; }
        public string ClientId { get; set; }
    }
}
