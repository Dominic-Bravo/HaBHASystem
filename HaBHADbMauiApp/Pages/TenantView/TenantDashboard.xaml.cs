using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using MapforMaui.MapUI;
using System.Collections.ObjectModel;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.TenantView;

public partial class TenantDashboard : ContentPage
{
    public ObservableCollection<BoardingHouse> BoardingHouses { get; set; } = new ObservableCollection<BoardingHouse>();
    public bool IsRefreshing { get; set; }
    public Command RefreshCommand { get; }

    private readonly TenantService _tenantService;
	public TenantDashboard(TenantService tenantService)
	{
		InitializeComponent();
        _tenantService = tenantService;

        RefreshCommand = new Command(async () => await LoadBoardingHouses());
        BindingContext = this;
    }

    private async void btnShowBH_Clicked(object sender, EventArgs e)
    {
        await LoadBoardingHouses();
    }

    private void BtnMaps_Clicked(object sender, EventArgs e)
    {
         //Navigation.PushModalAsync(new TenantMap());
    }

    private void TappedShowList_Tapped(object sender, TappedEventArgs e)
    {

    }

    private async void OnEditSwipe_Invoked(object sender, EventArgs e)
    {
        if (sender is SwipeItem swipeItem && swipeItem.BindingContext is BoardingHouse bh)
        {
            await Navigation.PushModalAsync(new TenantInventoryManagementView(_tenantService, bh));
        }
    }

    private async void OnDeleteSwipe_Invoked(object sender, EventArgs e)
    {
        if (sender is SwipeItem swipeItem && swipeItem.BindingContext is BoardingHouse bh)
        {
            bool confirm = await DisplayAlert("Confirm Delete", "Are you sure you want to delete this item?", "Yes", "No");
            if (confirm)
            {
                string token = await GetAuthenticationTokenAsync();
                await _tenantService.DeleteOwnerBoardingHouseAsync(bh.BoardinghouseId);
            }
        }
    }

    private async void BtnAddBoardinghouse_Clicked(object sender, EventArgs e)
    {
        await Navigation.PushModalAsync(new TenantInventoryManagementView(_tenantService, boardingHouse:null));
    }

    //public async Task LoadBoardingHouses()
    //{

    //    var sr = await SecureStorage.Default.GetAsync("Authentication");
    //    string token = string.Empty;

    //    if (!string.IsNullOrEmpty(sr))
    //    {
    //        var loginResponse = JsonSerializer.Deserialize<LoginResponse>(sr);
    //        if (loginResponse != null)
    //        {
    //            token = loginResponse.Token;

    //        }
    //    }

    //    var data = await _tenantService.GetBoardingHousesAsync(token);

    //    productListView1.ItemsSource = data;
    //}


    private async Task LoadBoardingHouses()
    {
        // Start the refresh animation
        IsRefreshing = true;

        try
        {
            // Simulate token retrieval from SecureStorage
            var sr = await SecureStorage.Default.GetAsync("Authentication");
            string token = string.Empty;

            if (!string.IsNullOrEmpty(sr))
            {
                var loginResponse = JsonSerializer.Deserialize<LoginResponse>(sr);
                if (loginResponse != null)
                {
                    token = loginResponse.Token;
                }
            }

            // Fetch data
            var data = await _tenantService.GetBoardingHousesAsync(token);

            // Clear existing data and add new items
            BoardingHouses.Clear();
            foreach (var item in data)
            {
                BoardingHouses.Add(item);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred while loading boarding houses: {ex.Message}", "OK");
        }
        finally
        {
            // Stop the refresh animation
            IsRefreshing = false;
        }
    }

    private async Task<string> GetAuthenticationTokenAsync()
    {
        try
        {
            var serializedResponse = await SecureStorage.Default.GetAsync("Authentication");

            return ExtractToken(serializedResponse);
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Failed to retrieve authentication token: {ex.Message}", "OK");
            return string.Empty;
        }
    }

    private string ExtractToken(string serializedResponse)
    {
        if (!string.IsNullOrEmpty(serializedResponse))
        {
            var loginResponse = JsonSerializer.Deserialize<LoginResponse>(serializedResponse);
            if (loginResponse != null)
            {
                return loginResponse.Token;
            }
        }
        return string.Empty;
    }
}