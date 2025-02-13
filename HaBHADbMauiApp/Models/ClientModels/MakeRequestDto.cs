using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models.ClientModels
{
    public class MakeRequestDto
    {
        public int BoardinghouseId { get; set; }
        //public int ClientRequestId { get; set; }
        public DateTime? InputDate { get; set; }
        public string Message { get; set; }

        //public int ClientRequestId { get; set; }
        //public int BoardinghouseId { get; set; }
        //public string? ClientId { get; set; }
        //public DateTime RequestDate { get; set; } = DateTime.UtcNow;
        //public DateTime? InputDate { get; set; }
        //public string Status { get; set; }
        //public string Message { get; set; }
    }
}
