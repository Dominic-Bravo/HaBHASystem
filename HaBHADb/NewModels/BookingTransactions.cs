namespace HaBHAServer.NewModels
{
    public class BookingTransactions
    {
        public int TransactionId { get; set; }
        public int BoardinghouseId { get; set; }
        public string? ClientId { get; set; }
        public string? TenantId { get; set; }
        public string? Image { get; set; }
        public DateTime RequestDate { get; set; }
        public DateTime? ApprovalDate { get; set; }
        public string Status { get; set; } = "Pending";
        public string? ApprovalStatus { get; set; }
        public string? Message { get; set; }
    }
}
