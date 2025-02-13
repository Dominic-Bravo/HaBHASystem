using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class DetailedNotificationPage : ContentPage
{
    private readonly TenantService _tenantService;
    private Booking _booking;

	public DetailedNotificationPage(TenantService tenantService, Booking booking)
	{
		InitializeComponent();
        _tenantService = tenantService;
        _booking = booking;
        loadUserAndBooking();
    }

    private async void loadUserAndBooking()
    {
        string clientid = _booking.ClientId;

        try
        {
            var user = await _tenantService.GetUserByIdAsync(clientid);

            if (user == null)
            {
                await DisplayAlert("Error", "User not found.", "OK");
                return;
            }

            TxtFirstName.Text = user.FirstName;
            TxtContactNumber.Text = user.PhoneNumber;
            TxtEmail.Text = user.Email;
            TxtLocation.Text = user.Location;
            TxtLastName.Text = user.LastName;

            this.BindingContext = user;

            if (_booking is not null)
            {
                int id = _booking.BoardinghouseId;
                var data = await _tenantService.GetBoardingHouseByIdAsync(id);

                if (data == null)
                {
                    await DisplayAlert("Error", "Boarding house not found.", "OK");
                    return;
                }

                this.BindingContext = data;
            }
            else
            {
                await DisplayAlert("Error", "Booking is not initialized.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Failed to load user and booking: {ex.Message}", "OK");
        }
    }



    private void TestListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {

    }

    private async void BtnReject_Clicked(object sender, EventArgs e)
    {
        //int bookingId = _booking.BookingId;
        //string status = "Reject";
        //int bhId = _booking.BoardinghouseId;

        var booking = new BookingApprovalDto
        {
            BookingId = _booking.BookingId,
            ApprovalStatus = "Reject",
            ClientId = _booking.ClientId,
            BoardinghouseId = _booking.BoardinghouseId
        };

        bool isSuccess = await _tenantService.ApproveorRejectAsync(booking);

        if (isSuccess)
        {
            await DisplayAlert("Success", "Request Reject Successfully", "ok");
        }
        await DisplayAlert("error", "error", "ok");
    }

    private async void BtnApprove_Clicked(object sender, EventArgs e)
    {
        int bookingId = _booking.BookingId;
        string status = "Approved";
        int bhId = _booking.BoardinghouseId;

        var booking = new BookingApprovalDto
        {
            BookingId = bookingId,
            ApprovalStatus = status,
            ClientId = _booking.ClientId,
            BoardinghouseId = bhId
        };

        bool isSuccess = await _tenantService.ApproveorRejectAsync(booking);

        if (isSuccess)
        {
            await DisplayAlert("Success", "Approved Successfully", "ok");
            await Navigation.PopModalAsync();
        }
        //await DisplayAlert("error", "error", "ok");
    }
}