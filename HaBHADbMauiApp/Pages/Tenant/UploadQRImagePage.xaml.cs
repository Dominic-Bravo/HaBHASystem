using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Services;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Client;

public partial class UploadQRImagePage : ContentPage
{
    private readonly TenantService _tenantService;
    private string _base64Image;
    public UploadQRImagePage(TenantService tenantService)
	{
		InitializeComponent();
        _tenantService = tenantService;
	}

    private async void OnPickImage_Clicked(object sender, EventArgs e)
    {
        try
        {
            var file = await MediaPicker.PickPhotoAsync(new MediaPickerOptions
            {
                Title = "Pick an image"
            });

            if (file != null)
            {
                var imageBytes = await ReadFileAsByteArray(file);

                _base64Image = Convert.ToBase64String(imageBytes);

                SelectedImage.IsVisible = true;
                SelectedImage.Source = ImageSource.FromStream(() => new MemoryStream(imageBytes));

                StatusMessage.Text = "Image selected successfully!";
            }
        }
        catch (Exception ex)
        {
            StatusMessage.Text = $"Error picking image: {ex.Message}";
        }
    }

    private async Task<byte[]> ReadFileAsByteArray(FileResult file)
    {
        using (var stream = await file.OpenReadAsync())
        {
            using (var memoryStream = new MemoryStream())
            {
                await stream.CopyToAsync(memoryStream);
                return memoryStream.ToArray();
            }
        }
    }

    private async Task<(string Token, string RoleName)> GetAuthenticationTokenAndRoleAsync()
    {
        try
        {
            var serializedResponse = await SecureStorage.Default.GetAsync("Authentication");

            if (!string.IsNullOrEmpty(serializedResponse))
            {
                var loginResponse = JsonSerializer.Deserialize<LoginResponse>(serializedResponse);

                if (loginResponse != null)
                {
                    return (loginResponse.Token, loginResponse.RoleName);
                }
            }

            return (string.Empty, string.Empty);
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Failed to retrieve authentication data: {ex.Message}", "OK");
            return (string.Empty, string.Empty);
        }
    }

    //private async void OnUploadImage_Clicked(object sender, EventArgs e)
    //{
    //    int BhId = 3;
    //    var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

    //    if (SelectedImage.IsVisible)
    //    {

    //        if (!string.IsNullOrEmpty(_base64Image))
    //        {
    //            bool isSuccess = await _tenantService.AddPaymentQrImageAsync(_base64Image, BhId, token );

    //            if (isSuccess)
    //            {
    //                StatusMessage.Text = "Image Uploaded Successfully.";
    //            }
    //        }
    //        else
    //        {
    //            StatusMessage.Text = "No image selected.";
    //        }
    //    }
    //    else
    //    {
    //        StatusMessage.Text = "Please select an image first.";
    //    }

    //}
}