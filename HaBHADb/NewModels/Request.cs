namespace HaBHAServer.NewModels
{
    public class Request
    {
        public int ClientRequestId { get; set; }
        public int? BoardinghouseId { get; set; }
        public string ClientId { get; set; }  
        public DateTime RequestDate { get; set; }
        public DateTime? InputDate { get; set; } 
        public string Status { get; set; }
        public string? Message { get; set; }
    }
}
