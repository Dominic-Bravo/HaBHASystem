using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Pages;
using HaBHADbMauiApp.Pages.ClientView;
using HaBHADbMauiApp.Pages.TenantView;
using HaBHADbMauiApp.Services;
using Microsoft.Maui;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class ChooseRoleView : ContentPage
{
	private readonly ClientService _clientService;
    private readonly TenantService _tenantService;
    public ChooseRoleView(ClientService clientService, TenantService tenantService)
	{
		InitializeComponent();
		_clientService = clientService;
        _tenantService = tenantService;
	}

    private async void RolePicker_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    private async void BtnAssignRole_Clicked(object sender, EventArgs e)
    {

        var selectedRole = RolePicker.SelectedItem as string;

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

        await _clientService.AsignRoles(new UserRole
        {
            RoleName = selectedRole
        }, token);

        await DisplayAlert(Title, selectedRole, "OK");
        await Navigation.PopModalAsync();
    }
}

   
