using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;
using System.Net.Mail;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class OtpPage : ContentPage
{
    private readonly string _generatedCode;
    private readonly AccountService _accountService;

    public OtpPage(string generateCode, AccountService accountService)
    {
        InitializeComponent();
        _generatedCode = generateCode;
        _accountService = accountService;
    }

    private async void BtnSubmit_Clicked(object sender, EventArgs e)
    {
        if (TxtOtp.Text == _generatedCode)
        {
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

            if (string.IsNullOrEmpty(token))
            {
                await DisplayAlert("Error", "Token is null or empty.", "OK");
                return;
            }

            await DisplayAlert("Success", "The codes match!", "OK");
            await Navigation.PushModalAsync(new ResetPasswordPage(_accountService, EmailOTP.Text, token));
        }
        else
        {
            await DisplayAlert("Error", "The codes do not match. Try again.", "OK");
        }
    }

    private void OTPtoemail_Clicked(object sender, EventArgs e)
    {
        try
        {
            MailMessage mail = new MailMessage();
            SmtpClient smtp = new SmtpClient("smtp.gmail.com");

            mail.From = new MailAddress("habha2025@gmail.com");
            mail.To.Add(EmailOTP.Text); // Add recipient email address

            mail.Subject = "THIS IS YOUR OTP";
            mail.Body = $"YOUR OTP CODE IS : {_generatedCode}";

            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("habha2025@gmail.com", "tdob damr iieg fxep");
            smtp.EnableSsl = true;

            smtp.Send(mail);

            DisplayAlert("Success", "Email sent successfully.", "OK");
        }
        catch (Exception ex)
        {
            DisplayAlert("Error", $"Failed to send email: {ex.Message}", "OK");
        }
    }
}
