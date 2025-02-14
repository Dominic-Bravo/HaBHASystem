using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using MapforMaui.MapUI;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class TenantListBoardingHouse : ContentPage
{
    private readonly TenantService _tenantService;
    private readonly AccountService _accountService;
    public TenantListBoardingHouse(TenantService tenantService, AccountService accountService)
    {
        InitializeComponent();
        _tenantService = tenantService;
        _accountService = accountService;

        // Ensure the BindingContext is set correctly
        BindingContext = this;

        // Load the boarding house lists
        LoadBoardingHouseLists();
    }

    private async Task LoadBoardingHouseLists()
    {
        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();
        var data = await _tenantService.GetBoardingHousesAsync(token);
        ListBoardingHouse.ItemsSource = data;
    }

    private async void BtnNotifications_Clicked(object sender, EventArgs e)
    {
        BtnNotifications.IsEnabled = false;
        BtnAdd.IsEnabled = false;
        BtnAddMaps.IsEnabled = false;

        try
        {
            await Navigation.PushModalAsync(new TenantNotificationPage(_tenantService));
        }
        catch
        {

        }
        finally
        {
            BtnNotifications.IsEnabled = true;
            BtnAdd.IsEnabled = true;
            BtnAddMaps.IsEnabled = true;
        }
    }

    private async void BtnAdd_Clicked(object sender, EventArgs e)
    {
        BtnNotifications.IsEnabled = false;
        BtnAdd.IsEnabled = false;
        BtnAddMaps.IsEnabled = false;

        try
        {
            await Navigation.PushModalAsync(new CustomizeBoardingHousePage(_tenantService, boardingHouse: null));
        }
        catch
        {

        }
        finally
        {
            BtnNotifications.IsEnabled = true;
            BtnAdd.IsEnabled = true;
            BtnAddMaps.IsEnabled = true;
        }
    }

    private async void BtnHome_Clicked(object sender, EventArgs e)
    {
        OnAppearing();
        await LoadBoardingHouseLists();
    }

    private async void BtnCustomize_Clicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.BindingContext is BoardingHouse bh)
        {
            button.IsEnabled = false;
            BtnNotifications.IsEnabled = false;
            BtnAdd.IsEnabled = false;
            BtnAddMaps.IsEnabled = false;

            try
            {
                await Navigation.PushModalAsync(new CustomizeBoardingHousePage(_tenantService, bh));
            }
            catch
            {

            }
            finally
            {
                button.IsEnabled = true;
                BtnNotifications.IsEnabled = true;
                BtnAdd.IsEnabled = true;
                BtnAddMaps.IsEnabled = true;
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


    private async void BtnAddMaps_Clicked(object sender, EventArgs e)
    {
   
        BtnNotifications.IsEnabled = false;
        BtnAdd.IsEnabled = false;
        BtnAddMaps.IsEnabled = false;

        try
        {
            await Navigation.PushModalAsync(new TenantMap(_tenantService));
        }
        catch
        {

        }
        finally
        {
            BtnNotifications.IsEnabled = true;
            BtnAdd.IsEnabled = true;
            BtnAddMaps.IsEnabled = true;
        }
    }
    private async void BtnAdd_Clicked_1(object sender, EventArgs e)
    {
        BtnNotifications.IsEnabled = false;
        BtnAdd.IsEnabled = false;
        BtnAddMaps.IsEnabled = false;

        try
        {
            await Navigation.PushModalAsync(new AddBoardingHousePage(_tenantService));
        }
        catch
        {

        }
        finally
        {
            BtnNotifications.IsEnabled = true;
            BtnAdd.IsEnabled = true;
            BtnAddMaps.IsEnabled = true;
        }
    }

    //private async void BtnAddMaps_Clicked_1(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (sender is Button button && button.BindingContext is AppUser appUser)
    //        {
    //            // Log the user ID for debugging
    //            System.Diagnostics.Debug.WriteLine($"Navigating to map with user ID: {appUser.Id}");

    //            await Navigation.PushModalAsync(new TenantMap(_accountService, appUser));
    //        }
    //        else
    //        {
    //            await DisplayAlert("Error", "Invalid user data.", "OK");
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        await DisplayAlert("Error", $"Failed to navigate: {ex.Message}", "OK");
    //    }
    //}
}





