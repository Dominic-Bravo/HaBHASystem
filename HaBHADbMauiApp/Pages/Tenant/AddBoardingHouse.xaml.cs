using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class AddBoardingHousePage : ContentPage
{
    private readonly TenantService _tenantService;

    public AddBoardingHousePage(TenantService tenantService)
    {
        InitializeComponent();
        _tenantService = tenantService;
    }

    private async void BtnAddBoardingHouse_Clicked(object sender, EventArgs e)
    {
        try
        {
            var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

            if (string.IsNullOrWhiteSpace(token))
            {
                await Shell.Current.DisplayAlert("Error", "Authentication token is missing.", "OK");
                return;
            }

            if (string.IsNullOrWhiteSpace(TxtRoomNumber?.Text) ||
                string.IsNullOrWhiteSpace(TxtRoomSize?.Text) ||
                string.IsNullOrWhiteSpace(TxtPrice?.Text) ||
                string.IsNullOrWhiteSpace(TxtDescription?.Text))
            {
                await Shell.Current.DisplayAlert("Error", "All fields are required.", "OK");
                return;
            }

            var boardingHouse = new BoardingHouse
            {
                IsAvailable = true,
                RoomNumber = int.Parse(TxtRoomNumber.Text),
                RoomSize = int.Parse(TxtRoomSize.Text),
                PricePerMonth = decimal.Parse(TxtPrice.Text),
                Descriptions = TxtDescription.Text
            };

            var isSuccess = await _tenantService.AddOwnerBoardingHouseAsync(boardingHouse, token);

            if (isSuccess)
            {
                await DisplayAlert("Success", "Boarding house added successfully.", "OK");
                await Navigation.PopModalAsync(); // Close the modal after success
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            TxtRoomNumber.Text = string.Empty;
            TxtRoomSize.Text = string.Empty;
            TxtPrice.Text = string.Empty;
            TxtDescription.Text = string.Empty;
        }
    }

    private async void BtnCancel_Clicked(object sender, EventArgs e)
    {
        await Navigation.PopModalAsync(); // Close the modal on cancel
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
                    return (loginResponse.Token ?? string.Empty, loginResponse.RoleName ?? string.Empty);
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
