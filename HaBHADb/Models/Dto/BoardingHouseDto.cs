
namespace HaBHAServer.Models.Dto
{
    public class BoardingHouseDto
    {
        public int? RoomNumber { get; set; }
        public int? RoomSize { get; set; }
        public decimal? PricePerMonth { get; set; }
        public bool IsAvailble { get; set; }
        public string? Descriptions { get; set; }
        public string? TenantId { get; internal set; }
        public int BoardinghouseId { get; internal set; }
    }
}
