namespace HaBHAServer.Models.Dto
{
    public class BookingTransactionDto
    {
        public int BookingTransactionId { get; set; }
        public int BoardingHouseId { get; set; }
        public string ClientId { get; set; }
        public DateTime BookingDate { get; set; }
        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public string Status { get; set; } = "Pending";
        public decimal? AmountPaid { get; set; }
    }
}
