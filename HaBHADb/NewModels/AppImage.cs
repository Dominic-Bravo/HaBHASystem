namespace HaBHAServer.NewModels
{
    public class AppImage
    {
        public int ImageId { get; set; }
        public int? BoardinghouseId { get; set; }
        public int? QRCodeImageId { get; set; }
        public string? UserId { get; set; }
        //public byte[] ImageData { get; set; }
        public string Description { get; set; }
    }
}
