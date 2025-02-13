using HaBHADbMauiApp.Pages.AuthenticationView;
using HaBHADbMauiApp.Pages.ClientView;
using HaBHADbMauiApp.Pages.NewUI;
using HaBHADbMauiApp.Pages.Tenant;
using HaBHADbMauiApp.Pages.TenantView;
using HaBHADbMauiApp.Pages.Client ;
using HaBHADbMauiApp.Services;
using HaBHADbMauiApp.ViewModels;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Maui.Storage;

namespace HaBHADbMauiApp
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .UseMauiMaps()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                });

            builder.Services.AddHttpClient("custom-httpclient", httpclient =>
            {
                var baseAddress = DeviceInfo.Platform == DevicePlatform.Android ? "https://habhaaa-001-site1.qtempurl.com" : "https://habhaaa-001-site1.qtempurl.com";
                httpclient.BaseAddress = new Uri(baseAddress);
                httpclient.Timeout = TimeSpan.FromMinutes(5);
            }).ConfigurePrimaryHttpMessageHandler(() =>
            {
                var platformMessageHandler = builder.Services.BuildServiceProvider().GetRequiredService<IPlatformHttpMessageHandler>();
                return platformMessageHandler.GetHttpMessageHandler();
            });

            builder.Services.AddTransient<IPlatformHttpMessageHandler, PlatformHttpMessageHandler>();
           // builder.Services.AddTransient<ClientService>();
           builder.Services.AddScoped<ClientService>();
            builder.Services.AddSingleton<LoginView>();
            builder.Services.AddSingleton<SignupView>();
            builder.Services.AddSingleton<TenantDashboard>();
            builder.Services.AddSingleton<TenantInventoryManagementView>();
           // builder.Services.AddSingleton<TenantService>();
           builder.Services.AddScoped<TenantService>();
            builder.Services.AddSingleton<ClientMakeRequestView>();
            builder.Services.AddSingleton<ClientNewsFeedView>();
            builder.Services.AddTransient<EmailService>();
            builder.Services.AddSingleton<ClientNewView>();
            builder.Services.AddSingleton<ClientNewViewModel>();
            builder.Services.AddSingleton<TenantNewView>();
            builder.Services.AddSingleton<TenantNewViewModel>();
            builder.Services.AddSingleton<ClientProfile>();

            builder.Services.AddTransient<NewPage1>();


            builder.Services.AddSingleton<TenantListBoardingHouse>();
            builder.Services.AddSingleton<TenantNotificationPage>();
            builder.Services.AddSingleton<CustomizeBoardingHousePage>();
            builder.Services.AddSingleton<AddBoardingHousePage>();
            builder.Services.AddSingleton<AddAmenitiesPage>();
            builder.Services.AddSingleton<DetailedNotificationPage>();
            builder.Services.AddSingleton<SearchByPriceRange>();
            builder.Services.AddSingleton<AddPaymentPage>();

            //Account
            builder.Services.AddSingleton<AccountEditProfileView>();
            builder.Services.AddSingleton<ResetPasswordPage>();
            builder.Services.AddSingleton<OtpPage>();
            builder.Services.AddTransient<AccountService>();

            //client
            builder.Services.AddSingleton<NewsFeedPage>();
            builder.Services.AddSingleton<ClientBoardingHouse>();
            builder.Services.AddSingleton<SearchByPriceRange>();
            builder.Services.AddSingleton<BookingDetailsPage>();
            builder.Services.AddSingleton<AddPaymentPage>();

            //tenant
            builder.Services.AddSingleton<UploadQRImagePage>();

#if DEBUG
            builder.Logging.AddDebug();
#endif

            return builder.Build();
        }

    
        public static void ConfigureServices(IServiceCollection services)
        {
            services.AddHttpContextAccessor();
   
            // Other service registrations...
        }




    }
}