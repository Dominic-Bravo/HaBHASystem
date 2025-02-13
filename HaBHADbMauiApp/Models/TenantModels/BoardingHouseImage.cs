using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models.TenantModels
{
    public class BoardingHouseImage
    {
        public int ImageId { get; set; }
        public int BoardinghouseId { get; set; }
        public string? ImageBase64 { get; set; }
        public string? Description { get; set; }
        public ImageSource? ImageSource { get; set; }
    }
}
