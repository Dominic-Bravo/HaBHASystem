using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using HaBHADbMauiApp.Services;
using System.Collections.ObjectModel;
using System.Net.Http.Headers;
using System.Text.Json;

namespace HaBHADbMauiApp.Pages.Tenant;

public partial class CustomizeBoardingHousePage : ContentPage
{
    private readonly TenantService _tenantService;
    private BoardingHouse _boardingHouse;
    public List<BoardingHouseImage> BoardingHouseImages { get; set; }
    private string _base64Image;
    private byte[] _imageBytes;
    private readonly HttpClient _httpClient;
    private readonly AppImage _appImage;
    private ObservableCollection<AppImage> _images = new ObservableCollection<AppImage>();

    public CustomizeBoardingHousePage(TenantService tenantService, BoardingHouse boardingHouse)
    {
        InitializeComponent();
        BindingContext = this;
        _appImage = new AppImage();
        _boardingHouse = boardingHouse;
        _tenantService = tenantService;
        _httpClient = new HttpClient();
        ImageCollectionView.ItemsSource = _images;
        LoadBoardingHouse();
        LoadAmeitiesLists();
        LoadBoarders();
        LoadImages();
    }

    private async Task LoadImages()
    {
        int boardinghouseId = _boardingHouse.BoardinghouseId;

        try
        {
            var images = await _tenantService.GetBoardingHouseImageAsync(boardinghouseId);

            if (images != null && images.Count > 0)
            {
                foreach (var img in images)
                {
                    if (img.ImageData != null && img.ImageData.Length > 0)
                    {
                        img.ImageSource = ImageSource.FromStream(() => new MemoryStream(img.ImageData));
                    }
                }

                // Filter out the QR code image from the general images collection
                var generalImages = images.Where(img => !img.QRCodeImageId.HasValue).ToList();
                ImageCollectionView.ItemsSource = generalImages;
                ImageMessage.IsVisible = generalImages.Count == 0;

                // Display the first QR code image
                var qrCodeImage = images.FirstOrDefault(img => img.QRCodeImageId.HasValue);
                if (qrCodeImage != null)
                {
                    QRCodeImage.Source = qrCodeImage.ImageSource;
                    QRImageMessage.IsVisible = false;
                }
                else
                {
                    QRCodeImage.Source = null;
                    QRImageMessage.Text = "No QR code image available.";
                    QRImageMessage.IsVisible = true;
                }
            }
            else
            {
                ImageCollectionView.ItemsSource = null;
                ImageMessage.Text = "No images available.";
                ImageMessage.IsVisible = true;

                QRCodeImage.Source = null;
                QRImageMessage.Text = "No QR code image available.";
                QRImageMessage.IsVisible = true;
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
    }

    private async Task LoadBoarders()
    {
        string id = _boardingHouse.ClientId;
        var data = await _tenantService.GetUserByIdAsync(id);
        ClientDetailsStackLayout.BindingContext = data;
    }

    private async Task LoadAmeitiesLists()
    {
        int id = _boardingHouse.BoardinghouseId;
        var data = await Task.Run(() => _tenantService.GetAmenitiesAsync(id));
        AmenityListView.ItemsSource = data;
    }

    private void LoadBoardingHouse()
    {
        if (_boardingHouse is not null)
        {
            TxtRoomSize.Text = _boardingHouse.RoomSize.ToString();
            TxtRoomNumber.Text = _boardingHouse.RoomNumber.ToString();
            TxtPrice.Text = _boardingHouse.PricePerMonth.ToString();
            TxtDescription.Text = _boardingHouse.Descriptions.ToString();
        }
    }

    private async void BtUpdateBoardingHouse_Clicked(object sender, EventArgs e)
    {
        BtnAddBoardingHouse.IsEnabled = false;
        BtAddAmenities.IsEnabled = false;

        try
        {
            await Task.Delay(3000);
            await DisplayAlert("Operation Complete", "The boarding house has been updated.", "OK");
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            BtnAddBoardingHouse.IsEnabled = true;
            BtAddAmenities.IsEnabled = true;
        }
    }

    private async void BtAddMaps_Clicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.BindingContext is BoardingHouse bh)
        {
            if (bh == null)
            {
                await DisplayAlert("Error", $"An error occurred: {bh.BoardinghouseId}", "OK");
            }

            await DisplayAlert("Maps Id", $"Maps Id: {bh.BoardinghouseId}", "OK");
        }
    }

