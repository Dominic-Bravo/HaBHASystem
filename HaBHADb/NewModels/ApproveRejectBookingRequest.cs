namespace HaBHAServer.NewModels
{
    public class ApproveRejectBookingRequest
    {
        public int BookingId { get; set; }
        public string ApprovalStatus { get; set; }  
        public int BoardinghouseId { get; set; }
        public string ClientId { get; set; }
    }
}
