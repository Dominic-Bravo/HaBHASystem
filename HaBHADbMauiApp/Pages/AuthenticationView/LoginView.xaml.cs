using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;
using System.Text.Json;
using HaBHADbMauiApp.Pages.Tenant;
using HaBHADbMauiApp.Pages.Client;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class LoginView : ContentPage
{
    private readonly ClientService _clientService;
    private readonly TenantService _tenantService;
    private readonly AccountService _accountService;

    public LoginView(ClientService clientService,AccountService accountService, TenantService tenantService)
    {
        InitializeComponent();
        _clientService = clientService;
        _tenantService = tenantService;
        _accountService = accountService;    
    }

    private string GenerateRandomCode(int length)
    {
        var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var random = new Random();
        return new string(Enumerable.Repeat(characters, length)
                                    .Select(s => s[random.Next(s.Length)])
                                    .ToArray());
    }

    private async void BtnForgotPassword_Clicked(object sender, EventArgs e)
    {
        var generatedCode = GenerateRandomCode(6);

        await Navigation.PushModalAsync(new OtpPage(generatedCode, _accountService));

    }

    private async void BtnGoToSignup_Clicked(object sender, EventArgs e)
    {
        await Navigation.PushModalAsync(new SignupView(_clientService, _accountService, _tenantService));
    }

    private async void BtnLogin_Clicked(object sender, EventArgs e)
    {
        string email = Username.Text;
        string password = Password.Text;

        BtnForgotPassword.IsEnabled = false;
        BtnGoToSignup.IsEnabled = false;
        BtnLogin.IsEnabled = false;

        if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
        {
            await DisplayAlert("Error", "Please enter both email and password.", "OK");
            return;
        }
        try
        {
            var model = new LoginModel
            {
                Email = email,
                Password = password
            };


            bool isSuccess = await _clientService.Login(model);


            var (Token, roleName) = await GetAuthenticationTokenAndRoleAsync();

            if (isSuccess)
            {
                await DisplayAlert("Success", "Login successful!", "OK");

                if (roleName == ("Tenant"))
                {
                    await Navigation.PushModalAsync(new TenantListBoardingHouse(_tenantService, _accountService));
                }
                else if (roleName == ("Client"))
                {
                    await Navigation.PushModalAsync(new NewsFeedPage(_clientService));
                }
                else if (roleName == null)
                {
                    await Navigation.PushModalAsync(new ChooseRoleView(_clientService, null));
                }
            }
            else
            {
                await DisplayAlert("Error", "Login failed. Please check your credentials or try again later.", "OK");
                BtnForgotPassword.IsEnabled = true;
                BtnGoToSignup.IsEnabled = true;
                BtnLogin.IsEnabled = true;
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Login failed: {ex.Message}", "OK");
        }
        finally
        {
            BtnForgotPassword.IsEnabled = true;
            BtnGoToSignup.IsEnabled = true;
            BtnLogin.IsEnabled = true;
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



