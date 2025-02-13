using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.ClientModels;
using HaBHADbMauiApp.Models.Dto;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.ClientView;

public partial class ClientNewsFeedView : ContentPage
{
    private readonly ClientService _clientService;
	public ClientNewsFeedView(ClientService clientService)
	{
		InitializeComponent();
        _clientService = clientService;
	}

    private async void btnShowBH_Clicked(object sender, EventArgs e)
    {
        await LoadBoardingHouses();
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

    public async Task LoadBoardingHouses()
    {
        string token = await GetAuthenticationTokenAsync();

        var data = await _clientService.GetAvailableBoardingHousesAsync(token);

        productListView1.ItemsSource = data;
    }

    private async void productListView1_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        var data = (BoardingHouseWithImageDto)e.Item;
        bool result = await DisplayAlert(
        "Confirmation",
        "Are you sure you want to proceed?",
        "OK",
        "Cancel");

        if (result)
        {
            await Navigation.PushModalAsync(new ClientMakeRequestView(_clientService, data));
        }
    }
}