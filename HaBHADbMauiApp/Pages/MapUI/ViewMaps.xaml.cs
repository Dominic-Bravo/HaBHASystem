using HaBHADbMauiApp.Services;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;


namespace MapforMaui.MapUI
{
    public partial class ViewMaps : ContentPage
    {
        private readonly ClientService _clientService;
        public ViewMaps(ClientService clientService)
        {
            InitializeComponent();
            _clientService = clientService; 
            var initialLocation = new Location(7.197010762417296, 124.5367950297242);
            ViewMap.MoveToRegion(MapSpan.FromCenterAndRadius(initialLocation, Distance.FromMiles(1)));

            LoadBoardingHouseLocations();

            // Load existing pins
            foreach (var pin in PinRepository.Pins)
            {
                ViewMap.Pins.Add(pin);
            }
        }

        private async void LoadBoardingHouseLocations()
        {
            var locations = await Task.Run(() => _clientService.GetLocationsAsync());

            if (locations != null)
            {
                foreach (var location in locations)
                {
                    var pin = new Pin
                    {
                        Label = $"Boarding House {location.BoardinghouseId}",
                        Address = $"ID: {location.Id}",
                        Location = new Location(location.Latitude, location.Longitude),
                        Type = PinType.Place
                    };


                    ViewMap.Pins.Add(pin);
                }
            }
            else
            {
                await DisplayAlert("Error", "Failed to load boarding house locations.", "OK");
            }
        }

        private async void ViewMap_MapClicked_1(object sender, MapClickedEventArgs e)
        {
            var pin = sender as Pin;
            if (pin != null)
            {
                // Display the pin details first
                await DisplayAlert("Pin Details", $"Name: {pin.Label}\nDescription: {pin.Address}", "OK");
            }
        }
    }
}