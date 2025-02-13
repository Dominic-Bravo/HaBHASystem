using System;
using System.Net.Mail;
using System.Threading.Tasks;
using Microsoft.Maui.Controls;

namespace HaBHADbMauiApp.Pages.AuthenticationView
{
    public partial class RecoveryView : ContentPage
    {
        public RecoveryView()
        {
            InitializeComponent();
        }

        private async void OnSendRecoveryEmailClicked(object sender, EventArgs e)
        {
            string email = EmailEntry.Text;
            string newPassword = PasswordEntry.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(newPassword))
            {
                StatusLabel.Text = "Please enter a valid email address and password.";
                return;
            }

            string verificationCode = GenerateVerificationCode();

            bool emailSent = await SendRecoveryEmailAsync(email, verificationCode, newPassword);

            if (emailSent)
            {
                Preferences.Set("VerificationCode", verificationCode); // Use Preferences instead of App.Current.Properties
                StatusLabel.Text = "Recovery email sent successfully. Please check your email for the verification code.";
                StatusLabel.TextColor = Colors.Green;
            }
            else
            {
                StatusLabel.Text = "Failed to send recovery email.";
                StatusLabel.TextColor = Colors.Red;
            }
        }

        private async Task<bool> SendRecoveryEmailAsync(string email, string verificationCode, string newPassword)
        {
            try
            {
                var mailMessage = new MailMessage("no-reply@yourapp.com", email)
                {
                    Subject = "Password Recovery",
                    Body = $"Your verification code is {verificationCode}. Use this code to reset your password to: {newPassword}"
                };

                using (var smtpClient = new SmtpClient("smtp.yourapp.com"))
                {
                    await smtpClient.SendMailAsync(mailMessage);
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private void OnVerifyCodeClicked(object sender, EventArgs e)
        {
            string enteredCode = VerificationCodeEntry.Text;
            string storedCode = Preferences.Get("VerificationCode", string.Empty); // Use Preferences instead of App.Current.Properties

            if (storedCode == enteredCode)
            {
                StatusLabel.Text = "Verification code is correct! Your email has been verified.";
                StatusLabel.TextColor = Colors.Green;
            }
            else
            {
                StatusLabel.Text = "Invalid verification code. Please try again.";
                StatusLabel.TextColor = Colors.Red;
            }
        }

        private static string GenerateVerificationCode()
        {
            var random = new Random();
            return random.Next(100000, 999999).ToString();
        }
    }
}

