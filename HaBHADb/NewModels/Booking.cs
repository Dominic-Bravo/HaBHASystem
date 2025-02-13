namespace HaBHAServer.NewModels
{
    public class Booking
    {
        public int BookingId { get; set; }  
        public int BoardinghouseId { get; set; } 
        public string ClientId { get; set; }  
        public string TenantId { get; set; }  
        public DateTime BookingDate { get; set; }  
        public DateTime? CheckInDate { get; set; }  
        public DateTime? CheckOutDate { get; set; }  
        public decimal? TotalAmount { get; set; } 
        public string ApprovalStatus { get; set; }
    }
}
