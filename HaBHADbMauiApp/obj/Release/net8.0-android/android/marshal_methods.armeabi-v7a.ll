; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [197 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [394 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 145
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 144
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 166
	i32 26230656, ; 3: Microsoft.Extensions.DependencyModel => 0x1903f80 => 59
	i32 39109920, ; 4: Newtonsoft.Json.dll => 0x254c520 => 78
	i32 39485524, ; 5: System.Net.WebSockets.dll => 0x25a8054 => 151
	i32 42639949, ; 6: System.Threading.Thread => 0x28aa24d => 186
	i32 67008169, ; 7: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 68219467, ; 8: System.Security.Cryptography.Primitives => 0x410f24b => 176
	i32 72070932, ; 9: Microsoft.Maui.Graphics.dll => 0x44bb714 => 75
	i32 98325684, ; 10: Microsoft.Extensions.Diagnostics.Abstractions => 0x5dc54b4 => 61
	i32 117431740, ; 11: System.Runtime.InteropServices => 0x6ffddbc => 165
	i32 122350210, ; 12: System.Threading.Channels.dll => 0x74aea82 => 183
	i32 149972175, ; 13: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 176
	i32 165246403, ; 14: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 84
	i32 176714968, ; 15: Microsoft.AspNetCore.WebUtilities.dll => 0xa8874d8 => 53
	i32 182336117, ; 16: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 103
	i32 195452805, ; 17: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 18: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 19: System.ComponentModel => 0xc38ff48 => 125
	i32 220171995, ; 20: System.Diagnostics.Debug => 0xd1f8edb => 128
	i32 221958352, ; 21: Microsoft.Extensions.Diagnostics.dll => 0xd3ad0d0 => 60
	i32 230752869, ; 22: Microsoft.CSharp.dll => 0xdc10265 => 115
	i32 246610117, ; 23: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 158
	i32 280992041, ; 24: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 291275502, ; 25: Microsoft.Extensions.Http.dll => 0x115c82ee => 64
	i32 300686228, ; 26: Microsoft.AspNetCore.Authentication.Abstractions.dll => 0x11ec1b94 => 36
	i32 317674968, ; 27: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 28: Xamarin.AndroidX.Activity.dll => 0x13031348 => 80
	i32 336156722, ; 29: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 30: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 91
	i32 344827588, ; 31: Microsoft.AspNetCore.ResponseCaching.Abstractions => 0x148da6c4 => 50
	i32 356389973, ; 32: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 375677976, ; 33: System.Net.ServicePoint.dll => 0x16646418 => 149
	i32 379916513, ; 34: System.Threading.Thread.dll => 0x16a510e1 => 186
	i32 384051609, ; 35: Microsoft.AspNetCore.Routing.dll => 0x16e42999 => 51
	i32 385762202, ; 36: System.Memory.dll => 0x16fe439a => 140
	i32 395744057, ; 37: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 38: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 39: System.Collections => 0x1a61054f => 121
	i32 450948140, ; 40: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 90
	i32 451504562, ; 41: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 177
	i32 459347974, ; 42: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 170
	i32 469710990, ; 43: System.dll => 0x1bff388e => 191
	i32 490002678, ; 44: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll => 0x1d34d8f6 => 41
	i32 498788369, ; 45: System.ObjectModel => 0x1dbae811 => 153
	i32 500358224, ; 46: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 47: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 48: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 69
	i32 539058512, ; 49: Microsoft.Extensions.Logging => 0x20216150 => 65
	i32 540030774, ; 50: System.IO.FileSystem.dll => 0x20303736 => 136
	i32 545304856, ; 51: System.Runtime.Extensions => 0x2080b118 => 163
	i32 592146354, ; 52: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 613668793, ; 53: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 173
	i32 627609679, ; 54: Xamarin.AndroidX.CustomView => 0x2568904f => 88
	i32 627931235, ; 55: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 56: System.Text.Encodings.Web.dll => 0x27787397 => 180
	i32 672442732, ; 57: System.Collections.Concurrent => 0x2814a96c => 118
	i32 683518922, ; 58: System.Net.Security => 0x28bdabca => 148
	i32 688181140, ; 59: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 60: System.Xml.Linq.dll => 0x29293ff5 => 188
	i32 706645707, ; 61: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 62: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 63: System.Runtime.Loader.dll => 0x2b15ed29 => 167
	i32 724146010, ; 64: Microsoft.AspNetCore.Authorization.Policy.dll => 0x2b29975a => 39
	i32 759454413, ; 65: System.Net.Requests => 0x2d445acd => 147
	i32 775507847, ; 66: System.IO.Compression => 0x2e394f87 => 134
	i32 777317022, ; 67: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 68: Microsoft.Extensions.Options => 0x2f0980eb => 68
	i32 804715423, ; 69: System.Data.Common => 0x2ff6fb9f => 127
	i32 823281589, ; 70: System.Private.Uri.dll => 0x311247b5 => 154
	i32 830298997, ; 71: System.IO.Compression.Brotli => 0x317d5b75 => 133
	i32 878954865, ; 72: System.Net.Http.Json => 0x3463c971 => 141
	i32 904024072, ; 73: System.ComponentModel.Primitives.dll => 0x35e25008 => 123
	i32 908888060, ; 74: Microsoft.Maui.Maps => 0x362c87fc => 76
	i32 926902833, ; 75: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 76: Newtonsoft.Json => 0x38f24a24 => 78
	i32 966729478, ; 77: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 107
	i32 967690846, ; 78: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 91
	i32 975874589, ; 79: System.Xml.XDocument => 0x3a2aaa1d => 190
	i32 992768348, ; 80: System.Collections.dll => 0x3b2c715c => 121
	i32 994442037, ; 81: System.IO.FileSystem => 0x3b45fb35 => 136
	i32 1012816738, ; 82: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 101
	i32 1019214401, ; 83: System.Drawing => 0x3cbffa41 => 131
	i32 1028951442, ; 84: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 58
	i32 1029334545, ; 85: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 86: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 81
	i32 1036536393, ; 87: System.Drawing.Primitives.dll => 0x3dc84a49 => 130
	i32 1044663988, ; 88: System.Linq.Expressions.dll => 0x3e444eb4 => 138
	i32 1048992957, ; 89: Microsoft.Extensions.Diagnostics.Abstractions.dll => 0x3e865cbd => 61
	i32 1052210849, ; 90: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 93
	i32 1082857460, ; 91: System.ComponentModel.TypeConverter => 0x408b17f4 => 124
	i32 1084122840, ; 92: Xamarin.Kotlin.StdLib => 0x409e66d8 => 112
	i32 1098259244, ; 93: System => 0x41761b2c => 191
	i32 1099692271, ; 94: Microsoft.DotNet.PlatformAbstractions => 0x418bf8ef => 54
	i32 1110309514, ; 95: Microsoft.Extensions.Hosting.Abstractions => 0x422dfa8a => 63
	i32 1112354281, ; 96: Microsoft.AspNetCore.Authentication.Abstractions => 0x424d2de9 => 36
	i32 1118262833, ; 97: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 98: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1173126369, ; 99: Microsoft.Extensions.FileProviders.Abstractions.dll => 0x45ec7ce1 => 62
	i32 1178241025, ; 100: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 98
	i32 1203215381, ; 101: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1220193633, ; 102: Microsoft.Net.Http.Headers => 0x48baad61 => 77
	i32 1234928153, ; 103: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1236289705, ; 104: Microsoft.AspNetCore.Hosting.Server.Abstractions => 0x49b048a9 => 41
	i32 1260983243, ; 105: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1267908789, ; 106: Microsoft.AspNetCore.Routing => 0x4b92c0b5 => 51
	i32 1293217323, ; 107: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 89
	i32 1324164729, ; 108: System.Linq => 0x4eed2679 => 139
	i32 1364015309, ; 109: System.IO => 0x514d38cd => 137
	i32 1373134921, ; 110: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 111: Xamarin.AndroidX.SavedState => 0x52114ed3 => 101
	i32 1379779777, ; 112: System.Resources.ResourceManager => 0x523dc4c1 => 161
	i32 1406073936, ; 113: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 85
	i32 1408764838, ; 114: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 169
	i32 1411638395, ; 115: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 162
	i32 1430672901, ; 116: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1435222561, ; 117: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 107
	i32 1452070440, ; 118: System.Formats.Asn1.dll => 0x568cd628 => 132
	i32 1457743152, ; 119: System.Runtime.Extensions.dll => 0x56e36530 => 163
	i32 1458022317, ; 120: System.Net.Security.dll => 0x56e7a7ad => 148
	i32 1461004990, ; 121: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 122: System.IO.Compression.dll => 0x57261233 => 134
	i32 1469204771, ; 123: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 82
	i32 1470490898, ; 124: Microsoft.Extensions.Primitives => 0x57a5e912 => 69
	i32 1480492111, ; 125: System.IO.Compression.Brotli.dll => 0x583e844f => 133
	i32 1493001747, ; 126: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1505131794, ; 127: Microsoft.Extensions.Http => 0x59b67d12 => 64
	i32 1514721132, ; 128: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 129: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 182
	i32 1551623176, ; 130: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1565862583, ; 131: System.IO.FileSystem.Primitives => 0x5d552ab7 => 135
	i32 1622152042, ; 132: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 95
	i32 1624863272, ; 133: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 105
	i32 1636350590, ; 134: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 87
	i32 1639515021, ; 135: System.Net.Http.dll => 0x61b9038d => 142
	i32 1639986890, ; 136: System.Text.RegularExpressions => 0x61c036ca => 182
	i32 1641389582, ; 137: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 122
	i32 1657153582, ; 138: System.Runtime => 0x62c6282e => 171
	i32 1658251792, ; 139: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 106
	i32 1677501392, ; 140: System.Net.Primitives.dll => 0x63fca3d0 => 146
	i32 1678508291, ; 141: System.Net.WebSockets => 0x640c0103 => 151
	i32 1679769178, ; 142: System.Security.Cryptography => 0x641f3e5a => 178
	i32 1696967625, ; 143: System.Security.Cryptography.Csp => 0x6525abc9 => 174
	i32 1701541528, ; 144: System.Diagnostics.Debug.dll => 0x656b7698 => 128
	i32 1726116996, ; 145: System.Reflection.dll => 0x66e27484 => 160
	i32 1729485958, ; 146: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 83
	i32 1736233607, ; 147: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 148: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1763938596, ; 149: System.Diagnostics.TraceSource.dll => 0x69239124 => 129
	i32 1766324549, ; 150: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 103
	i32 1770582343, ; 151: Microsoft.Extensions.Logging.dll => 0x6988f147 => 65
	i32 1780572499, ; 152: Mono.Android.Runtime.dll => 0x6a216153 => 195
	i32 1782862114, ; 153: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 154: Xamarin.AndroidX.Fragment => 0x6a96652d => 90
	i32 1793755602, ; 155: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 156: Xamarin.AndroidX.Loader => 0x6bcd3296 => 95
	i32 1813058853, ; 157: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 112
	i32 1813201214, ; 158: Xamarin.Google.Android.Material => 0x6c13413e => 106
	i32 1818569960, ; 159: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 99
	i32 1819327070, ; 160: Microsoft.AspNetCore.Http.Features.dll => 0x6c70ba5e => 45
	i32 1824175904, ; 161: System.Text.Encoding.Extensions => 0x6cbab720 => 179
	i32 1824722060, ; 162: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 169
	i32 1828688058, ; 163: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 66
	i32 1842015223, ; 164: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 165: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 166: System.Linq.Expressions => 0x6ec71a65 => 138
	i32 1870277092, ; 167: System.Reflection.Primitives => 0x6f7a29e4 => 159
	i32 1875935024, ; 168: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1894524299, ; 169: Microsoft.DotNet.PlatformAbstractions.dll => 0x70ec258b => 54
	i32 1900610850, ; 170: System.Resources.ResourceManager.dll => 0x71490522 => 161
	i32 1908813208, ; 171: Xamarin.GooglePlayServices.Basement => 0x71c62d98 => 109
	i32 1910275211, ; 172: System.Collections.NonGeneric.dll => 0x71dc7c8b => 119
	i32 1921968366, ; 173: Microsoft.AspNetCore.Mvc.Formatters.Json => 0x728ee8ee => 49
	i32 1928288591, ; 174: Microsoft.AspNetCore.Http.Abstractions => 0x72ef594f => 43
	i32 1939592360, ; 175: System.Private.Xml.Linq => 0x739bd4a8 => 155
	i32 1961813231, ; 176: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 102
	i32 1968388702, ; 177: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 55
	i32 2003115576, ; 178: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2011961780, ; 179: System.Buffers.dll => 0x77ec19b4 => 117
	i32 2019465201, ; 180: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 93
	i32 2025202353, ; 181: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 182: System.Private.Xml => 0x79eb68ee => 156
	i32 2055257422, ; 183: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 92
	i32 2066184531, ; 184: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 185: System.Diagnostics.TraceSource => 0x7b6f419e => 129
	i32 2075706075, ; 186: Microsoft.AspNetCore.Http.Abstractions.dll => 0x7bb8c2db => 43
	i32 2079903147, ; 187: System.Runtime.dll => 0x7bf8cdab => 171
	i32 2090596640, ; 188: System.Numerics.Vectors => 0x7c9bf920 => 152
	i32 2092734687, ; 189: Microsoft.AspNetCore.JsonPatch => 0x7cbc98df => 46
	i32 2120057885, ; 190: Microsoft.AspNetCore.Mvc.Formatters.Json.dll => 0x7e5d841d => 49
	i32 2127167465, ; 191: System.Console => 0x7ec9ffe9 => 126
	i32 2129483829, ; 192: Xamarin.GooglePlayServices.Base.dll => 0x7eed5835 => 108
	i32 2142473426, ; 193: System.Collections.Specialized => 0x7fb38cd2 => 120
	i32 2159891885, ; 194: Microsoft.Maui => 0x80bd55ad => 73
	i32 2169148018, ; 195: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 196: Microsoft.Extensions.Options.dll => 0x820d22b3 => 68
	i32 2182738860, ; 197: Microsoft.AspNetCore.Mvc.Core.dll => 0x8219f3ac => 48
	i32 2192057212, ; 198: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 66
	i32 2193016926, ; 199: System.ObjectModel.dll => 0x82b6c85e => 153
	i32 2197979891, ; 200: Microsoft.Extensions.DependencyModel.dll => 0x830282f3 => 59
	i32 2201107256, ; 201: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 113
	i32 2201231467, ; 202: System.Net.Http => 0x8334206b => 142
	i32 2204417087, ; 203: Microsoft.Extensions.ObjectPool => 0x8364bc3f => 67
	i32 2207618523, ; 204: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2242871324, ; 205: Microsoft.AspNetCore.Http.dll => 0x85af801c => 42
	i32 2266799131, ; 206: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 56
	i32 2270573516, ; 207: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 208: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 100
	i32 2285293097, ; 209: Microsoft.AspNetCore.Mvc.Abstractions => 0x8836ce29 => 47
	i32 2295906218, ; 210: System.Net.Sockets => 0x88d8bfaa => 150
	i32 2298471582, ; 211: System.Net.Mail => 0x88ffe49e => 143
	i32 2303073227, ; 212: Microsoft.Maui.Controls.Maps.dll => 0x89461bcb => 71
	i32 2303942373, ; 213: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 214: System.Private.CoreLib.dll => 0x896b7878 => 193
	i32 2321784778, ; 215: Microsoft.AspNetCore.Mvc.Abstractions.dll => 0x8a639fca => 47
	i32 2340441535, ; 216: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 164
	i32 2353062107, ; 217: System.Net.Primitives => 0x8c40e0db => 146
	i32 2368005991, ; 218: System.Xml.ReaderWriter.dll => 0x8d24e767 => 189
	i32 2371007202, ; 219: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 55
	i32 2378619854, ; 220: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 174
	i32 2395872292, ; 221: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 222: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 223: System.Console.dll => 0x912896e5 => 126
	i32 2458592288, ; 224: Microsoft.AspNetCore.Authentication.Core => 0x928b2420 => 37
	i32 2458678730, ; 225: System.Net.Sockets.dll => 0x928c75ca => 150
	i32 2471841756, ; 226: netstandard.dll => 0x93554fdc => 192
	i32 2475788418, ; 227: Java.Interop.dll => 0x93918882 => 194
	i32 2480646305, ; 228: Microsoft.Maui.Controls => 0x93dba8a1 => 70
	i32 2483903535, ; 229: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 122
	i32 2484371297, ; 230: System.Net.ServicePoint => 0x94147f61 => 149
	i32 2490993605, ; 231: System.AppContext.dll => 0x94798bc5 => 116
	i32 2498657740, ; 232: BouncyCastle.Cryptography.dll => 0x94ee7dcc => 35
	i32 2528662365, ; 233: Microsoft.AspNetCore.JsonPatch.dll => 0x96b8535d => 46
	i32 2537015816, ; 234: Microsoft.AspNetCore.Authorization => 0x9737ca08 => 38
	i32 2538310050, ; 235: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 158
	i32 2550873716, ; 236: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 237: Microsoft.CSharp => 0x98ba5a04 => 115
	i32 2570120770, ; 238: System.Text.Encodings.Web => 0x9930ee42 => 180
	i32 2585220780, ; 239: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 179
	i32 2592341985, ; 240: Microsoft.Extensions.FileProviders.Abstractions => 0x9a83ffe1 => 62
	i32 2593268061, ; 241: Microsoft.AspNetCore.Routing.Abstractions.dll => 0x9a92215d => 52
	i32 2593496499, ; 242: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2594125473, ; 243: Microsoft.AspNetCore.Hosting.Abstractions => 0x9a9f36a1 => 40
	i32 2605712449, ; 244: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 113
	i32 2617129537, ; 245: System.Private.Xml.dll => 0x9bfe3a41 => 156
	i32 2620871830, ; 246: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 87
	i32 2626831493, ; 247: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2633959305, ; 248: Microsoft.AspNetCore.Http.Extensions.dll => 0x9cff0789 => 44
	i32 2663698177, ; 249: System.Runtime.Loader => 0x9ec4cf01 => 167
	i32 2664396074, ; 250: System.Xml.XDocument.dll => 0x9ecf752a => 190
	i32 2665622720, ; 251: System.Drawing.Primitives => 0x9ee22cc0 => 130
	i32 2676780864, ; 252: System.Data.Common.dll => 0x9f8c6f40 => 127
	i32 2693849962, ; 253: System.IO.dll => 0xa090e36a => 137
	i32 2715334215, ; 254: System.Threading.Tasks.dll => 0xa1d8b647 => 185
	i32 2717744543, ; 255: System.Security.Claims => 0xa1fd7d9f => 172
	i32 2724373263, ; 256: System.Runtime.Numerics.dll => 0xa262a30f => 168
	i32 2732626843, ; 257: Xamarin.AndroidX.Activity => 0xa2e0939b => 80
	i32 2735172069, ; 258: System.Threading.Channels => 0xa30769e5 => 183
	i32 2735631878, ; 259: Microsoft.AspNetCore.Authorization.dll => 0xa30e6e06 => 38
	i32 2737747696, ; 260: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 82
	i32 2752995522, ; 261: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 262: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 72
	i32 2764765095, ; 263: Microsoft.Maui.dll => 0xa4caf7a7 => 73
	i32 2778768386, ; 264: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 104
	i32 2785988530, ; 265: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 266: Microsoft.Maui.Graphics => 0xa7008e0b => 75
	i32 2806116107, ; 267: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 268: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 85
	i32 2831556043, ; 269: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2847418871, ; 270: Xamarin.GooglePlayServices.Base => 0xa9b829f7 => 108
	i32 2850549256, ; 271: Microsoft.AspNetCore.Http.Features => 0xa9e7ee08 => 45
	i32 2853208004, ; 272: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 104
	i32 2861189240, ; 273: Microsoft.Maui.Essentials => 0xaa8a4878 => 74
	i32 2901442782, ; 274: System.Reflection => 0xacf080de => 160
	i32 2909740682, ; 275: System.Private.CoreLib => 0xad6f1e8a => 193
	i32 2916838712, ; 276: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 105
	i32 2919462931, ; 277: System.Numerics.Vectors.dll => 0xae037813 => 152
	i32 2959614098, ; 278: System.ComponentModel.dll => 0xb0682092 => 125
	i32 2972252294, ; 279: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 173
	i32 2978368250, ; 280: Microsoft.AspNetCore.Hosting.Abstractions.dll => 0xb1864afa => 40
	i32 2978675010, ; 281: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 89
	i32 2987532451, ; 282: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 102
	i32 2996646946, ; 283: Microsoft.AspNetCore.Http => 0xb29d3422 => 42
	i32 3017076677, ; 284: Xamarin.GooglePlayServices.Maps => 0xb3d4efc5 => 110
	i32 3020703001, ; 285: Microsoft.Extensions.Diagnostics => 0xb40c4519 => 60
	i32 3033331042, ; 286: Microsoft.AspNetCore.Authentication.Core.dll => 0xb4ccf562 => 37
	i32 3036999524, ; 287: Microsoft.AspNetCore.Http.Extensions => 0xb504ef64 => 44
	i32 3038032645, ; 288: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 289: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 96
	i32 3058099980, ; 290: Xamarin.GooglePlayServices.Tasks => 0xb646e70c => 111
	i32 3059408633, ; 291: Mono.Android.Runtime => 0xb65adef9 => 195
	i32 3059793426, ; 292: System.ComponentModel.Primitives => 0xb660be12 => 123
	i32 3075834255, ; 293: System.Threading.Tasks => 0xb755818f => 185
	i32 3077302341, ; 294: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3090735792, ; 295: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 177
	i32 3099732863, ; 296: System.Security.Claims.dll => 0xb8c22b7f => 172
	i32 3103600923, ; 297: System.Formats.Asn1 => 0xb8fd311b => 132
	i32 3113762169, ; 298: Microsoft.AspNetCore.Routing.Abstractions => 0xb9983d79 => 52
	i32 3124832203, ; 299: System.Threading.Tasks.Extensions => 0xba4127cb => 184
	i32 3151576809, ; 300: Microsoft.AspNetCore.Mvc.Core => 0xbbd93ee9 => 48
	i32 3159123045, ; 301: System.Reflection.Primitives.dll => 0xbc4c6465 => 159
	i32 3178803400, ; 302: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 97
	i32 3183431167, ; 303: HaBHADbMauiApp => 0xbdbf4dff => 114
	i32 3220365878, ; 304: System.Threading => 0xbff2e236 => 187
	i32 3228018376, ; 305: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll => 0xc067a6c8 => 50
	i32 3230466174, ; 306: Xamarin.GooglePlayServices.Basement.dll => 0xc08d007e => 109
	i32 3258312781, ; 307: Xamarin.AndroidX.CardView => 0xc235e84d => 83
	i32 3265893370, ; 308: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 184
	i32 3290767353, ; 309: System.Security.Cryptography.Encoding => 0xc4251ff9 => 175
	i32 3300764913, ; 310: Microsoft.AspNetCore.WebUtilities => 0xc4bdacf1 => 53
	i32 3305363605, ; 311: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 312: System.Net.Requests.dll => 0xc5b097e4 => 147
	i32 3317135071, ; 313: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 88
	i32 3346324047, ; 314: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 98
	i32 3357674450, ; 315: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 316: System.Text.Json => 0xc82afec1 => 181
	i32 3362522851, ; 317: Xamarin.AndroidX.Core => 0xc86c06e3 => 86
	i32 3366347497, ; 318: Java.Interop => 0xc8a662e9 => 194
	i32 3374999561, ; 319: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 100
	i32 3381016424, ; 320: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3395150330, ; 321: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 162
	i32 3428513518, ; 322: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 57
	i32 3430777524, ; 323: netstandard => 0xcc7d82b4 => 192
	i32 3447004316, ; 324: HaBHADbMauiApp.dll => 0xcd751c9c => 114
	i32 3463511458, ; 325: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 326: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 124
	i32 3476120550, ; 327: Mono.Android => 0xcf3163e6 => 196
	i32 3479583265, ; 328: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 329: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 330: System.Text.Json.dll => 0xcfbaacae => 181
	i32 3500773090, ; 331: Microsoft.Maui.Controls.Maps => 0xd0a98ee2 => 71
	i32 3509114376, ; 332: System.Xml.Linq => 0xd128d608 => 188
	i32 3580758918, ; 333: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3605570793, ; 334: BouncyCastle.Cryptography => 0xd6e8a4e9 => 35
	i32 3608519521, ; 335: System.Linq.dll => 0xd715a361 => 139
	i32 3624195450, ; 336: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 164
	i32 3638274909, ; 337: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 135
	i32 3641597786, ; 338: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 92
	i32 3643446276, ; 339: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 340: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 97
	i32 3657292374, ; 341: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 56
	i32 3660523487, ; 342: System.Net.NetworkInformation => 0xda2f27df => 145
	i32 3672681054, ; 343: Mono.Android.dll => 0xdae8aa5e => 196
	i32 3697841164, ; 344: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3716563718, ; 345: System.Runtime.Intrinsics => 0xdd864306 => 166
	i32 3724971120, ; 346: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 96
	i32 3732100267, ; 347: System.Net.NameResolution => 0xde7354ab => 144
	i32 3737834244, ; 348: System.Net.Http.Json.dll => 0xdecad304 => 141
	i32 3748608112, ; 349: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 79
	i32 3765508441, ; 350: Microsoft.Extensions.ObjectPool.dll => 0xe0711959 => 67
	i32 3786282454, ; 351: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 84
	i32 3792276235, ; 352: System.Collections.NonGeneric => 0xe2098b0b => 119
	i32 3802395368, ; 353: System.Collections.Specialized.dll => 0xe2a3f2e8 => 120
	i32 3823082795, ; 354: System.Security.Cryptography.dll => 0xe3df9d2b => 178
	i32 3841636137, ; 355: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 58
	i32 3844307129, ; 356: System.Net.Mail.dll => 0xe52378b9 => 143
	i32 3849253459, ; 357: System.Runtime.InteropServices.dll => 0xe56ef253 => 165
	i32 3875112723, ; 358: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 175
	i32 3889960447, ; 359: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 360: System.Collections.Concurrent.dll => 0xe839deed => 118
	i32 3896760992, ; 361: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 86
	i32 3928044579, ; 362: System.Xml.ReaderWriter => 0xea213423 => 189
	i32 3931092270, ; 363: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 99
	i32 3955647286, ; 364: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 81
	i32 3970018735, ; 365: Xamarin.GooglePlayServices.Tasks.dll => 0xeca1adaf => 111
	i32 3980434154, ; 366: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 367: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4025784931, ; 368: System.Memory => 0xeff49a63 => 140
	i32 4044155772, ; 369: Microsoft.Net.Http.Headers.dll => 0xf10ceb7c => 77
	i32 4046471985, ; 370: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 72
	i32 4054681211, ; 371: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 157
	i32 4068434129, ; 372: System.Private.Xml.Linq.dll => 0xf27f60d1 => 155
	i32 4073602200, ; 373: System.Threading.dll => 0xf2ce3c98 => 187
	i32 4078967171, ; 374: Microsoft.Extensions.Hosting.Abstractions.dll => 0xf3201983 => 63
	i32 4094352644, ; 375: Microsoft.Maui.Essentials.dll => 0xf40add04 => 74
	i32 4099507663, ; 376: System.Drawing.dll => 0xf45985cf => 131
	i32 4100113165, ; 377: System.Private.Uri => 0xf462c30d => 154
	i32 4102112229, ; 378: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 379: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 380: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 57
	i32 4130442656, ; 381: System.AppContext => 0xf6318da0 => 116
	i32 4141580284, ; 382: Microsoft.AspNetCore.Authorization.Policy => 0xf6db7ffc => 39
	i32 4147896353, ; 383: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 157
	i32 4150914736, ; 384: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 385: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 170
	i32 4182413190, ; 386: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 94
	i32 4190991637, ; 387: Microsoft.Maui.Maps.dll => 0xf9cd7515 => 76
	i32 4213026141, ; 388: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 79
	i32 4260525087, ; 389: System.Buffers => 0xfdf2741f => 117
	i32 4271975918, ; 390: Microsoft.Maui.Controls.dll => 0xfea12dee => 70
	i32 4274976490, ; 391: System.Runtime.Numerics => 0xfecef6ea => 168
	i32 4278134329, ; 392: Xamarin.GooglePlayServices.Maps.dll => 0xfeff2639 => 110
	i32 4292120959 ; 393: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 94
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [394 x i32] [
	i32 145, ; 0
	i32 144, ; 1
	i32 166, ; 2
	i32 59, ; 3
	i32 78, ; 4
	i32 151, ; 5
	i32 186, ; 6
	i32 33, ; 7
	i32 176, ; 8
	i32 75, ; 9
	i32 61, ; 10
	i32 165, ; 11
	i32 183, ; 12
	i32 176, ; 13
	i32 84, ; 14
	i32 53, ; 15
	i32 103, ; 16
	i32 30, ; 17
	i32 31, ; 18
	i32 125, ; 19
	i32 128, ; 20
	i32 60, ; 21
	i32 115, ; 22
	i32 158, ; 23
	i32 2, ; 24
	i32 64, ; 25
	i32 36, ; 26
	i32 30, ; 27
	i32 80, ; 28
	i32 15, ; 29
	i32 91, ; 30
	i32 50, ; 31
	i32 14, ; 32
	i32 149, ; 33
	i32 186, ; 34
	i32 51, ; 35
	i32 140, ; 36
	i32 34, ; 37
	i32 26, ; 38
	i32 121, ; 39
	i32 90, ; 40
	i32 177, ; 41
	i32 170, ; 42
	i32 191, ; 43
	i32 41, ; 44
	i32 153, ; 45
	i32 13, ; 46
	i32 7, ; 47
	i32 69, ; 48
	i32 65, ; 49
	i32 136, ; 50
	i32 163, ; 51
	i32 21, ; 52
	i32 173, ; 53
	i32 88, ; 54
	i32 19, ; 55
	i32 180, ; 56
	i32 118, ; 57
	i32 148, ; 58
	i32 1, ; 59
	i32 188, ; 60
	i32 16, ; 61
	i32 4, ; 62
	i32 167, ; 63
	i32 39, ; 64
	i32 147, ; 65
	i32 134, ; 66
	i32 25, ; 67
	i32 68, ; 68
	i32 127, ; 69
	i32 154, ; 70
	i32 133, ; 71
	i32 141, ; 72
	i32 123, ; 73
	i32 76, ; 74
	i32 28, ; 75
	i32 78, ; 76
	i32 107, ; 77
	i32 91, ; 78
	i32 190, ; 79
	i32 121, ; 80
	i32 136, ; 81
	i32 101, ; 82
	i32 131, ; 83
	i32 58, ; 84
	i32 3, ; 85
	i32 81, ; 86
	i32 130, ; 87
	i32 138, ; 88
	i32 61, ; 89
	i32 93, ; 90
	i32 124, ; 91
	i32 112, ; 92
	i32 191, ; 93
	i32 54, ; 94
	i32 63, ; 95
	i32 36, ; 96
	i32 16, ; 97
	i32 22, ; 98
	i32 62, ; 99
	i32 98, ; 100
	i32 20, ; 101
	i32 77, ; 102
	i32 18, ; 103
	i32 41, ; 104
	i32 2, ; 105
	i32 51, ; 106
	i32 89, ; 107
	i32 139, ; 108
	i32 137, ; 109
	i32 32, ; 110
	i32 101, ; 111
	i32 161, ; 112
	i32 85, ; 113
	i32 169, ; 114
	i32 162, ; 115
	i32 0, ; 116
	i32 107, ; 117
	i32 132, ; 118
	i32 163, ; 119
	i32 148, ; 120
	i32 6, ; 121
	i32 134, ; 122
	i32 82, ; 123
	i32 69, ; 124
	i32 133, ; 125
	i32 10, ; 126
	i32 64, ; 127
	i32 5, ; 128
	i32 182, ; 129
	i32 25, ; 130
	i32 135, ; 131
	i32 95, ; 132
	i32 105, ; 133
	i32 87, ; 134
	i32 142, ; 135
	i32 182, ; 136
	i32 122, ; 137
	i32 171, ; 138
	i32 106, ; 139
	i32 146, ; 140
	i32 151, ; 141
	i32 178, ; 142
	i32 174, ; 143
	i32 128, ; 144
	i32 160, ; 145
	i32 83, ; 146
	i32 23, ; 147
	i32 1, ; 148
	i32 129, ; 149
	i32 103, ; 150
	i32 65, ; 151
	i32 195, ; 152
	i32 17, ; 153
	i32 90, ; 154
	i32 9, ; 155
	i32 95, ; 156
	i32 112, ; 157
	i32 106, ; 158
	i32 99, ; 159
	i32 45, ; 160
	i32 179, ; 161
	i32 169, ; 162
	i32 66, ; 163
	i32 29, ; 164
	i32 26, ; 165
	i32 138, ; 166
	i32 159, ; 167
	i32 8, ; 168
	i32 54, ; 169
	i32 161, ; 170
	i32 109, ; 171
	i32 119, ; 172
	i32 49, ; 173
	i32 43, ; 174
	i32 155, ; 175
	i32 102, ; 176
	i32 55, ; 177
	i32 5, ; 178
	i32 117, ; 179
	i32 93, ; 180
	i32 0, ; 181
	i32 156, ; 182
	i32 92, ; 183
	i32 4, ; 184
	i32 129, ; 185
	i32 43, ; 186
	i32 171, ; 187
	i32 152, ; 188
	i32 46, ; 189
	i32 49, ; 190
	i32 126, ; 191
	i32 108, ; 192
	i32 120, ; 193
	i32 73, ; 194
	i32 12, ; 195
	i32 68, ; 196
	i32 48, ; 197
	i32 66, ; 198
	i32 153, ; 199
	i32 59, ; 200
	i32 113, ; 201
	i32 142, ; 202
	i32 67, ; 203
	i32 14, ; 204
	i32 42, ; 205
	i32 56, ; 206
	i32 8, ; 207
	i32 100, ; 208
	i32 47, ; 209
	i32 150, ; 210
	i32 143, ; 211
	i32 71, ; 212
	i32 18, ; 213
	i32 193, ; 214
	i32 47, ; 215
	i32 164, ; 216
	i32 146, ; 217
	i32 189, ; 218
	i32 55, ; 219
	i32 174, ; 220
	i32 13, ; 221
	i32 10, ; 222
	i32 126, ; 223
	i32 37, ; 224
	i32 150, ; 225
	i32 192, ; 226
	i32 194, ; 227
	i32 70, ; 228
	i32 122, ; 229
	i32 149, ; 230
	i32 116, ; 231
	i32 35, ; 232
	i32 46, ; 233
	i32 38, ; 234
	i32 158, ; 235
	i32 11, ; 236
	i32 115, ; 237
	i32 180, ; 238
	i32 179, ; 239
	i32 62, ; 240
	i32 52, ; 241
	i32 20, ; 242
	i32 40, ; 243
	i32 113, ; 244
	i32 156, ; 245
	i32 87, ; 246
	i32 15, ; 247
	i32 44, ; 248
	i32 167, ; 249
	i32 190, ; 250
	i32 130, ; 251
	i32 127, ; 252
	i32 137, ; 253
	i32 185, ; 254
	i32 172, ; 255
	i32 168, ; 256
	i32 80, ; 257
	i32 183, ; 258
	i32 38, ; 259
	i32 82, ; 260
	i32 21, ; 261
	i32 72, ; 262
	i32 73, ; 263
	i32 104, ; 264
	i32 27, ; 265
	i32 75, ; 266
	i32 6, ; 267
	i32 85, ; 268
	i32 19, ; 269
	i32 108, ; 270
	i32 45, ; 271
	i32 104, ; 272
	i32 74, ; 273
	i32 160, ; 274
	i32 193, ; 275
	i32 105, ; 276
	i32 152, ; 277
	i32 125, ; 278
	i32 173, ; 279
	i32 40, ; 280
	i32 89, ; 281
	i32 102, ; 282
	i32 42, ; 283
	i32 110, ; 284
	i32 60, ; 285
	i32 37, ; 286
	i32 44, ; 287
	i32 34, ; 288
	i32 96, ; 289
	i32 111, ; 290
	i32 195, ; 291
	i32 123, ; 292
	i32 185, ; 293
	i32 12, ; 294
	i32 177, ; 295
	i32 172, ; 296
	i32 132, ; 297
	i32 52, ; 298
	i32 184, ; 299
	i32 48, ; 300
	i32 159, ; 301
	i32 97, ; 302
	i32 114, ; 303
	i32 187, ; 304
	i32 50, ; 305
	i32 109, ; 306
	i32 83, ; 307
	i32 184, ; 308
	i32 175, ; 309
	i32 53, ; 310
	i32 7, ; 311
	i32 147, ; 312
	i32 88, ; 313
	i32 98, ; 314
	i32 24, ; 315
	i32 181, ; 316
	i32 86, ; 317
	i32 194, ; 318
	i32 100, ; 319
	i32 3, ; 320
	i32 162, ; 321
	i32 57, ; 322
	i32 192, ; 323
	i32 114, ; 324
	i32 11, ; 325
	i32 124, ; 326
	i32 196, ; 327
	i32 24, ; 328
	i32 23, ; 329
	i32 181, ; 330
	i32 71, ; 331
	i32 188, ; 332
	i32 31, ; 333
	i32 35, ; 334
	i32 139, ; 335
	i32 164, ; 336
	i32 135, ; 337
	i32 92, ; 338
	i32 28, ; 339
	i32 97, ; 340
	i32 56, ; 341
	i32 145, ; 342
	i32 196, ; 343
	i32 33, ; 344
	i32 166, ; 345
	i32 96, ; 346
	i32 144, ; 347
	i32 141, ; 348
	i32 79, ; 349
	i32 67, ; 350
	i32 84, ; 351
	i32 119, ; 352
	i32 120, ; 353
	i32 178, ; 354
	i32 58, ; 355
	i32 143, ; 356
	i32 165, ; 357
	i32 175, ; 358
	i32 32, ; 359
	i32 118, ; 360
	i32 86, ; 361
	i32 189, ; 362
	i32 99, ; 363
	i32 81, ; 364
	i32 111, ; 365
	i32 27, ; 366
	i32 9, ; 367
	i32 140, ; 368
	i32 77, ; 369
	i32 72, ; 370
	i32 157, ; 371
	i32 155, ; 372
	i32 187, ; 373
	i32 63, ; 374
	i32 74, ; 375
	i32 131, ; 376
	i32 154, ; 377
	i32 22, ; 378
	i32 17, ; 379
	i32 57, ; 380
	i32 116, ; 381
	i32 39, ; 382
	i32 157, ; 383
	i32 29, ; 384
	i32 170, ; 385
	i32 94, ; 386
	i32 76, ; 387
	i32 79, ; 388
	i32 117, ; 389
	i32 70, ; 390
	i32 168, ; 391
	i32 110, ; 392
	i32 94 ; 393
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ df9aaf29a52042a4fbf800daf2f3a38964b9e958"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}
