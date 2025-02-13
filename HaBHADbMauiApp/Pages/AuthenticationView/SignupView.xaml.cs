using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class SignupView : ContentPage
{
    private readonly ClientService _clientService;
    private readonly TenantService _tenantService;
    private readonly AccountService _accountService;

    public SignupView(ClientService clientService,AccountService accountService, TenantService tenantService)
    {
        InitializeComponent();
        _tenantService = tenantService;
        _clientService = clientService;
        _accountService = accountService;
    }

    private async void BtnRegisterButton_Clicked(object sender, EventArgs e)
    {
        if (ValidateEntries())
        {
            string email = TxtEmailAddress.Text;
            string fName = TxtFirstName.Text;
            string lName = TxtLastName.Text;
            string location = TxtLocation.Text;
            string contactNumber = TxtPhoneNumber.Text;
            string confirmPassword = TxtConfirmPassword.Text;
            string password = TxtPassword.Text;

            try
            {
                if (password == confirmPassword)
                {
                    var model = new RegisterModel
                    {
                        FirstName = fName,
                        LastName = lName,
                        Location = location,
                        ContactNumber = contactNumber,
                        Email = email,
                        Password = password
                    };



                    await _clientService.Register(model);
                    await DisplayAlert("Success", "Registration successful!", "OK");
                    await Navigation.PushModalAsync(new LoginView(_clientService, _accountService, _tenantService));
                }
                else
                {
                    await DisplayAlert("Error", "Passwords do not match", "OK");
                }
            }
            catch
            {
                await DisplayAlert("Error", "Failed to register", "OK");
            }
        }
    }


    private bool ValidateEntries()
    {
        if (string.IsNullOrEmpty(TxtFirstName.Text))
        {
            DisplayAlert("Validation Error", "First Name is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtLastName.Text))
        {
            DisplayAlert("Validation Error", "Last Name is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtEmailAddress.Text) || !IsValidEmail(TxtEmailAddress.Text))
        {
            DisplayAlert("Validation Error", "A valid Email Address is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtPhoneNumber.Text))
        {
            DisplayAlert("Validation Error", "Contact Number is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtLocation.Text))
        {
            DisplayAlert("Validation Error", "Location is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtPassword.Text))
        {
            DisplayAlert("Validation Error", "Password is required.", "OK");
            return false;
        }

        if (string.IsNullOrEmpty(TxtConfirmPassword.Text))
        {
            DisplayAlert("Validation Error", "Confirm Password is required.", "OK");
            return false;
        }

        return true;
    }

    private bool IsValidEmail(string email)
    {
        try
        {
            var mailAddress = new System.Net.Mail.MailAddress(email);
            return true;
        }
        catch
        {
            return false;
        }
    }

    private async void BtnLoginButton_Clicked(object sender, EventArgs e)
    {
        await Navigation.PopModalAsync();
    }
}
