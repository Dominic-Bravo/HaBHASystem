namespace HaBHAServer.NewModels
{
    public class TenantProfileCount
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ContactNumber { get; set; }
        public string Email { get; set; }
        public string Location { get; set; } 
        public int NumberOfBoardingHouses { get; set; }
        public int AvailableBoardingHouses { get; set; }
        public int NotAvailableBoardingHouses { get; set; }
    }
}
