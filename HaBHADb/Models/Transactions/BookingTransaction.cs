using HaBHAServer.Models.Establishments;
using HaBHAServer.Models.User;

namespace HaBHAServer.Models.Transactions
{
    public class BookingTransaction
    {
        public int  BookingTransactionId { get; set; }
        public int BoardingHouseId { get; set; }
        public string ClientId { get; set; }
        public DateTime BookingDate { get; set; }
        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public string Status { get; set; }
        public decimal? AmountPaid { get; set; }


        public BoardingHouse BoardingHouse { get; set; }
        public ApplicationUser Client { get; set; }
    }
}
