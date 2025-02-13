using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.ViewModels;
using HaBHADbMauiApp.Pages;
using MapforMaui.MapUI;

namespace HaBHADbMauiApp.Pages.NewUI;

public partial class ClientNewView : ContentPage
{
	public ClientNewView()
	{
		InitializeComponent();
        BindingContext = new ClientNewViewModel();
    }

    private async void ImageButton_Clicked(object sender, EventArgs e)
    {
        //await Navigation.PushModalAsync(new TenantMap());
    }

    private async void Button_Clicked(object sender, EventArgs e)
    {
        await Navigation.PushModalAsync(new bookView());
    }
}