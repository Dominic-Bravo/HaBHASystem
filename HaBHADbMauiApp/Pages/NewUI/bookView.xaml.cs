using Microsoft.Maui.ApplicationModel.Communication;
using Microsoft.Maui.Controls;
using System;

namespace HaBHADbMauiApp.Pages.NewUI
{
    public partial class bookView : ContentPage
    {
        public bookView()
        {
            InitializeComponent();
        }

        private void OnSubmitClicked(object sender, EventArgs e)
        {
            string fullName = FullNameEntry.Text;
            string email = EmailEntry.Text;
            string phoneNumber = PhoneNumberEntry.Text;
            DateTime date = DatePicker.Date;
            string notes = NotesEditor.Text;
            string emergencycontact = PhoneNumberEntry.Text;
            DisplayAlert("Booking Confirmed", $"Name: {fullName}\nEmail: {email}\nPhone: {phoneNumber}\nDate: {date.ToShortDateString()}\nTime: ", "OK");
        }
    }
}