    private async void BtAddAmenities_Clicked(object sender, EventArgs e)
    {
        BtnAddBoardingHouse.IsEnabled = false;
        BtAddAmenities.IsEnabled = false;

        try
        {
            string name = await DisplayPromptAsync("Name", "Please enter the name:");
            string price = await DisplayPromptAsync("Price", "Please enter the price:");
            int id = _boardingHouse.BoardinghouseId;

            var amenity = new Amenity
            {
                BoardinghouseId = id,
                Name = name,
                Price = decimal.Parse(price)
            };

            var isSuccess = await _tenantService.AddAmenityAsync(amenity);

            if (isSuccess)
            {
                await DisplayAlert("Success", "Amenity added successfully.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            BtnAddBoardingHouse.IsEnabled = true;
            BtAddAmenities.IsEnabled = true;
        }
    }

    private async void BtnAddBoardingHouse_Clicked(object sender, EventArgs e)
    {
        try
        {
            var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

            if (string.IsNullOrWhiteSpace(token))
            {
                await Shell.Current.DisplayAlert("Error", "Authentication token is missing.", "OK");
                return;
            }

            if (string.IsNullOrWhiteSpace(TxtRoomNumber?.Text) ||
                string.IsNullOrWhiteSpace(TxtRoomSize?.Text) ||
                string.IsNullOrWhiteSpace(TxtPrice?.Text) ||
                string.IsNullOrWhiteSpace(TxtDescription?.Text))
            {
                await Shell.Current.DisplayAlert("Error", "All fields are required.", "OK");
                return;
            }

            if (_boardingHouse == null)
            {
                _boardingHouse = new BoardingHouse
                {
                    IsAvailable = true,
                    RoomNumber = int.Parse(TxtRoomNumber.Text),
                    RoomSize = int.Parse(TxtRoomSize.Text),
                    PricePerMonth = decimal.Parse(TxtPrice.Text),
                    Descriptions = TxtDescription.Text
                };

                var isSuccess = await _tenantService.AddOwnerBoardingHouseAsync(_boardingHouse, token);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Boarding house added successfully.", "OK");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to add boarding house.", "OK");
                }
            }
            else
            {
                _boardingHouse.RoomNumber = int.Parse(TxtRoomNumber.Text);
                _boardingHouse.RoomSize = int.Parse(TxtRoomSize.Text);
                _boardingHouse.PricePerMonth = decimal.Parse(TxtPrice.Text);
                _boardingHouse.Descriptions = TxtDescription.Text;

                var isSuccess = await _tenantService.UpdateOwnerBoardingHouseAsync(_boardingHouse);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Boarding house updated successfully.", "OK");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to update boarding house.", "OK");
                }
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        finally
        {
            TxtRoomNumber.Text = string.Empty;
            TxtRoomSize.Text = string.Empty;
            TxtPrice.Text = string.Empty;
            TxtDescription.Text = string.Empty;
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

    private async void BtnDelete_Clicked(object sender, EventArgs e)
    {
        try
        {
            if (_boardingHouse == null)
            {
                await DisplayAlert("Error", "No boarding house selected to delete.", "OK");
                return;
            }

            bool confirm = await DisplayAlert("Confirm Deletion", "Are you sure you want to delete this boarding house?", "Yes", "No");

            if (!confirm)
            {
                return;
            }

            int id = _boardingHouse.BoardinghouseId;
            bool isSuccess = await _tenantService.DeleteOwnerBoardingHouseAsync(id);

            if (isSuccess)
            {
                await DisplayAlert("Success", "Boarding house deleted successfully.", "OK");
                _boardingHouse = null;
                TxtRoomNumber.Text = string.Empty;
                TxtRoomSize.Text = string.Empty;
                TxtPrice.Text = string.Empty;
                TxtDescription.Text = string.Empty;
            }
            else
            {
                await DisplayAlert("Error", "Failed to delete boarding house.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
    }

    private async void AmenityListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        if (e.Item is Amenity amenity)
        {
            string formattedPrice = $"₱{amenity.Price:N2}";

            bool confirm = await DisplayAlert(
                "Confirm Deletion",
                $"Are you sure you want to delete the amenity: {amenity.Name} ({formattedPrice})?",
                "Yes",
                "No");

            if (confirm)
            {
                var isSuccess = await _tenantService.DeleteAmenityAsync(amenity.AmenityId);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Amenity successfully deleted.", "OK");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to delete the amenity.", "OK");
                }
            }
        }

        ((ListView)sender).SelectedItem = null;
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
                _imageBytes = await ReadFileAsByteArray(file);

                _base64Image = Convert.ToBase64String(_imageBytes);

                SelectedImage.IsVisible = true;
                SelectedImage.Source = ImageSource.FromStream(() => new MemoryStream(_imageBytes));

                await DisplayAlert("Success", "Image selected successfully!", "OK");
            }
        }
        catch (Exception ex)
        {
            StatusMessage.Text = $"Error picking image: {ex.Message}";
        }
    }

