using System.ComponentModel.DataAnnotations;

namespace HaBHAServer.Models.Dto
{
    public class ClientRequestWithBoardinghouseDto
    {
        [Key]
        public int BoardinghouseId { get; set; }
        public int? RoomNumber { get; set; }
        public int? RoomSize { get; set; }
        public decimal? PricePerMonth { get; set; }
        public bool? IsAvailble { get; set; }
        public string? Descriptions { get; set; }
        public DateTime? RequestDate { get; set; } 
        public DateTime? InputDate { get; set; }
        public string? Message { get; set; }
        public int? ImageId { get; set; }
        public string? FileName { get; set; }
        public string?  ContentType { get; set; }
        public byte[] ImageData { get; set; }
    }
}
