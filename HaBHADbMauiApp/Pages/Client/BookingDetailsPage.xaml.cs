using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Client;

public partial class BookingDetailsPage : ContentPage
{
	private readonly ClientService _clientService;
    private BoardinghousewTotalPriceDto _Dto;
	public BookingDetailsPage(ClientService clientService, BoardinghousewTotalPriceDto totalPriceDto)
	{
		InitializeComponent();
        _Dto = totalPriceDto;
		_clientService = clientService;

        TestListView.ItemsSource = new List<object>
            {
                new { Room = "Room 9", Description = "Garboza Boarding House", Price = "1500", RoomSize = "5" }
            };

        AmenitiesListView.ItemsSource = new List<object>
        {
            new { Name = "Aircon", Price = "500" },
            new { Name = "Heater", Price = "200" },
            new { Name = "Electric Fan", Price = "200" },
            new { Name = "Pillows", Price = "500" }
        };
    }

    private async void BtnCancel_Clicked(object sender, EventArgs e)
    {
        BtnCancel.IsEnabled = false;
        BtnConfirm.IsEnabled = false;
        try
        {
            await Navigation.PopModalAsync();
        }
        catch
        {

        }
        finally
        {
            BtnCancel.IsEnabled = true;
            BtnConfirm.IsEnabled = true;
        }
    }

    private async void BtnConfirm_Clicked(object sender, EventArgs e)
    {
        BtnCancel.IsEnabled = false;
        BtnConfirm.IsEnabled = false;

        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();
        int id = _Dto.BoardinghouseId;
        string tenantid = _Dto.TenantId;
        decimal price = _Dto.TotalPrice;

        try
        {
            var book = new Booking
            {
                BoardinghouseId = id,
                ApprovalStatus = "Pending",
                ClientId = "",
                BookingDate = DateTime.Now,
                CheckInDate = DateTime.Now,
                CheckOutDate = DateTime.Now,
                TenantId = tenantid,
                TotalAmount = price
            };

            await DisplayAlert("Data", $"BhId: {id} tenantid: {tenantid} price: {price}", "ok");

            bool isSuccess = await _clientService.AddBookingAsync(book, token);

            if (isSuccess)
            {
                await DisplayAlert("Success", "Booking approved successfully.", "Ok");
            }
            else
            {
                await DisplayAlert("Error", "Something went wrong, try again.", "Ok");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "Ok");
        }
        finally
        {
            BtnCancel.IsEnabled = true;
            BtnConfirm.IsEnabled = true;
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
}