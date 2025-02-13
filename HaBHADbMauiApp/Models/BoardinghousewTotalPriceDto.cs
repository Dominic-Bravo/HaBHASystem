using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models
{
    public class BoardinghousewTotalPriceDto
    {
        public int BoardinghouseId { get; set; }
        public int RoomNumber { get; set; }
        public int RoomSize { get; set; }
        public string TenantId { get; set; }
        public string ClientId { get; set; }
        public decimal PricePerMonth { get; set; }
        public bool IsAvailable { get; set; }
        public string Descriptions { get; set; }
        public decimal TotalAmenitiesPrice { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
