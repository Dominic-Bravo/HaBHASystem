using HaBHADbMauiApp.Pages.AuthenticationView;
using HaBHADbMauiApp.Pages.Client;
using HaBHADbMauiApp.Pages.NewUI;
using HaBHADbMauiApp.Pages.Tenant;
using HaBHADbMauiApp.Pages.TenantView;

namespace HaBHADbMauiApp
{
    public partial class App : Application
    {
        public App(LoginView vm) 
        {
            InitializeComponent();

            MainPage = vm;

        }
    }
}
