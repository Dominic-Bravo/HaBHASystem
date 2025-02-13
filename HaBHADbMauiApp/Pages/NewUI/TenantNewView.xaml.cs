using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.ViewModels;
using HaBHADbMauiApp.Pages;
using MapforMaui.MapUI;
namespace HaBHADbMauiApp.Pages.NewUI
{
    public partial class TenantNewView : ContentPage
    {
        public TenantNewView()
        {
            InitializeComponent();
            BindingContext = new TenantNewViewModel();
        }

        private async void map(object sender, EventArgs e)
        {
           //await Navigation.PushModalAsync(new TenantMap());
        }
    }
}

