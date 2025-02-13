using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;


namespace HaBHADbMauiApp.Pages.NewUI
{
    public class ClientNewViewModel : BindableObject
    {
        public ObservableCollection<Listing> Listings { get; set; }
        public ICommand AddNewListingCommand { get; }



                    public ClientNewViewModel() { 
                    Listings = new ObservableCollection<Listing>
                        {
                            new Listing
                            {
                                Images = new ObservableCollection<ImageModel>
                                {
                                    new ImageModel { ImageUrl = "dotnet_bot.png" },
                                    new ImageModel { ImageUrl = "facebool_logo.png" },
                                    new ImageModel { ImageUrl = "habha_logo.png" },
                                    new ImageModel { ImageUrl = "profile.png" },
                                    new ImageModel { ImageUrl = "dotnet_bot.png" },
                                    // Add more images as needed
                                },
                                Title = "Boarding House 1",
                                Amenities = "Wi-Fi, Laundry, Kitchen",
                                Price = "$500"
                            },
                            new Listing
                            {
                                Images = new ObservableCollection<ImageModel>
                                {
                                    new ImageModel { ImageUrl = "dotnet_bot.png" },
                                    new ImageModel { ImageUrl = "dotnet_bot.png" },
                                    // Add more images as needed
                                },
                                Title = "Boarding House 2",
                                Amenities = "Wi-Fi, Laundry, Kitchen",
                                Price = "$600"
                            }
                        };

            AddNewListingCommand = new Command(AddNewListing);
                    }

                    private void AddNewListing()
            {
                Listings.Add(new Listing
                {
                    Images = new ObservableCollection<ImageModel>
                            {
                                new ImageModel { ImageUrl = "dotnet_bot.png" },
                                new ImageModel { ImageUrl = "dotnet_bot.png" },
                                // Add more images as needed
                            },
                    Title = "New Boarding House",
                    Amenities = "Wi-Fi, Laundry, Kitchen",
                    Price = "$700"
                });
            }
                }

                public class Listing
            {
                public ObservableCollection<ImageModel> Images { get; set; }
                public string Title { get; set; }
                public string Amenities { get; set; }
                public string Price { get; set; }
            }

            public class ImageModel
            {
                public string ImageUrl { get; set; }
            }
            }
