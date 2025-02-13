using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HaBHADbMauiApp.Models
{
    public class AppImage
    {
        public int ImageId { get; set; }
        public int? BoardinghouseId { get; set; }
        public int? QRCodeImageId { get; set; }
        public string? UserId { get; set; }
        public byte[] ImageData { get; set; }
        public string Description { get; set; }

        public ImageSource ImageSource { get; set; }

        public AppImage()
        {
            if (ImageData != null && ImageData.Length > 0)
            {
                ImageSource = ImageSource.FromStream(() => new MemoryStream(ImageData));
            }
            else
            {
                ImageSource = "dotnet_bot.png"; 
            }
        }
    }
}
