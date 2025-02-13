using System.ComponentModel.DataAnnotations;

namespace HaBHAServer.Models.Client
{
    public class ClientRequest
    {
        [Key]
        public int ClientRequestId { get; set; }
        public int BoardinghouseId { get; set; }
        public string? ClientId { get; set; }
        public DateTime RequestDate { get; set; } = DateTime.UtcNow;
        public DateTime? InputDate { get; set; }
        public string Status { get; set; }
        public string Message { get; set; }
    }
}
