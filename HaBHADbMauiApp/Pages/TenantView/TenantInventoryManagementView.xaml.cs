using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.Dto;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.TenantView;

public partial class TenantInventoryManagementView : ContentPage
{
    private readonly TenantService _tenantService;
    private readonly BoardingHouse _boardingHouse;
    public TenantInventoryManagementView(TenantService tenantService, BoardingHouse boardingHouse)
    {
        InitializeComponent();
        _tenantService = tenantService;
        _boardingHouse = boardingHouse;
        LoadOwnerBoardingHouse();
    }

    private void LoadOwnerBoardingHouse()
    {
        if (_boardingHouse is not null)
        {
            txtRoomNumber.Text = _boardingHouse.RoomNumber.ToString();
            txtRoomSize.Text = _boardingHouse.RoomSize.ToString();
            txtPricePerMonth.Text = _boardingHouse.PricePerMonth.ToString();
            txtDescriptions.Text = _boardingHouse.Descriptions;
            //txtIsAvailble.Text = _boardingHouse.IsAvailble.ToString();
        }
    }

    private async void btnAdd_Clicked(object sender, EventArgs e)
    {
        var sr = await SecureStorage.Default.GetAsync("Authentication");
        string token = string.Empty;

        var loginResponse = JsonSerializer.Deserialize<LoginResponse>(sr);

        if (loginResponse != null)
        {
            token = loginResponse.Token;

        }

        if (_boardingHouse is null)
        {
            await _tenantService.AddOwnerBoardingHouseAsync(new BoardingHouse
            {
                RoomNumber = int.Parse(txtRoomNumber.Text),
                RoomSize = int.Parse(txtRoomSize.Text),
                PricePerMonth = decimal.Parse(txtPricePerMonth.Text),
                Descriptions = txtDescriptions.Text
            }, token);

            await DisplayAlert("Success", "Added Successfully", "OK");
            await Navigation.PopModalAsync();
        }
        else
        {
            await _tenantService.UpdateOwnerBoardingHouseAsync(new BoardingHouse
            {
                TenantId = _boardingHouse.TenantId,
                BoardinghouseId = _boardingHouse.BoardinghouseId,
                RoomNumber = int.Parse(txtRoomNumber.Text),
                RoomSize = int.Parse(txtRoomSize.Text),
                PricePerMonth = decimal.Parse(txtPricePerMonth.Text),
                Descriptions = txtDescriptions.Text,
                //IsAvailble = bool.Parse(txtIsAvailble.Text)
            });

            await DisplayAlert("Success", "Update Successfully", "OK");
            await Navigation.PopModalAsync();

        }
    }

    private async void btnCancel_Clicked(object sender, EventArgs e)
    {
        await Navigation.PopModalAsync();
    }
}