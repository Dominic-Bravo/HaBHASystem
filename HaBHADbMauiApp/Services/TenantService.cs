using HaBHADbMauiApp.Models;
using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.TenantModels;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Services
{
    public class TenantService
    {
        private readonly IHttpClientFactory httpClientFactory;

        public TenantService(IHttpClientFactory httpClientFactory)
        {
            this.httpClientFactory = httpClientFactory ?? throw new ArgumentNullException(nameof(httpClientFactory));
        }

        public async Task<bool> AddOwnerBoardingHouseAsync(BoardingHouse boardingHouse, string? token)
        {
            if (boardingHouse == null)
            {
                await Shell.Current.DisplayAlert("Error", "BoardingHouse object is null.", "OK");
                return false;
            }

            if (string.IsNullOrWhiteSpace(token))
            {
                await Shell.Current.DisplayAlert("Error", "Authentication token is missing.", "OK");
                return false;
            }

            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");
            if (httpClient == null)
            {
                await Shell.Current.DisplayAlert("Error", "HttpClient could not be created.", "OK");
                return false;
            }

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.PostAsJsonAsync("/api/TenantBoardingHouse/AddTenantBoardingHouse", boardingHouse);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    var errorMessage = await response.Content.ReadAsStringAsync();
                    await Shell.Current.DisplayAlert("Error", $"Failed to add boarding house: {errorMessage}", "OK");
                    return false;
                }
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
                return false;
            }
        }

        public async Task<List<BoardingHouse>?> GetBoardingHousesAsync(string? token)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.GetAsync("/api/TenantBoardingHouse/tenantBoardingHouse");

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouses = await response.Content.ReadFromJsonAsync<List<BoardingHouse>>();
                    return boardingHouses;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        //public async Task<List<BoardinghousewTotalPriceDto>?> GetPriceRangeAsync(decimal minimumPrice, decimal maximumPrice)
        //{
        //    var httpClient = httpClientFactory.CreateClient("custom-httpclient");

        //    try
        //    {
        //        //var response = await httpClient.GetAsync("/api/TenantBoardingHouse/tenantBoardingHouse");

        //        var url = $"/api/TenantBoardingHouse/tenantBoardingHouse?minimumPrice={minimumPrice}&maximumPrice={maximumPrice}";

        //        var response = await httpClient.GetAsync(url);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            var boardingHouses = await response.Content.ReadFromJsonAsync<List<BoardinghousewTotalPriceDto>>();
        //            return boardingHouses;
        //        }
        //        else
        //        {
        //            return null;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return null;
        //    }
        //}

        public async Task<bool> AddAmenityAsync(Amenity amenity)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            if (httpClient  == null)
            {
                return false;
            }

            try
            {
                var response = await httpClient.PostAsJsonAsync("/api/TenantAmenity", amenity);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        public async Task<List<Amenity>?> GetAmenitiesAsync(int id)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.GetAsync($"api/TenantAmenity/ByBoardinghouse/{id}");

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouses = await response.Content.ReadFromJsonAsync<List<Amenity>>();

                    return boardingHouses;
                }
                else
                {
                    return null;
                }
            }   
            catch (Exception ex)
            {
                return null;
            }
        }

        public async Task<bool> DeleteAmenityAsync(int id)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.DeleteAsync($"/api/TenantAmenity/{id}");

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public async Task<bool> UpdateOwnerBoardingHouseAsync(BoardingHouse boardingHouse)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.PutAsJsonAsync("/api/TenantBoardingHouse/UpdateBoardingHouse", boardingHouse);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    var errorMessage = await response.Content.ReadAsStringAsync();
                    await Shell.Current.DisplayAlert("Error", $"Failed to update boarding house: {errorMessage}", "OK");
                    return false;
                }
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
                return false;
            }
        }


        public async Task DeleteOwnerBoardingHouseAsync(int id)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {

                var response = await httpClient.DeleteAsync($"/api/TenantBoardingHouse/{id}");

                if (response.IsSuccessStatusCode)
                {
                }
                else
                {
                }
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
            }
        }

        public async Task<bool> UploadImageAsync(string base64Image, int boardinghouseId)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            if (httpClient == null)
            {
                return false;  
            }

            try
            {
                var imageObject = new BoardingHouseImage
                {
                    BoardinghouseId = boardinghouseId,
                    ImageBase64 = base64Image,
                    Description = "Sample image description"  
                };

                var response = await httpClient.PostAsJsonAsync("/api/BoardingHouseImage/Add", imageObject);

                if (response.IsSuccessStatusCode)
                {
                    return true; 
                }
            }
            catch
            {
            }

            return false;
        }

        public async Task<List<BoardingHouseImage>?> GetImageAsync(int boardinghouseId)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.GetAsync($"/api/BoardingHouseImage/ByBoardinghouse/{boardinghouseId}");

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouseImages = await response.Content.ReadFromJsonAsync<List<BoardingHouseImage>>();

                    return boardingHouseImages;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving image: {ex.Message}");
            }

            return null; 
        }

        public async Task TenantAddLocationAsync(BoardingHouseLocation location)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.PostAsJsonAsync("/api/Locations/CreateLocation", location); 

                if (response.IsSuccessStatusCode)
                {

                }
                else
                {
                    var errorMessage = await response.Content.ReadAsStringAsync();
                    await Shell.Current.DisplayAlert("Error", $"Failed to add location: {errorMessage}", "OK");

                }
            }
            catch (HttpRequestException httpEx)
            {
                await Shell.Current.DisplayAlert("Network Error", $"A network error occurred: {httpEx.Message}", "OK");

            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"An unexpected error occurred: {ex.Message}", "OK");

            }
        }

        public async Task<bool> ApproveorRejectAsync(BookingApprovalDto dto)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.PutAsJsonAsync("/api/TenantApprove/ApproveOrReject", dto);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    var errorMessage = await response.Content.ReadAsStringAsync();
                    await Shell.Current.DisplayAlert("Error", $"Failed to update boarding house: {errorMessage}", "OK");
                    return false;
                }
            }
            catch (Exception ex)
            {
                await Shell.Current.DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
                return false;
            }
        }

        public async Task<List<Booking>?> GetPendingBookingbyTenantAsync(string token)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.GetAsync("/api/TenantApprove/PendingBookingsbytenantId");

                if (response.IsSuccessStatusCode)
                {
                    var Booking = await response.Content.ReadFromJsonAsync<List<Booking>>();

                    return Booking;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving image: {ex.Message}");
            }

            return null;
        }

        public async Task<BoardingHouse?> GetBoardingHouseByIdAsync(int id)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.GetAsync($"/api/TenantBoardingHouse/{id}");

                if (response.IsSuccessStatusCode)
                {
                    var Booking = await response.Content.ReadFromJsonAsync<BoardingHouse>();

                    return Booking;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving image: {ex.Message}");
            }

            return null;
        }

        public async Task<AppUser?> GetUserByIdAsync(string id)
        {
            var httpClient = httpClientFactory?.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.GetAsync($"/api/Account/GetUserByClientId/{id}");

                if (response.IsSuccessStatusCode)
                {
                    var Booking = await response.Content.ReadFromJsonAsync<AppUser>();

                    return Booking;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving image: {ex.Message}");
            }

            return null;
        }

        public async Task<bool> AddPaymentQrImageAsync(string base64Image, int boardinghouseId, string? token, string token1)
        {
            var httpClient = httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                if (string.IsNullOrEmpty(base64Image) || string.IsNullOrEmpty(token))
                {
                    Console.WriteLine("Error: base64Image or token is null or empty.");
                    return false;
                }

                var imageObject = new QrImage
                {
                    QrCodeImage = base64Image,
                    BoardingHouseId = boardinghouseId
                };

                var response = await httpClient.PostAsJsonAsync("/api/QrImage/create", imageObject);
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
