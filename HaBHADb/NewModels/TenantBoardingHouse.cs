namespace HaBHAServer.NewModels
{
    public class TenantBoardingHouse
    {
        public int BoardinghouseId { get; set; } 
        public int? RoomNumber { get; set; }     
        public int? RoomSize { get; set; }       
        public decimal? PricePerMonth { get; set; } 
        public bool IsAvailable { get; set; }    
        public string? Descriptions { get; set; } 
        public string? TenantId { get; set; }     
        public string? ClientId { get; set; }
    }
}
