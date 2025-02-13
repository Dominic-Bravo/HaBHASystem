using System.ComponentModel.DataAnnotations;

namespace HaBHAServer.Models.Images
{
    public class EstablishmentImageFile
    {
        [Key]
        public int ImageId { get; set; }
        public string FileName { get; set; }
        public string ContentType { get; set; }
        public byte[] ImageData { get; set; }
        public int? BoardinghouseId { get; set; }
    }
}
