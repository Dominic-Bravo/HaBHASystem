using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.ClientModels;
using HaBHADbMauiApp.Models.Dto;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.ClientView;

public partial class ClientMakeRequestView : ContentPage
{
    private readonly ClientService _clientService;
    private BoardingHouseWithImageDto _boardingHouse;
    public ClientMakeRequestView(ClientService clientService, BoardingHouseWithImageDto boardingHouse)
	{
		InitializeComponent();
        _clientService = clientService;
        _boardingHouse = boardingHouse;
	}

    private async void btnAdd_Clicked(object sender, EventArgs e)
    {
        string token = await GetAuthenticationTokenAsync();

        await _clientService.ClientAddRequestAsync(new MakeRequestDto
        {
            BoardinghouseId = _boardingHouse.BoardinghouseId,
            Message = txtMessage.Text
        }, token);

        await DisplayAlert("Success", "Added Successfully", "OK");
    }

    private async void btnCancel_Clicked(object sender, EventArgs e)
    {
        await Navigation.PopModalAsync();
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