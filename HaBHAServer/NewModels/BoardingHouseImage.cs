namespace HaBHAServer.NewModels
{
    public class BoardingHouseImage
    {
        public int ImageId { get; set; }
        public int BoardinghouseId { get; set; }
        public string? ImageBase64 { get; set; }  
        public string? Description { get; set; }
    }
}
