using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class ResetPasswordPage : ContentPage
{
    private readonly AccountService _accountService;
    private readonly string _email;
    private readonly string _token;

    public ResetPasswordPage(AccountService accountService, string email, string token)
    {
        InitializeComponent();
        _accountService = accountService;
        _email = email;
        _token = token;
    }

    private async void BtnSubmit_Clicked(object sender, EventArgs e)
    {
        BtnSubmit.IsEnabled = false;

        try
        {
            if (TxtNewPassword.Text == TxtConfirmPassword.Text)
            {
                var newPassword = new ResetPasswordDto
                {
                    EmailAddress = _email,
                    NewPassword = TxtConfirmPassword.Text
                };

                bool isSuccess = await _accountService.ResetPassword(newPassword, _token);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Password changed successfully.", "OK");
                    await Navigation.PopModalAsync(); // Close the modal after success
                }
                else
                {
                    await DisplayAlert("Error", "Failed to change password.", "Try again?");
                }
            }
            else
            {
                await DisplayAlert("Error", "Passwords do not match.", "Try again?");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            BtnSubmit.IsEnabled = true;
        }
    }
}