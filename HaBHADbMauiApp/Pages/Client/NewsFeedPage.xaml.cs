using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using MapforMaui.MapUI;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Client;

public partial class NewsFeedPage : ContentPage
{
    private readonly ClientService _clientService;
	public NewsFeedPage(ClientService clientService)
	{
		InitializeComponent();
        _clientService = clientService;

        LoadAvailableBoardingHouseAsync();
    }

    private async Task LoadAvailableBoardingHouseAsync()
    {
        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

        var data = await Task.Run(() => _clientService.GetAvailableBHWithPriceAsync(token));

        ListBoardingHouse.ItemsSource = data;
    }

    private async void BtnHome_Clicked(object sender, EventArgs e)
    {
        BtnGoToMaps.IsEnabled = false;
        BtnHome.IsEnabled = false;

        try
        {
            //await LoadAvailableBoardingHouseAsync();
            await Navigation.PushModalAsync(new SearchByPriceRange(_clientService));
        }
        catch
        {

        }
        finally
        {
            BtnGoToMaps.IsEnabled = true;
            BtnHome.IsEnabled = true;
        }
    }

    private async void BtnGoToMaps_Clicked(object sender, EventArgs e)
    {
        BtnGoToMaps.IsEnabled = false;
        BtnHome.IsEnabled = false;

        try
        {
            await Navigation.PushModalAsync(new ViewMaps(_clientService));
        }
        catch
        {

        }
        finally
        {
            BtnGoToMaps.IsEnabled = true;
            BtnHome.IsEnabled = true;
        }
    }

    private async void BtnAddBook_Clicked(object sender, EventArgs e)
    {
        BtnGoToMaps.IsEnabled = false;
        BtnHome.IsEnabled = false;

        try
        {
            if (sender is Button button && button.BindingContext is BoardinghousewTotalPriceDto bh)
            {
                await Navigation.PushModalAsync(new BookingDetailsPage(_clientService, bh));
            }
        }
        catch
        {

        }
        finally
        {
            BtnGoToMaps.IsEnabled = true;
            BtnHome.IsEnabled = true;
        }
        
    }

    private async Task<(string Token, string RoleName)> GetAuthenticationTokenAndRoleAsync()
    {
        try
        {
            var serializedResponse = await SecureStorage.Default.GetAsync("Authentication");

            if (!string.IsNullOrEmpty(serializedResponse))
            {
                var loginResponse = JsonSerializer.Deserialize<LoginResponse>(serializedResponse);

                if (loginResponse != null)
                {
                    return (loginResponse.Token, loginResponse.RoleName);
                }
            }

            return (string.Empty, string.Empty);
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Failed to retrieve authentication data: {ex.Message}", "OK");
            return (string.Empty, string.Empty);
        }
    }

    private async void BtnGoProfile_Clicked(object sender, EventArgs e)
    {
        await Navigation.PushModalAsync(new ClientProfile(_clientService));
    }
}