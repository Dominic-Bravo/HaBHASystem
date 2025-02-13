using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Maui.Controls.Maps;


namespace MapforMaui.MapUI

{
   public static class PinRepository
    {
        public static List<Pin> Pins { get; } = new List<Pin>();
    }
}
