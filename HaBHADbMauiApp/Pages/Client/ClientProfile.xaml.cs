using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Client;

public partial class ClientProfile : ContentPage
{
	private readonly ClientService _clientService;
	public ClientProfile(ClientService clientService)
	{
		InitializeComponent();
		_clientService = clientService;
        LoadBoardingHouse();
        LoadUserProfile();
	}

	private async Task LoadUserProfile()
	{
        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

        var data = _clientService.GetUserByIdAsync(token);
        

        this.BindingContext = data;
	}

    private async Task LoadBoardingHouse()
    {
        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();
        var data = await _clientService.GetBoardingHousesAsync(token);
        this.BindingContext = data;
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
}