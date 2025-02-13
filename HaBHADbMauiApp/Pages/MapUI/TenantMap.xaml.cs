using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;
using HaBHADbMauiApp.Models;

namespace MapforMaui.MapUI
{
    public partial class TenantMap : ContentPage
    {
        private bool _isPinPlacementMode = false;
        private readonly AccountService _accountService;
        private readonly AppUser _appUser;
        private readonly TenantService _tenantService;
        private readonly BoardingHouse _boardingHouse;

        public TenantMap(TenantService tenantService, BoardingHouse boardingHouse)
        {
            InitializeComponent();
            _tenantService = tenantService;
            _boardingHouse = boardingHouse;

            InitializeMap();
        }

        public TenantMap(AccountService accountService, AppUser appUser)
        {
            InitializeComponent();
            _accountService = accountService;
            _appUser = appUser;

            InitializeMap();
        }

        private void InitializeMap()
        {
            var initialLocation = new Location(7.197010762417296, 124.5367950297242);
            mappy.MoveToRegion(MapSpan.FromCenterAndRadius(initialLocation, Distance.FromMiles(1)));

            foreach (var pin in PinRepository.Pins)
            {
                mappy.Pins.Add(pin);
            }
        }

        private void AddPinButton_Clicked(object sender, EventArgs e)
        {
            _isPinPlacementMode = true;
            DisplayAlert("Pin Placement", "Tap on the map to place a pin on your establishment.\n\nNote: Please Zoom in for better accuracy", "OK");
        }

        private async void OnMapClicked(object sender, MapClickedEventArgs e)
        {
            if (_isPinPlacementMode)
            {
                string label = await DisplayPromptAsync("Boarding House Name", "Enter the name of your Boarding House:");
                if (string.IsNullOrEmpty(label))
                {
                    await DisplayAlert("Invalid Input", "Enter the name of your Boarding House.", "OK");
                    return;
                }

                string description = await DisplayPromptAsync("Pin Description", "Enter the description of your Boarding House:");
                if (string.IsNullOrEmpty(description))
                {
                    await DisplayAlert("Invalid Input", "Please enter a description of your Boarding House.", "OK");
                    return;
                }

                double latitude = e.Location.Latitude;
                double longitude = e.Location.Longitude;

                await DisplayAlert("Pin Coordinates", $"Latitude: {latitude}\nLongitude: {longitude}", "OK");

                try
                {
                    var loc = new BoardingHouseLocation
                    {
                        Latitude = latitude,
                        Longitude = longitude,
                        BoardinghouseId = _boardingHouse.BoardinghouseId
                    };

                    await _tenantService.TenantAddLocationAsync(loc);

                    await DisplayAlert("Coordinates Saved!", $"Latitude: {latitude}\nLongitude: {longitude}", "OK");
                }
                catch (Exception ex)
                {
                    await DisplayAlert("Error", $"Failed to save coordinates: {ex.Message}", "OK");
                }

                AddPin(label, description, latitude, longitude);
                _isPinPlacementMode = false;
            }
        }

        private void AddPin(string label, string description, double latitude, double longitude)
        {
            var pin = new Pin
            {
                Label = $"{label} - {_appUser.LastName}",
                Address = description,
                Location = new Location(latitude, longitude),
            };

            pin.MarkerClicked += OnPinClicked;
            mappy.Pins.Add(pin);
            PinRepository.Pins.Add(pin);
        }

        private async void OnPinClicked(object sender, PinClickedEventArgs e)
        {
            if (sender is Pin pin)
            {
                await DisplayAlert("Pin Details", $"Name: {pin.Label}\nDescription: {pin.Address}", "OK");

                string action = await DisplayActionSheet("Pin Options", "Cancel", null, "Edit", "Delete");
                if (action == "Edit")
                {
                    string newLabel = await DisplayPromptAsync("Edit Pin", "Enter new name:", initialValue: pin.Label);
                    if (!string.IsNullOrEmpty(newLabel))
                    {
                        pin.Label = newLabel;
                    }

                    string newDescription = await DisplayPromptAsync("Edit Description", "Enter new description:", initialValue: pin.Address);
                    if (!string.IsNullOrEmpty(newDescription))
                    {
                        pin.Address = newDescription;
                    }
                }
                else if (action == "Delete")
                {
                    mappy.Pins.Remove(pin);
                    PinRepository.Pins.Remove(pin);
                }
            }
        }

        private async void ImageButton_Clicked(object sender, EventArgs e)
        {
            await Navigation.PopModalAsync();
        }
    }
}