using HaBHADbMauiApp.Models.Authentication;
using System;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Services
{
    public class AccountService
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public AccountService(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        // /api/Account/Update -- Put Method
        public async Task<bool> UpdateProfileAsync(UpdateProfileDto dto)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");

            try
            {
                var response = await httpClient.PutAsJsonAsync("/api/Account/Update", dto);

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

        // /api/Account/ResetPassword -- Post Method
        public async Task<bool> ResetPassword(ResetPasswordDto model, string token)
        {
            var httpClient = _httpClientFactory.CreateClient("custom-httpclient");
            httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            try
            {
                var result = await httpClient.PostAsJsonAsync("/api/Account/UpdatePassword", model);

                if (result.IsSuccessStatusCode)
                {
                    return true;
                }
                else
                {
                    // Log the response content for debugging
                    var errorContent = await result.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error: {errorContent}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                // Log the exception for debugging
                Console.WriteLine($"Exception: {ex.Message}");
                return false;
            }
        }
    }
}