    private async void BoardingHouseImagesListView_ItemTapped(object sender, ItemTappedEventArgs e)
    {
        if (e.Item is BoardingHouseImage image)
        {
            bool confirm = await DisplayAlert(
                "Confirm Deletion",
                $"Are you sure you want to delete the image with ID: {image.ImageId}?",
                "Yes",
                "No");

            if (confirm)
            {
                var isSuccess = await _tenantService.DeleteAmenityAsync(image.ImageId);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Image successfully deleted.", "OK");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to delete the image.", "OK");
                }
            }
        }

        ((ListView)sender).SelectedItem = null;
    }

    private async Task UploadImageAsync(FileResult fileResult, int boardinghouseId, int? qrCodeImageId, string userId, string description)
    {
        if (fileResult == null)
        {
            await DisplayAlert("Error", "No file selected.", "OK");
            return;
        }

        try
        {
            using var fileStream = await fileResult.OpenReadAsync();
            using var content = new MultipartFormDataContent();
            var streamContent = new StreamContent(fileStream);
            streamContent.Headers.ContentType = new MediaTypeHeaderValue(fileResult.ContentType);

            // Add metadata fields
            content.Add(new StringContent(boardinghouseId.ToString()), "boardinghouseId");
            content.Add(new StringContent(qrCodeImageId?.ToString() ?? string.Empty), "qrCodeImageId");
            content.Add(new StringContent(userId), "userId");
            content.Add(new StringContent(description), "description");

            // Add image file
            content.Add(streamContent, "image", fileResult.FileName);

            using var httpClient = new HttpClient();
            var response = await httpClient.PostAsync("https://habhaaa-001-site1.qtempurl.com/api/AppImage/AddImages", content);

            if (response.IsSuccessStatusCode)
            {
                await DisplayAlert("Success", "Image uploaded successfully!", "OK");
            }
            else
            {
                string errorMessage = await response.Content.ReadAsStringAsync();
                await DisplayAlert("Error", $"Failed to upload image: {errorMessage}", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
    }

    private async void OnUploadImage_Clicked(object sender, EventArgs e)
    {
        var appImage = new AppImage
        {
            Description = "Sample image description",
            ImageData = _imageBytes,
            BoardinghouseId = _boardingHouse.BoardinghouseId,
            QRCodeImageId = null,
            UserId = null
        };
        // Tenant service
        bool uploadSuccessful = await _tenantService.UploadWithJsonImageAsync(appImage, _imageBytes);

        if (uploadSuccessful)
        {
            Console.WriteLine("Image uploaded successfully!");
        }
        else
        {
            Console.WriteLine("Failed to upload image.");
        }
    }

    private async void UploadQRCode_Clicked(object sender, EventArgs e)
    {
        if (!SelectedImage.IsVisible)
        {
            StatusMessage.Text = "Please select an image first.";
            return;
        }

        if (string.IsNullOrEmpty(_base64Image))
        {
            StatusMessage.Text = "No image selected.";
            return;
        }

        var appImage = new AppImage
        {
            Description = "QR code image",
            ImageData = _imageBytes,
            BoardinghouseId = _boardingHouse.BoardinghouseId,
            QRCodeImageId = _boardingHouse.BoardinghouseId, // Assuming QRCodeImageId is the same as BoardinghouseId for simplicity
            UserId = _boardingHouse.TenantId
        };

        // Tenant service
        bool uploadSuccessful = await _tenantService.UploadWithJsonImageAsync(appImage, _imageBytes);

        if (uploadSuccessful)
        {
            Console.WriteLine("QR code image uploaded successfully!");
            await DisplayAlert("Success", "QR code image uploaded successfully!", "OK");

            // Retrieve and display the uploaded QR code image
            await LoadImages();
        }
        else
        {
            Console.WriteLine("Failed to upload QR code image.");
            await DisplayAlert("Error", "Failed to upload QR code image.", "OK");
        }
    }
}