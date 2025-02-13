using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models.TenantModels
{
    public class Amenity
    {
        public int AmenityId { get; set; }
        public int? BoardinghouseId { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
    }
}
