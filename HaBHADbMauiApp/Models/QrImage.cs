using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models
{
    public class QrImage
    {
        public int QrImageId { get; set; }
        public int? BoardingHouseId { get; set; }
        public string QrCodeImage { get; set; }
        public string? Description { get; set; }
        public string TenantId { get; set; }
    }
}
