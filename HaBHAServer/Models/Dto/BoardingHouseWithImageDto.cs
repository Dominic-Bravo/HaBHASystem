namespace HaBHAServer.Models.Dto
{
    public class BoardingHouseWithImageDto
    {
        public int BoardinghouseId { get; set; }

        public string? TenantId { get; set; }
        public string? ClientId { get; set; }
        public int? RoomNumber { get; set; }
        public int? RoomSize { get; set; }
        public decimal? PricePerMonth { get; set; }
        public bool IsAvailble { get; set; }
        public string? Descriptions { get; set; }
        public int ImageId { get; set; }
        public string? FileName { get; set; }
        public string? ContentType { get; set; }
        public byte[]? ImageData { get; set; }
    }
}
