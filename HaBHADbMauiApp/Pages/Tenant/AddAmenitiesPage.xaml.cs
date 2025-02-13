using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class AddAmenitiesPage : ContentPage
{
	private readonly TenantService _tenantService;
	private readonly BoardingHouse _boardingHouse;
	public AddAmenitiesPage(TenantService tenantService, BoardingHouse boardingHouse)
	{
		InitializeComponent();
		_boardingHouse = boardingHouse;
		_tenantService = tenantService;
	}

    private void BtUpdateBoardingHous_Clicked(object sender, EventArgs e)
    {

    }
}