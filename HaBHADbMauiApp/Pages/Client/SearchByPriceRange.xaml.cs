using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Services;

namespace HaBHADbMauiApp.Pages.Client;

public partial class SearchByPriceRange : ContentPage
{
    private readonly ClientService _clientService;
	public SearchByPriceRange(ClientService clientService)
	{
		InitializeComponent();
        _clientService = clientService;
        LoadAvailableBoardingHouseAsync();
    }

    private async void QueSearch_Clicked(object sender, EventArgs e)
    {
        var MinPrice = InpMinPrice.SelectedItem as string;
        var MaxPrice = InpMaxPrice.SelectedItem as string;

        if (!string.IsNullOrEmpty(MinPrice) || !string.IsNullOrEmpty(MaxPrice))
        {
            await DisplayAlert("Selected Items", $"Min Price: {MinPrice ?? "None"}\nMax Price: {MaxPrice ?? "None"}", "OK");
            var data = await Task.Run(() => _clientService.GetPriceRangeAsync(decimal.Parse(MinPrice), decimal.Parse(MaxPrice)));

            TestListView.ItemsSource = data;
        }
        else
        {
            await DisplayAlert("No Selection", "Please select an option from the dropdown.", "OK");
        }
    }

    private async Task LoadAvailableBoardingHouseAsync()
    {
        var MinPrice = InpMinPrice.SelectedItem as string;
        var MaxPrice = InpMaxPrice.SelectedItem as string;

        var data = await Task.Run(() => _clientService.GetPriceRangeAsync(decimal.Parse(MinPrice), decimal.Parse(MaxPrice)));

        TestListView.ItemsSource = data;
    }

    private async void TestListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        if (e.Item is BoardinghousewTotalPriceDto bh)
        {
            await DisplayAlert("Selection", $"Please select an option {bh.BoardinghouseId}.", "OK");
        }
    }
}