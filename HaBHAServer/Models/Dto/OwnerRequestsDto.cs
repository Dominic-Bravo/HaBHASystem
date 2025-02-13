namespace HaBHAServer.Models.Dto
{
    public class OwnerRequestsDto
    {
        public int ClientRequestId { get; set; }
        public int BoardinghouseId { get; set; }
        public string? TenantId { get; set; }
        public int? RoomNumber { get; set; }
        public int? RoomSize { get; set; }
        public decimal? PricePerMonth { get; set; }
        public string Descriptions { get; set; }
        public DateTime RequestDate { get; set; }
        public string Status { get; set; }
        public string Message { get; set; }
    }
}
