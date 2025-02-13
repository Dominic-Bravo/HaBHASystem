using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class TenantNotificationPage : ContentPage
{
	private readonly TenantService _tenantService;
	public TenantNotificationPage(TenantService tenantService)
	{
		InitializeComponent();
		_tenantService = tenantService;
        LoadBoardingHouseLists();

        //TestListView.ItemsSource = new List<object>
        //    {
        //        new { Room = "Room 1", Description = "Garboza Boarding House", Price = "2500", RoomSize = "4" },
        //        new { Room = "Room 2", Description = "Garboza Boarding House", Price = "1500", RoomSize = "1" },
        //        new { Room = "Room 3", Description = "Garboza Boarding House", Price = "1700", RoomSize = "3" },
        //        new { Room = "Room 4", Description = "Garboza Boarding House", Price = "3000", RoomSize = "2" },
        //        new { Room = "Room 5", Description = "Garboza Boarding House", Price = "1500", RoomSize = "4" },
        //        new { Room = "Room 6", Description = "Garboza Boarding House", Price = "4000", RoomSize = "4" },
        //        new { Room = "Room 7", Description = "Garboza Boarding House", Price = "5000", RoomSize = "5" },
        //        new { Room = "Room 8", Description = "Garboza Boarding House", Price = "1000", RoomSize = "2" },
        //        new { Room = "Room 9", Description = "Garboza Boarding House", Price = "1500", RoomSize = "5" }
        //    };
    }



    private async Task LoadBoardingHouseLists()
    {
        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

        var data = await Task.Run(() => _tenantService.GetPendingBookingbyTenantAsync(token));
            

        TestListView.ItemsSource = data;
    }

    private async void TestListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        if (e.Item is Booking booking)
        {
            TestListView.IsEnabled = false;
            try
            {
                bool result = await DisplayAlert("Request List", "View Applicant Details", "YES", "NO");
                if (result)
                {
                    await Navigation.PushModalAsync(new DetailedNotificationPage(_tenantService, booking));
                }
                else
                {
                    // Handle the cancellation if needed
                    TestListView.SelectedItem = null;
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", ex.Message, "OK");
            }
            finally
            {
                TestListView.IsEnabled = true;
            }
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