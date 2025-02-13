namespace HaBHAServer.Models.Dto
{
    public class BHImgReqDto
    {
        public int BoardinghouseId { get; set; }
        public int? RoomNumber { get; set; }
        public int? RoomSize { get; set; }
        public decimal? PricePerMonth { get; set; }
        public bool IsAvailable { get; set; }
        public string Descriptions { get; set; }
        public string TenantId { get; set; }
        public int? ClientRequestId { get; set; }
        public string ClientId { get; set; }
        public DateTime? RequestDate { get; set; }
        public string Message { get; set; }
        public int? ImageId { get; set; }
        public string FileName { get; set; }
        public string ContentType { get; set; }
        public byte[] ImageData { get; set; }
    }
}
