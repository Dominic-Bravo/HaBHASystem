using System.Net.Http.Headers;

namespace HaBHADbMauiApp;

public partial class NewPage1 : ContentPage
{
	public NewPage1()
	{
		InitializeComponent();
	}

    private async void OnUploadButton_Clicked(object sender, EventArgs e)
    {
        var fileResult = await FilePicker.Default.PickAsync(new PickOptions
        {
            PickerTitle = "Select an image",
            FileTypes = FilePickerFileType.Images
        });

        //if (fileResult != null)
        //{
        //    await _ownerBoardingHouseService.NewUploadImageAsync(fileResult);
        //}

        if (fileResult != null)
        {
            await UploadImageAsync(fileResult);
        }
    }

    private async void OnFetchImageButton_Clicked(object sender, EventArgs e)
    {
        int imageId = 2;
        var imageSource = await GetImageAsync(imageId);

        if (imageSource != null)
        {
            MyImageControl.Source = imageSource;
        }
    }

    private async Task<ImageSource> GetImageAsync(int imageId)
    {
        using var httpClient = new HttpClient();
        var response = await httpClient.GetAsync($"https://habhaaa-001-site1.qtempurl.com//api/Values/Image/{imageId}");

        if (response.IsSuccessStatusCode)
        {
            var imageBytes = await response.Content.ReadAsByteArrayAsync();
            return ImageSource.FromStream(() => new MemoryStream(imageBytes));
        }

        await DisplayAlert("Error", "Failed to load image.", "OK");
        return null;
    }

    private async Task UploadImageAsync(FileResult fileResult)
    {
        if (fileResult == null)
            return;

        using var fileStream = await fileResult.OpenReadAsync();
        using var content = new MultipartFormDataContent();
        var streamContent = new StreamContent(fileStream);

        streamContent.Headers.ContentType = new MediaTypeHeaderValue(fileResult.ContentType);
        content.Add(streamContent, "file", fileResult.FileName);

        using var httpClient = new HttpClient();
        var response = await httpClient.PostAsync("https://habhaaa-001-site1.qtempurl.com/api/Values/NewImageuploadwithBoardinghouse", content);

        if (response.IsSuccessStatusCode)
        {
            var responseContent = await response.Content.ReadAsStringAsync();
            await DisplayAlert("Success", "Image uploaded successfully!", "OK");
        }
        else
        {
            await DisplayAlert("Error", "Failed to upload image.", "OK");
        }
    }
}