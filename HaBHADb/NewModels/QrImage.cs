namespace HaBHAServer.NewModels
{
    public class QrImage
    {
        public int QrImageId { get; set; }          
        public int? BoardingHouseId { get; set; }    
        public string QrCodeImage { get; set; }     
        public string TenantId { get; set; }
        public string? Description { get; set;}
    }
}
