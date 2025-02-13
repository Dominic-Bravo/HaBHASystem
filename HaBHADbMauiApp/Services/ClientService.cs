using HaBHADbMauiApp.Models.Authentication;
using HaBHADbMauiApp.Models.ClientModels;
using HaBHADbMauiApp.Models.Dto;
using System.Net.Http.Headers;
using System.Text.Json;
using Microsoft.Extensions.Logging;
using System.Net.Http.Json;
using HaBHADbMauiApp.Models;
using System.Net.Http;
using HaBHADbMauiApp.Models.TenantModels;

namespace HaBHADbMauiApp.Services
{
    public class ClientService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ILogger<ClientService> _logger;

        public ClientService(IHttpClientFactory httpClientFactory, ILogger<ClientService> logger)
        {
            _httpClientFactory = httpClientFactory;
            _logger = logger;
        }

        public async Task Register(RegisterModel model)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var result = await httpClient.PostAsJsonAsync("/api/Account/register", model);

                if (result.IsSuccessStatusCode)
                {
                    _logger.LogInformation("Successfully registered.");
                }
                else
                {
                    var errorResponse = await result.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to register: {errorResponse}");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unexpected error occurred during registration.");
            }
        }


        public async Task<bool> Login(LoginModel model)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var result = await httpClient.PostAsJsonAsync("/api/Account/login", model);

                if (result.IsSuccessStatusCode)
                {
                    var response = await result.Content.ReadFromJsonAsync<LoginResponse>();

                    if (response is not null)
                    {
                        var serializeResponse = JsonSerializer.Serialize(
                            new LoginResponse
                            {
                                Token = response.Token,
                                UserName = model.Email,
                                RoleName = response.RoleName
                            });

                        await SecureStorage.Default.SetAsync("Authentication", serializeResponse);

                        return true;
                    }
                }
            }
            catch
            {

            }
            return false;
        }


        public async Task AsignRoles(UserRole userRole, string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {

                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var result = await httpClient.PostAsJsonAsync("/api/Account/AssignRole", userRole);
                if (result.IsSuccessStatusCode)
                {
                    _logger.LogInformation("Successfully assigned role.");
                }
                else
                {
                    var errorResponse = await result.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to assign role: {errorResponse}");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unexpected error occurred while assigning role.");
            }
        }

        public async Task ClientAddRequestAsync(MakeRequestDto dto, string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.PostAsJsonAsync("/api/ClientAddBookingRequest/MakeRequest", dto);
                if (response.IsSuccessStatusCode)
                {
                    _logger.LogInformation("Request successfully added.");
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to add request: {errorResponse}");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while adding request.");
            }
        }

        public async Task<List<BoardingHouseWithImageDto>?> GetAvailableBoardingHousesAsync(string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.GetAsync("/api/NewsFeedQuery/availableBoardinghouse");

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouses = await response.Content.ReadFromJsonAsync<List<BoardingHouseWithImageDto>>();
                    return boardingHouses;
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to get available boarding houses: {errorResponse}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while getting available boarding houses.");
                return null;
            }
        }



        public async Task<List<BoardingHouseLocation>?> GetLocationsAsync()
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {

                var response = await httpClient.GetAsync("/api/Locations/GetAllLocations"); 

                if (response.IsSuccessStatusCode)
                {
                    var locations = await response.Content.ReadFromJsonAsync<List<BoardingHouseLocation>>();
                    return locations;
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to get available boarding houses: {errorResponse}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while getting available boarding houses.");
                return null;
            }
        }

        public async Task<bool> AddBookingAsync(Booking dto, string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.PostAsJsonAsync("/api/Booking", dto);
                if (response.IsSuccessStatusCode)
                {
                    _logger.LogInformation("Request successfully added.");
                    return true;
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to add request: {errorResponse}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while adding request.");
                return false;
            }
        }


        public async Task<List<BoardinghousewTotalPriceDto>?> GetAvailableBHWithPriceAsync(string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.GetAsync("/api/TenantBoardingHouse/available");

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouses = await response.Content.ReadFromJsonAsync<List<BoardinghousewTotalPriceDto>>();
                    return boardingHouses;
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Failed to get available boarding houses: {errorResponse}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while getting available boarding houses.");
                return null;
            }
        }

        //public async Task<bool> AddBookingAsync(Booking dto, string token)
        //{
        //    var httpClient = httpClientFactory.CreateClient("custom-httpclient");

        //    try
        //    {
        //        httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

        //        var response = await httpClient.PutAsJsonAsync("/api/Booking", dto);

        //        if (response.IsSuccessStatusCode)
        //        {
        //            return true;
        //        }
        //        else
        //        {
        //            var errorMessage = await response.Content.ReadAsStringAsync();
        //            await Shell.Current.DisplayAlert("Error", $"Failed to update boarding house: {errorMessage}", "OK");
        //            return false;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        await Shell.Current.DisplayAlert("Error", $"An error occurred: {ex.Message}", "OK");
        //        return false;
        //    }
        //}

        public async Task<List<BoardinghousewTotalPriceDto>?> GetPriceRangeAsync(decimal minimumPrice, decimal maximumPrice)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var url = $"/api/TenantBoardingHouse/MinMaxPrice?minimumPrice={minimumPrice}&maximumPrice={maximumPrice}";

                var response = await httpClient.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    var boardingHouses = await response.Content.ReadFromJsonAsync<List<BoardinghousewTotalPriceDto>>();
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

        public async Task<AppUser?> GetUserByIdAsync(string token)
        {
            var httpClient = _httpClientFactory?.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var response = await httpClient.GetAsync("/api/Account/GetUserByTenantId");

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

        public async Task<bool> AddPaymentQrImageAsync(string base64Image, int boardinghouseId, string tenantId, string token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                var imageObject = new QrImage
                {
                    QrCodeImage = base64Image,
                    BoardingHouseId = boardinghouseId,
                    TenantId = tenantId
                };

                var response = await httpClient.PostAsJsonAsync("/api/QrImage/create", imageObject);
                return response.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while uploading QR code image.");
                return false;
            }
        }

        public async Task<List<BoardingHouse>?> GetBoardingHousesAsync(string? token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

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
    }
}



