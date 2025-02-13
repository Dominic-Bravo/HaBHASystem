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
        //LoadImagesAsync();
        LoadBoarders();
    }

    private async void OnLoadImagesClicked(object sender, EventArgs e)
    {
        int boardinghouseId = _boardingHouse.BoardinghouseId;

        if (boardinghouseId == 0)
        {
            await DisplayAlert("Error", "Invalid Boardinghouse ID.", "OK");
            return;
        }

        try
        {
            string apiUrl = $"https://habhaaa-001-site1.qtempurl.com/api/AppImage/GetImagesByBoardinghouseId/{boardinghouseId}";
            HttpResponseMessage response = await _httpClient.GetAsync(apiUrl);

            if (!response.IsSuccessStatusCode)
            {
                await DisplayAlert("Error", "Failed to fetch images.", "OK");
                return;
            }

            string jsonResult = await response.Content.ReadAsStringAsync();
            var images = JsonSerializer.Deserialize<List<AppImage>>(jsonResult, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

            _images.Clear();
            foreach (var img in images)
            {
                img.ImageSource = ImageSource.FromStream(() => new MemoryStream(img.ImageData)); 
                _images.Add(img);
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
        var data = await Task.Run(() => _tenantService.GetUserByIdAsync(id));

        this.BindingContext = data;
    }

    //private async Task LoadImagesAsync()
    //{
    //    int id = _boardingHouse.BoardinghouseId;

    //    var data = await _tenantService.GetImageAsync(id);

    //    if (data != null)
    //    {
    //        foreach (var image in data)
    //        {
    //            if (!string.IsNullOrEmpty(image.ImageBase64))
    //            {
    //                byte[] imageBytes = Convert.FromBase64String(image.ImageBase64);

    //                image.ImageSource = ImageSource.FromStream(() =>
    //                {
    //                    var stream = new MemoryStream(imageBytes);
    //                    return stream;
    //                });
    //            }
    //        }

    //        BoardingHouseImages = data;
    //        BoardingHouseImagesCollectionView.ItemsSource = BoardingHouseImages;
    //    }
    //    else
    //    {
    //        StatusMessage.Text = "No images found.";
    //    }
    //}

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
            TxtRoomSize.Text = _boardingHouse.RoomSize.ToString(); // RoomSize    
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

            if (_boardingHouse is null)
            {
                var boardingHouse = new BoardingHouse
                {
                    IsAvailable = true,
                    RoomNumber = int.Parse(TxtRoomNumber.Text),
                    RoomSize = int.Parse(TxtRoomSize.Text),
                    PricePerMonth = decimal.Parse(TxtPrice.Text),
                    Descriptions = TxtDescription.Text
                };

                var isSuccess = await _tenantService.AddOwnerBoardingHouseAsync(boardingHouse, token);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Boarding house added successfully.", "OK");
                }
            }
            else
            {
                var boardingHouse = new BoardingHouse
                {
                    TenantId = _boardingHouse.TenantId,
                    ClientId = _boardingHouse.ClientId,
                    RoomNumber = int.Parse(TxtRoomNumber.Text),
                    RoomSize = int.Parse(TxtRoomSize.Text),
                    PricePerMonth = decimal.Parse(TxtPrice.Text),
                    Descriptions = TxtDescription.Text
                };

                var isSuccess = await _tenantService.UpdateOwnerBoardingHouseAsync(boardingHouse);

                if (isSuccess)
                {
                    await DisplayAlert("Success", "Boarding house updated successfully.", "OK");
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
        int id = _boardingHouse.BoardinghouseId;

        await _tenantService.DeleteOwnerBoardingHouseAsync(id);
        await DisplayAlert("Success", "Boarding house deleted successfully.", "OK");
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
        try
        {
            if (_imageBytes == null || _imageBytes.Length == 0)
            {
                await DisplayAlert("Error", "No image selected. Please pick an image first.", "OK");
                return;
            }

            //int boardinghouseId = _boardingHouse?.BoardinghouseId ?? 0;
            //int? qrCodeImageId = null; // Modify if needed
            //string userId = null; // Set to actual UserId
            //string description = "Your image description"; // Modify accordingly

            var appImage = new AppImage
            {
                BoardinghouseId = _boardingHouse?.BoardinghouseId,
                QRCodeImageId = null,
                UserId = null, // Set to null
                Description = "new",
                ImageData = _imageBytes
            };

            await DisplayAlert("Title", $"boardid {_boardingHouse.BoardinghouseId}", "Ok");

            using (var content = new MultipartFormDataContent())
            {
                // Add metadata
                //content.Add(new StringContent(boardinghouseId.ToString()), "boardinghouseId");
                //content.Add(new StringContent(qrCodeImageId?.ToString() ?? string.Empty), "qrCodeImageId");
                //content.Add(new StringContent(userId), "userId");
                //content.Add(new StringContent(description), "description");

                if (_boardingHouse?.BoardinghouseId > 0) 
                    content.Add(new StringContent(_boardingHouse.BoardinghouseId.ToString()), "boardinghouseId");

                if (appImage.QRCodeImageId.HasValue)
                    content.Add(new StringContent(appImage.QRCodeImageId.Value.ToString()), "qrCodeImageId");

                if (!string.IsNullOrEmpty(appImage.Description))
                    content.Add(new StringContent(appImage.Description), "description");

                // Add the image file
                var fileContent = new ByteArrayContent(_imageBytes);
                fileContent.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg"); // Adjust based on image type
                content.Add(fileContent, "image", "upload.jpg"); // Change filename if needed

                // Send the request
                using var httpClient = new HttpClient();
                var response = await httpClient.PostAsync("https://habhaaa-001-site1.qtempurl.com/api/AppImage/AddImages", content);

                string responseContent = await response.Content.ReadAsStringAsync();

                if (response.IsSuccessStatusCode)
                {
                    await DisplayAlert("Success", $"Image uploaded successfully! Server Response: {responseContent}", "OK");
                }
                else
                {
                    await DisplayAlert("Error", $"Upload failed! Status: {response.StatusCode}, Message: {responseContent}", "OK");
                }
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        }
        //try
        //{
        //    // Assuming you already have _boardingHouse and _imageBytes
        //    //int id = _boardingHouse.BoardinghouseId;  // BoardinghouseId from the selected boarding house
        //    //var imageByteArray = _imageBytes;         // Image byte array from the selected image

        //    var appImage = new AppImage
        //    {
        //        BoardinghouseId = _boardingHouse.BoardinghouseId,  
        //        QRCodeImageId = null, 
        //        UserId = "", 
        //        Description = "", 
        //        ImageData = _imageBytes 
        //    };

        //    int boardinghouseId = appImage.BoardinghouseId ?? 0; 
        //    byte[] imageByteArray = _imageBytes; 
        //    string userId = appImage.UserId;
        //    string description = appImage.Description;

        //    if (imageByteArray == null || imageByteArray.Length == 0)
        //    {
        //        await DisplayAlert("Error", "No image selected.", "OK");
        //        return;
        //    }

        //    using (var content = new MultipartFormDataContent())
        //    {
        //        // Ensure you're using the correct variables here
        //        //content.Add(new StringContent(appImage.BoardinghouseId?.ToString() ?? string.Empty), "boardinghouseId");
        //        //content.Add(new StringContent(appImage.QRCodeImageId?.ToString() ?? string.Empty), "qrCodeImageId");
        //        //content.Add(new StringContent(appImage.UserId), "userId");
        //        //content.Add(new StringContent(appImage.Description), "description");
        //        content.Add(new StringContent(boardinghouseId.ToString()), "boardinghouseId");
        //        content.Add(new StringContent(appImage.QRCodeImageId?.ToString() ?? string.Empty), "qrCodeImageId");
        //        content.Add(new StringContent(userId), "userId");
        //        content.Add(new StringContent(description), "description");

        //        // Prepare the image byte array for uploading
        //        var fileContent = new ByteArrayContent(imageByteArray);
        //        fileContent.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");  // Adjust the content type based on your image format
        //        content.Add(fileContent, "image", "image.jpg");  // Adjust filename if needed

        //        // Make the POST request to the API
        //        var response = await _httpClient.PostAsync("https://habhaaa-001-site1.qtempurl.com/api/AppImage/AddImages", content);

        //        // Handle the response from the server
        //        if (response.IsSuccessStatusCode)
        //        {
        //            await DisplayAlert("Success", "Image uploaded successfully!", "OK");
        //        }
        //        else
        //        {
        //            await DisplayAlert("Error", "Image upload failed.", "OK");
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    // Handle exceptions
        //    await DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        //}
    }


    //private async void OnUploadImage_Clicked(object sender, EventArgs e)
    //{
    //    int id = _boardingHouse.BoardinghouseId;

    //    using (var content = new MultipartFormDataContent())
    //    {
    //        content.Add(new StringContent(boardinghouseId.ToString()), "boardinghouseId");
    //        content.Add(new StringContent(qrCodeImageId.ToString()), "qrCodeImageId");
    //        content.Add(new StringContent(userId), "userId");
    //        content.Add(new StringContent(description), "description");

    //        var fileContent = new ByteArrayContent(imageByteArray);
    //        fileContent.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");     
    //        content.Add(fileContent, "image", "image.jpg");

    //        var response = await _httpClient.PostAsync("https://yourapi.com/api/AddImages", content);
    //        // Handle response
    //    }


    //    //if (SelectedImage.IsVisible)
    //    //{
    //    //    if (!string.IsNullOrEmpty(_base64Image))
    //    //    {
    //    //        await _tenantService.UploadImageAsync(_base64Image, id);
    //    //        await DisplayAlert("Success", "Image uploaded successfully!", "OK");
    //    //    }
    //    //    else
    //    //    {
    //    //        StatusMessage.Text = "No image selected.";
    //    //    }
    //    //}
    //    //else
    //    //{
    //    //    StatusMessage.Text = "Please select an image first.";
    //    //}
    //}

    private async void UploadQRCode_Clicked(object sender, EventArgs e)
    {
        int id = _boardingHouse.BoardinghouseId;

        var (token, roleName) = await GetAuthenticationTokenAndRoleAsync();

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

        bool isSuccess = await _tenantService.AddPaymentQrImageAsync(_base64Image, id, _boardingHouse.TenantId, token);

        if (isSuccess)
        {
            await DisplayAlert("Success", "QR code image uploaded successfully!", "OK");
        }
        else
        {
            await DisplayAlert("Error", "Failed to upload QR code image.", "OK");
        }
        
    }
   

}
