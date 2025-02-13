using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class ClientBoardingHouse : ContentPage
{
	private readonly ClientService _clientService;
	public ClientBoardingHouse(ClientService clientService)
	{
		InitializeComponent();
		_clientService = clientService;
	}


}