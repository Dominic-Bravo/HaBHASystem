
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.AuthenticationView;

public partial class AccountEditProfileView : ContentPage
{
	private readonly AccountService _accountService;
	private readonly UpdateProfileDto _updateProfile;
	public AccountEditProfileView(AccountService accountService)
	{
		InitializeComponent();
		_accountService = accountService;
		//_updateProfile = updateProfileDto;

		LoadUserProfile();
	}

	private void LoadUserProfile()
	{
		if (_updateProfile is not null)
		{
            TxtAddress.Text = _updateProfile.Location;
            TxtEmailAddress.Text = _updateProfile.EmailAddress;
            TxtFirstName.Text = _updateProfile.FirstName;
            TxtLastName.Text = _updateProfile.LastName;
            TxtMobileNumber.Text = _updateProfile.ContactNumber;
        }
	}

    private async void BtnCancel_Clicked(object sender, EventArgs e)
    {
		BtnCancel.IsEnabled = false;
		try
		{
            await Navigation.PopAsync();
        }
		catch
		{

		}
		finally
		{
            BtnCancel.IsEnabled = false;
        }
    }

    private void BtnSaveProfile_Clicked(object sender, EventArgs e)
    {
		BtnSaveProfile.IsEnabled = false;
		try
		{
			var profile = new UpdateProfileDto
			{
				
				ContactNumber = TxtMobileNumber.Text.ToString(),
				FirstName = TxtFirstName.Text.ToString(),
				LastName = TxtLastName.Text.ToString(),
				Location = TxtAddress.Text.ToString(),
				EmailAddress = TxtEmailAddress.Text.ToString()
			};
		}
		catch
		{

		}
		finally
		{
			BtnSaveProfile.IsEnabled = true;
		}
    }
}