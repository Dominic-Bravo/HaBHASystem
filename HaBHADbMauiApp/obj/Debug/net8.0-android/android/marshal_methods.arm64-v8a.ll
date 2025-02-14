; ModuleID = 'marshal_methods.arm64-v8a.ll'
source_filename = "marshal_methods.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [350 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [700 x i64] [
	i64 15690660930947125, ; 0: Microsoft.DotNet.PlatformAbstractions.dll => 0x37be92af148835 => 193
	i64 24362543149721218, ; 1: Xamarin.AndroidX.DynamicAnimation => 0x568d9a9a43a682 => 253
	i64 98382396393917666, ; 2: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 211
	i64 120698629574877762, ; 3: Mono.Android => 0x1accec39cafe242 => 170
	i64 131669012237370309, ; 4: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 217
	i64 160518225272466977, ; 5: Microsoft.Extensions.Hosting.Abstractions => 0x23a4679b5576e21 => 203
	i64 196720943101637631, ; 6: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 57
	i64 210515253464952879, ; 7: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 240
	i64 229794953483747371, ; 8: System.ValueTuple.dll => 0x330654aed93802b => 150
	i64 232391251801502327, ; 9: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 281
	i64 295915112840604065, ; 10: Xamarin.AndroidX.SlidingPaneLayout => 0x41b4d3a3088a9a1 => 284
	i64 316157742385208084, ; 11: Xamarin.AndroidX.Core.Core.Ktx.dll => 0x46337caa7dc1b14 => 247
	i64 350667413455104241, ; 12: System.ServiceProcess.dll => 0x4ddd227954be8f1 => 131
	i64 354178770117062970, ; 13: Microsoft.Extensions.Options.ConfigurationExtensions.dll => 0x4ea4bb703cff13a => 210
	i64 396868157601372792, ; 14: Microsoft.VisualStudio.DesignTools.TapContract => 0x581f57c947e5a78 => 348
	i64 422779754995088667, ; 15: System.IO.UnmanagedMemoryStream => 0x5de03f27ab57d1b => 55
	i64 435118502366263740, ; 16: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x609d9f8f8bdb9bc => 283
	i64 535107122908063503, ; 17: Microsoft.Extensions.ObjectPool.dll => 0x76d1517d9b7670f => 208
	i64 545109961164950392, ; 18: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 319
	i64 560278790331054453, ; 19: System.Reflection.Primitives => 0x7c6829760de3975 => 94
	i64 590337075967009532, ; 20: Microsoft.Maui.Maps.dll => 0x8314c715ec1a2fc => 219
	i64 634308326490598313, ; 21: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x8cd840fee8b6ba9 => 266
	i64 649145001856603771, ; 22: System.Security.SecureString => 0x90239f09b62167b => 128
	i64 668723562677762733, ; 23: Microsoft.Extensions.Configuration.Binder.dll => 0x947c88986577aad => 196
	i64 687654259221141486, ; 24: Xamarin.GooglePlayServices.Base => 0x98b09e7c92917ee => 301
	i64 750875890346172408, ; 25: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 144
	i64 798450721097591769, ; 26: Xamarin.AndroidX.Collection.Ktx.dll => 0xb14aab351ad2bd9 => 241
	i64 799765834175365804, ; 27: System.ComponentModel.dll => 0xb1956c9f18442ac => 18
	i64 849051935479314978, ; 28: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 322
	i64 872800313462103108, ; 29: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 252
	i64 895210737996778430, ; 30: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0xc6c6d6c5569cbbe => 267
	i64 940822596282819491, ; 31: System.Transactions => 0xd0e792aa81923a3 => 149
	i64 960778385402502048, ; 32: System.Runtime.Handles.dll => 0xd555ed9e1ca1ba0 => 103
	i64 982068613551266738, ; 33: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll => 0xda1023367c89bb2 => 189
	i64 1001381392624924420, ; 34: Microsoft.AspNetCore.Authentication.Core.dll => 0xde59f1230183704 => 176
	i64 1010599046655515943, ; 35: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 94
	i64 1120440138749646132, ; 36: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 296
	i64 1121665720830085036, ; 37: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 330
	i64 1268860745194512059, ; 38: System.Drawing.dll => 0x119be62002c19ebb => 35
	i64 1301626418029409250, ; 39: System.Diagnostics.FileVersionInfo => 0x12104e54b4e833e2 => 27
	i64 1315114680217950157, ; 40: Xamarin.AndroidX.Arch.Core.Common.dll => 0x124039d5794ad7cd => 236
	i64 1369545283391376210, ; 41: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 274
	i64 1404195534211153682, ; 42: System.IO.FileSystem.Watcher.dll => 0x137cb4660bd87f12 => 49
	i64 1425944114962822056, ; 43: System.Runtime.Serialization.dll => 0x13c9f89e19eaf3a8 => 114
	i64 1476839205573959279, ; 44: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 69
	i64 1486715745332614827, ; 45: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 213
	i64 1492954217099365037, ; 46: System.Net.HttpListener => 0x14b809f350210aad => 64
	i64 1513467482682125403, ; 47: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 169
	i64 1537168428375924959, ; 48: System.Threading.Thread.dll => 0x15551e8a954ae0df => 144
	i64 1556147632182429976, ; 49: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 328
	i64 1563692358899906069, ; 50: HaBHADbMauiApp.dll => 0x15b359ea6638b615 => 0
	i64 1576750169145655260, ; 51: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x15e1bdecc376bfdc => 295
	i64 1624659445732251991, ; 52: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 235
	i64 1628611045998245443, ; 53: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 270
	i64 1636321030536304333, ; 54: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0x16b5614ec39e16cd => 260
	i64 1651782184287836205, ; 55: System.Globalization.Calendars => 0x16ec4f2524cb982d => 39
	i64 1659332977923810219, ; 56: System.Reflection.DispatchProxy => 0x1707228d493d63ab => 88
	i64 1682513316613008342, ; 57: System.Net.dll => 0x17597cf276952bd6 => 80
	i64 1731380447121279447, ; 58: Newtonsoft.Json => 0x18071957e9b889d7 => 222
	i64 1735388228521408345, ; 59: System.Net.Mail.dll => 0x181556663c69b759 => 65
	i64 1743969030606105336, ; 60: System.Memory.dll => 0x1833d297e88f2af8 => 61
	i64 1767386781656293639, ; 61: System.Private.Uri.dll => 0x188704e9f5582107 => 85
	i64 1795316252682057001, ; 62: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 234
	i64 1825687700144851180, ; 63: System.Runtime.InteropServices.RuntimeInformation.dll => 0x1956254a55ef08ec => 105
	i64 1835311033149317475, ; 64: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 318
	i64 1836611346387731153, ; 65: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 281
	i64 1854145951182283680, ; 66: System.Runtime.CompilerServices.VisualC => 0x19bb3feb3df2e3a0 => 101
	i64 1875417405349196092, ; 67: System.Drawing.Primitives => 0x1a06d2319b6c713c => 34
	i64 1875917498431009007, ; 68: Xamarin.AndroidX.Annotation.dll => 0x1a08990699eb70ef => 231
	i64 1881198190668717030, ; 69: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 340
	i64 1897575647115118287, ; 70: Xamarin.AndroidX.Security.SecurityCrypto => 0x1a558aff4cba86cf => 283
	i64 1920760634179481754, ; 71: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 215
	i64 1959996714666907089, ; 72: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 340
	i64 1963507636676687784, ; 73: MimeKit => 0x1b3fc7cadde177a8 => 221
	i64 1972385128188460614, ; 74: System.Security.Cryptography.Algorithms => 0x1b5f51d2edefbe46 => 118
	i64 1981742497975770890, ; 75: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 268
	i64 1983698669889758782, ; 76: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 314
	i64 2019660174692588140, ; 77: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 332
	i64 2040001226662520565, ; 78: System.Threading.Tasks.Extensions.dll => 0x1c4f8a4ea894a6f5 => 141
	i64 2062890601515140263, ; 79: System.Threading.Tasks.Dataflow => 0x1ca0dc1289cd44a7 => 140
	i64 2064708342624596306, ; 80: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x1ca7514c5eecb152 => 308
	i64 2080945842184875448, ; 81: System.IO.MemoryMappedFiles => 0x1ce10137d8416db8 => 52
	i64 2102659300918482391, ; 82: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 34
	i64 2106033277907880740, ; 83: System.Threading.Tasks.Dataflow.dll => 0x1d3a221ba6d9cb24 => 140
	i64 2133195048986300728, ; 84: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 222
	i64 2165310824878145998, ; 85: Xamarin.Android.Glide.GifDecoder => 0x1e0cbab9112b81ce => 228
	i64 2165725771938924357, ; 86: Xamarin.AndroidX.Browser => 0x1e0e341d75540745 => 238
	i64 2200176636225660136, ; 87: Microsoft.Extensions.Logging.Debug.dll => 0x1e8898fe5d5824e8 => 207
	i64 2262844636196693701, ; 88: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 252
	i64 2287834202362508563, ; 89: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 8
	i64 2287887973817120656, ; 90: System.ComponentModel.DataAnnotations.dll => 0x1fc035fd8d41f790 => 14
	i64 2302323944321350744, ; 91: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 336
	i64 2304837677853103545, ; 92: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0x1ffc6da80d5ed5b9 => 280
	i64 2315304989185124968, ; 93: System.IO.FileSystem.dll => 0x20219d9ee311aa68 => 50
	i64 2329709569556905518, ; 94: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 263
	i64 2335503487726329082, ; 95: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 135
	i64 2337758774805907496, ; 96: System.Runtime.CompilerServices.Unsafe => 0x207163383edbc828 => 100
	i64 2470498323731680442, ; 97: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 245
	i64 2479423007379663237, ; 98: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x2268ae16b2cba985 => 290
	i64 2497223385847772520, ; 99: System.Runtime => 0x22a7eb7046413568 => 115
	i64 2547086958574651984, ; 100: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 229
	i64 2592350477072141967, ; 101: System.Xml.dll => 0x23f9e10627330e8f => 162
	i64 2602673633151553063, ; 102: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 339
	i64 2624866290265602282, ; 103: mscorlib.dll => 0x246d65fbde2db8ea => 165
	i64 2632269733008246987, ; 104: System.Net.NameResolution => 0x2487b36034f808cb => 66
	i64 2656907746661064104, ; 105: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 197
	i64 2662981627730767622, ; 106: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 314
	i64 2706075432581334785, ; 107: System.Net.WebSockets => 0x258de944be6c0701 => 79
	i64 2783046991838674048, ; 108: System.Runtime.CompilerServices.Unsafe.dll => 0x269f5e7e6dc37c80 => 100
	i64 2787234703088983483, ; 109: Xamarin.AndroidX.Startup.StartupRuntime => 0x26ae3f31ef429dbb => 285
	i64 2815524396660695947, ; 110: System.Security.AccessControl => 0x2712c0857f68238b => 116
	i64 2895129759130297543, ; 111: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 319
	i64 2923871038697555247, ; 112: Jsr305Binding => 0x2893ad37e69ec52f => 297
	i64 2974029546067041986, ; 113: Microsoft.AspNetCore.Mvc.Formatters.Json.dll => 0x2945e01d74d79ec2 => 188
	i64 3017136373564924869, ; 114: System.Net.WebProxy => 0x29df058bd93f63c5 => 77
	i64 3017704767998173186, ; 115: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 296
	i64 3021884968805928991, ; 116: Microsoft.AspNetCore.Authorization.Policy => 0x29efe45e55c5101f => 178
	i64 3062772059105072826, ; 117: Microsoft.VisualStudio.DesignTools.MobileTapContracts => 0x2a8126f5e2f316ba => 347
	i64 3106852385031680087, ; 118: System.Runtime.Serialization.Xml => 0x2b1dc1c88b637057 => 113
	i64 3110390492489056344, ; 119: System.Security.Cryptography.Csp.dll => 0x2b2a53ac61900058 => 120
	i64 3135773902340015556, ; 120: System.IO.FileSystem.DriveInfo.dll => 0x2b8481c008eac5c4 => 47
	i64 3168817962471953758, ; 121: Microsoft.Extensions.Hosting.Abstractions.dll => 0x2bf9e725d304955e => 203
	i64 3266690593535380875, ; 122: Microsoft.AspNetCore.Authorization => 0x2d559dc982c94d8b => 177
	i64 3281594302220646930, ; 123: System.Security.Principal => 0x2d8a90a198ceba12 => 127
	i64 3289520064315143713, ; 124: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 261
	i64 3303437397778967116, ; 125: Xamarin.AndroidX.Annotation.Experimental => 0x2dd82acf985b2a4c => 232
	i64 3311221304742556517, ; 126: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 81
	i64 3325875462027654285, ; 127: System.Runtime.Numerics => 0x2e27e21c8958b48d => 109
	i64 3328853167529574890, ; 128: System.Net.Sockets.dll => 0x2e327651a008c1ea => 74
	i64 3344514922410554693, ; 129: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 311
	i64 3396143930648122816, ; 130: Microsoft.Extensions.FileProviders.Abstractions => 0x2f2186e9506155c0 => 202
	i64 3411255996856937470, ; 131: Xamarin.GooglePlayServices.Basement => 0x2f5737416a942bfe => 302
	i64 3429672777697402584, ; 132: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 217
	i64 3437845325506641314, ; 133: System.IO.MemoryMappedFiles.dll => 0x2fb5ae1beb8f7da2 => 52
	i64 3493805808809882663, ; 134: Xamarin.AndroidX.Tracing.Tracing.dll => 0x307c7ddf444f3427 => 287
	i64 3494946837667399002, ; 135: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 194
	i64 3508450208084372758, ; 136: System.Net.Ping => 0x30b084e02d03ad16 => 68
	i64 3522470458906976663, ; 137: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 286
	i64 3531994851595924923, ; 138: System.Numerics => 0x31042a9aade235bb => 82
	i64 3551103847008531295, ; 139: System.Private.CoreLib.dll => 0x31480e226177735f => 171
	i64 3567343442040498961, ; 140: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 334
	i64 3571415421602489686, ; 141: System.Runtime.dll => 0x319037675df7e556 => 115
	i64 3638003163729360188, ; 142: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 195
	i64 3647754201059316852, ; 143: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 155
	i64 3655542548057982301, ; 144: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 194
	i64 3659371656528649588, ; 145: Xamarin.Android.Glide.Annotations => 0x32c8b3222885dd74 => 226
	i64 3716579019761409177, ; 146: netstandard.dll => 0x3393f0ed5c8c5c99 => 166
	i64 3727469159507183293, ; 147: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 279
	i64 3772598417116884899, ; 148: Xamarin.AndroidX.DynamicAnimation.dll => 0x345af645b473efa3 => 253
	i64 3869221888984012293, ; 149: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 205
	i64 3869649043256705283, ; 150: System.Diagnostics.Tools => 0x35b3c14d74bf0103 => 31
	i64 3890352374528606784, ; 151: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 215
	i64 3919223565570527920, ; 152: System.Security.Cryptography.Encoding => 0x3663e111652bd2b0 => 121
	i64 3933965368022646939, ; 153: System.Net.Requests => 0x369840a8bfadc09b => 71
	i64 3966267475168208030, ; 154: System.Memory => 0x370b03412596249e => 61
	i64 4006972109285359177, ; 155: System.Xml.XmlDocument => 0x379b9fe74ed9fe49 => 160
	i64 4009997192427317104, ; 156: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 112
	i64 4073500526318903918, ; 157: System.Private.Xml.dll => 0x3887fb25779ae26e => 87
	i64 4073631083018132676, ; 158: Microsoft.Maui.Controls.Compatibility.dll => 0x388871e311491cc4 => 212
	i64 4120493066591692148, ; 159: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 345
	i64 4148881117810174540, ; 160: System.Runtime.InteropServices.JavaScript.dll => 0x3993c9651a66aa4c => 104
	i64 4154383907710350974, ; 161: System.ComponentModel => 0x39a7562737acb67e => 18
	i64 4167269041631776580, ; 162: System.Threading.ThreadPool => 0x39d51d1d3df1cf44 => 145
	i64 4168469861834746866, ; 163: System.Security.Claims.dll => 0x39d96140fb94ebf2 => 117
	i64 4187479170553454871, ; 164: System.Linq.Expressions => 0x3a1cea1e912fa117 => 57
	i64 4201423742386704971, ; 165: Xamarin.AndroidX.Core.Core.Ktx => 0x3a4e74a233da124b => 247
	i64 4205801962323029395, ; 166: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 17
	i64 4225924121207573736, ; 167: Microsoft.AspNetCore.Authentication.Abstractions => 0x3aa57f992c550ce8 => 175
	i64 4235503420553921860, ; 168: System.IO.IsolatedStorage.dll => 0x3ac787eb9b118544 => 51
	i64 4243591448627561453, ; 169: Microsoft.AspNetCore.Http.Extensions.dll => 0x3ae443f06354c3ed => 183
	i64 4247996603072512073, ; 170: Xamarin.GooglePlayServices.Tasks => 0x3af3ea6755340049 => 304
	i64 4250192876909962317, ; 171: Microsoft.AspNetCore.Hosting.Abstractions => 0x3afbb7e72f1d244d => 179
	i64 4282138915307457788, ; 172: System.Reflection.Emit => 0x3b6d36a7ddc70cfc => 91
	i64 4321177614414309855, ; 173: Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll => 0x3bf7e8254e88e9df => 347
	i64 4356591372459378815, ; 174: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 342
	i64 4373617458794931033, ; 175: System.IO.Pipes.dll => 0x3cb235e806eb2359 => 54
	i64 4388777479429739993, ; 176: Microsoft.Maui.Controls.HotReload.Forms.dll => 0x3ce811dd63a4d5d9 => 346
	i64 4397634830160618470, ; 177: System.Security.SecureString.dll => 0x3d0789940f9be3e6 => 128
	i64 4477672992252076438, ; 178: System.Web.HttpUtility.dll => 0x3e23e3dcdb8ba196 => 151
	i64 4484706122338676047, ; 179: System.Globalization.Extensions.dll => 0x3e3ce07510042d4f => 40
	i64 4533124835995628778, ; 180: System.Reflection.Emit.dll => 0x3ee8e505540534ea => 91
	i64 4636684751163556186, ; 181: Xamarin.AndroidX.VersionedParcelable.dll => 0x4058d0370893015a => 291
	i64 4657212095206026001, ; 182: Microsoft.Extensions.Http.dll => 0x40a1bdb9c2686b11 => 204
	i64 4672453897036726049, ; 183: System.IO.FileSystem.Watcher => 0x40d7e4104a437f21 => 49
	i64 4679594760078841447, ; 184: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 312
	i64 4716677666592453464, ; 185: System.Xml.XmlSerializer => 0x417501590542f358 => 161
	i64 4743821336939966868, ; 186: System.ComponentModel.Annotations => 0x41d5705f4239b194 => 13
	i64 4759461199762736555, ; 187: Xamarin.AndroidX.Lifecycle.Process.dll => 0x420d00be961cc5ab => 265
	i64 4794310189461587505, ; 188: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 229
	i64 4795410492532947900, ; 189: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 286
	i64 4809057822547766521, ; 190: System.Drawing => 0x42bd349c3145ecf9 => 35
	i64 4814660307502931973, ; 191: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 66
	i64 4853321196694829351, ; 192: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 108
	i64 5055365687667823624, ; 193: Xamarin.AndroidX.Activity.Ktx.dll => 0x4628444ef7239408 => 230
	i64 5081566143765835342, ; 194: System.Resources.ResourceManager.dll => 0x4685597c05d06e4e => 98
	i64 5099468265966638712, ; 195: System.Resources.ResourceManager => 0x46c4f35ea8519678 => 98
	i64 5103417709280584325, ; 196: System.Collections.Specialized => 0x46d2fb5e161b6285 => 11
	i64 5112836352847824253, ; 197: Microsoft.AspNetCore.WebUtilities.dll => 0x46f47192ee32c57d => 192
	i64 5177565741364132164, ; 198: Microsoft.AspNetCore.Http => 0x47da689c1f3db944 => 181
	i64 5182934613077526976, ; 199: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 11
	i64 5205316157927637098, ; 200: Xamarin.AndroidX.LocalBroadcastManager => 0x483cff7778e0c06a => 272
	i64 5244375036463807528, ; 201: System.Diagnostics.Contracts.dll => 0x48c7c34f4d59fc28 => 25
	i64 5262971552273843408, ; 202: System.Security.Principal.dll => 0x4909d4be0c44c4d0 => 127
	i64 5278787618751394462, ; 203: System.Net.WebClient.dll => 0x4942055efc68329e => 75
	i64 5280980186044710147, ; 204: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x4949cf7fd7123d03 => 264
	i64 5290786973231294105, ; 205: System.Runtime.Loader => 0x496ca6b869b72699 => 108
	i64 5376510917114486089, ; 206: Xamarin.AndroidX.VectorDrawable.Animated => 0x4a9d3431719e5d49 => 290
	i64 5382384903084550500, ; 207: MailKit.dll => 0x4ab2128d60c7a964 => 174
	i64 5408338804355907810, ; 208: Xamarin.AndroidX.Transition => 0x4b0e477cea9840e2 => 288
	i64 5423376490970181369, ; 209: System.Runtime.InteropServices.RuntimeInformation => 0x4b43b42f2b7b6ef9 => 105
	i64 5440320908473006344, ; 210: Microsoft.VisualBasic.Core => 0x4b7fe70acda9f908 => 2
	i64 5446034149219586269, ; 211: System.Diagnostics.Debug => 0x4b94333452e150dd => 26
	i64 5451019430259338467, ; 212: Xamarin.AndroidX.ConstraintLayout.dll => 0x4ba5e94a845c2ce3 => 243
	i64 5457765010617926378, ; 213: System.Xml.Serialization => 0x4bbde05c557002ea => 156
	i64 5471532531798518949, ; 214: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 338
	i64 5507995362134886206, ; 215: System.Core.dll => 0x4c705499688c873e => 21
	i64 5522859530602327440, ; 216: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 341
	i64 5527431512186326818, ; 217: System.IO.FileSystem.Primitives.dll => 0x4cb561acbc2a8f22 => 48
	i64 5570799893513421663, ; 218: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 42
	i64 5573260873512690141, ; 219: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 125
	i64 5573669443803475672, ; 220: Microsoft.Maui.Controls.Maps => 0x4d59a6d41d5aeed8 => 214
	i64 5574231584441077149, ; 221: Xamarin.AndroidX.Annotation.Jvm => 0x4d5ba617ae5f8d9d => 233
	i64 5591791169662171124, ; 222: System.Linq.Parallel => 0x4d9a087135e137f4 => 58
	i64 5593115988096097561, ; 223: Microsoft.AspNetCore.Routing.dll => 0x4d9ebd5b8a069d19 => 190
	i64 5610815111739789596, ; 224: Microsoft.AspNetCore.Authentication.Core => 0x4ddd9e9de3a4d11c => 176
	i64 5650097808083101034, ; 225: System.Security.Cryptography.Algorithms.dll => 0x4e692e055d01a56a => 118
	i64 5692067934154308417, ; 226: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 293
	i64 5724799082821825042, ; 227: Xamarin.AndroidX.ExifInterface => 0x4f72926f3e13b212 => 256
	i64 5757522595884336624, ; 228: Xamarin.AndroidX.Concurrent.Futures.dll => 0x4fe6d44bd9f885f0 => 242
	i64 5783556987928984683, ; 229: Microsoft.VisualBasic => 0x504352701bbc3c6b => 3
	i64 5896680224035167651, ; 230: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x51d5376bfbafdda3 => 262
	i64 5959344983920014087, ; 231: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x52b3d8b05c8ef307 => 282
	i64 5979151488806146654, ; 232: System.Formats.Asn1 => 0x52fa3699a489d25e => 37
	i64 5984759512290286505, ; 233: System.Security.Cryptography.Primitives => 0x530e23115c33dba9 => 123
	i64 6010974535988770325, ; 234: Microsoft.Extensions.Diagnostics.dll => 0x536b457e33877615 => 200
	i64 6068057819846744445, ; 235: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 335
	i64 6102788177522843259, ; 236: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0x54b1758374b3de7b => 282
	i64 6200764641006662125, ; 237: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 335
	i64 6222399776351216807, ; 238: System.Text.Json.dll => 0x565a67a0ffe264a7 => 136
	i64 6251069312384999852, ; 239: System.Transactions.Local => 0x56c0426b870da1ac => 148
	i64 6278736998281604212, ; 240: System.Private.DataContractSerialization => 0x57228e08a4ad6c74 => 84
	i64 6284145129771520194, ; 241: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 89
	i64 6319713645133255417, ; 242: Xamarin.AndroidX.Lifecycle.Runtime => 0x57b42213b45b52f9 => 266
	i64 6357457916754632952, ; 243: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 349
	i64 6401687960814735282, ; 244: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 263
	i64 6433271170595107064, ; 245: MimeKit.dll => 0x5947920b731530f8 => 221
	i64 6459596646370694080, ; 246: Microsoft.AspNetCore.JsonPatch.dll => 0x59a518eceb3ad3c0 => 185
	i64 6478287442656530074, ; 247: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 323
	i64 6504860066809920875, ; 248: Xamarin.AndroidX.Browser.dll => 0x5a45e7c43bd43d6b => 238
	i64 6548213210057960872, ; 249: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 249
	i64 6557084851308642443, ; 250: Xamarin.AndroidX.Window.dll => 0x5aff71ee6c58c08b => 294
	i64 6560151584539558821, ; 251: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 209
	i64 6589202984700901502, ; 252: Xamarin.Google.ErrorProne.Annotations.dll => 0x5b718d34180a787e => 299
	i64 6591971792923354531, ; 253: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x5b7b636b7e9765a3 => 264
	i64 6617685658146568858, ; 254: System.Text.Encoding.CodePages => 0x5bd6be0b4905fa9a => 132
	i64 6713440830605852118, ; 255: System.Reflection.TypeExtensions.dll => 0x5d2aeeddb8dd7dd6 => 95
	i64 6739853162153639747, ; 256: Microsoft.VisualBasic.dll => 0x5d88c4bde075ff43 => 3
	i64 6743165466166707109, ; 257: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 331
	i64 6772837112740759457, ; 258: System.Runtime.InteropServices.JavaScript => 0x5dfdf378527ec7a1 => 104
	i64 6777482997383978746, ; 259: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 334
	i64 6786606130239981554, ; 260: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 32
	i64 6798329586179154312, ; 261: System.Windows => 0x5e5884bd523ca188 => 153
	i64 6814185388980153342, ; 262: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 157
	i64 6876862101832370452, ; 263: System.Xml.Linq => 0x5f6f85a57d108914 => 154
	i64 6894844156784520562, ; 264: System.Numerics.Vectors => 0x5faf683aead1ad72 => 81
	i64 6911788284027924527, ; 265: Microsoft.AspNetCore.Hosting.Server.Abstractions => 0x5feb9ad2f830f02f => 180
	i64 7011053663211085209, ; 266: Xamarin.AndroidX.Fragment.Ktx => 0x614c442918e5dd99 => 258
	i64 7060896174307865760, ; 267: System.Threading.Tasks.Parallel.dll => 0x61fd57a90988f4a0 => 142
	i64 7083547580668757502, ; 268: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 86
	i64 7101497697220435230, ; 269: System.Configuration => 0x628d9687c0141d1e => 19
	i64 7103753931438454322, ; 270: Xamarin.AndroidX.Interpolator.dll => 0x62959a90372c7632 => 259
	i64 7105430439328552570, ; 271: System.Security.Cryptography.Pkcs => 0x629b8f56a06d167a => 224
	i64 7112547816752919026, ; 272: System.IO.FileSystem => 0x62b4d88e3189b1f2 => 50
	i64 7141281584637745974, ; 273: Xamarin.GooglePlayServices.Maps.dll => 0x631aedc3dd5f1b36 => 303
	i64 7192745174564810625, ; 274: Xamarin.Android.Glide.GifDecoder.dll => 0x63d1c3a0a1d72f81 => 228
	i64 7220009545223068405, ; 275: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 338
	i64 7270811800166795866, ; 276: System.Linq => 0x64e71ccf51a90a5a => 60
	i64 7299370801165188114, ; 277: System.IO.Pipes.AccessControl.dll => 0x654c9311e74f3c12 => 53
	i64 7316205155833392065, ; 278: Microsoft.Win32.Primitives => 0x658861d38954abc1 => 4
	i64 7331765743953618630, ; 279: Microsoft.AspNetCore.Http.dll => 0x65bfaa1948bba6c6 => 181
	i64 7338192458477945005, ; 280: System.Reflection => 0x65d67f295d0740ad => 96
	i64 7349431895026339542, ; 281: Xamarin.Android.Glide.DiskLruCache => 0x65fe6d5e9bf88ed6 => 227
	i64 7377312882064240630, ; 282: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 17
	i64 7473077275758116397, ; 283: Microsoft.DotNet.PlatformAbstractions => 0x67b5b430309b3e2d => 193
	i64 7488575175965059935, ; 284: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 154
	i64 7489048572193775167, ; 285: System.ObjectModel => 0x67ee71ff6b419e3f => 83
	i64 7592577537120840276, ; 286: System.Diagnostics.Process => 0x695e410af5b2aa54 => 28
	i64 7637303409920963731, ; 287: System.IO.Compression.ZipFile.dll => 0x69fd26fcb637f493 => 44
	i64 7654504624184590948, ; 288: System.Net.Http => 0x6a3a4366801b8264 => 63
	i64 7694700312542370399, ; 289: System.Net.Mail => 0x6ac9112a7e2cda5f => 65
	i64 7708790323521193081, ; 290: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 329
	i64 7714652370974252055, ; 291: System.Private.CoreLib => 0x6b0ff375198b9c17 => 171
	i64 7725404731275645577, ; 292: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x6b3626ac11ce9289 => 267
	i64 7735176074855944702, ; 293: Microsoft.CSharp => 0x6b58dda848e391fe => 1
	i64 7735352534559001595, ; 294: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 306
	i64 7791074099216502080, ; 295: System.IO.FileSystem.AccessControl.dll => 0x6c1f749d468bcd40 => 46
	i64 7820441508502274321, ; 296: System.Data => 0x6c87ca1e14ff8111 => 24
	i64 7824823231109474690, ; 297: Microsoft.AspNetCore.Authorization.Policy.dll => 0x6c975b4560812982 => 178
	i64 7836164640616011524, ; 298: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 235
	i64 7919757340696389605, ; 299: Microsoft.Extensions.Diagnostics.Abstractions => 0x6de8a157378027e5 => 201
	i64 8025517457475554965, ; 300: WindowsBase => 0x6f605d9b4786ce95 => 164
	i64 8031450141206250471, ; 301: System.Runtime.Intrinsics.dll => 0x6f757159d9dc03e7 => 107
	i64 8064050204834738623, ; 302: System.Collections.dll => 0x6fe942efa61731bf => 12
	i64 8083354569033831015, ; 303: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 261
	i64 8085230611270010360, ; 304: System.Net.Http.Json.dll => 0x703482674fdd05f8 => 62
	i64 8087206902342787202, ; 305: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 223
	i64 8103644804370223335, ; 306: System.Data.DataSetExtensions.dll => 0x7075ee03be6d50e7 => 23
	i64 8113615946733131500, ; 307: System.Reflection.Extensions => 0x70995ab73cf916ec => 92
	i64 8167236081217502503, ; 308: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 167
	i64 8185542183669246576, ; 309: System.Collections => 0x7198e33f4794aa70 => 12
	i64 8187640529827139739, ; 310: Xamarin.KotlinX.Coroutines.Android => 0x71a057ae90f0109b => 310
	i64 8246048515196606205, ; 311: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 218
	i64 8264926008854159966, ; 312: System.Diagnostics.Process.dll => 0x72b2ea6a64a3a25e => 28
	i64 8290740647658429042, ; 313: System.Runtime.Extensions => 0x730ea0b15c929a72 => 102
	i64 8318905602908530212, ; 314: System.ComponentModel.DataAnnotations => 0x7372b092055ea624 => 14
	i64 8368701292315763008, ; 315: System.Security.Cryptography => 0x7423997c6fd56140 => 125
	i64 8398329775253868912, ; 316: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x748cdc6f3097d170 => 244
	i64 8400357532724379117, ; 317: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 276
	i64 8410671156615598628, ; 318: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 90
	i64 8426919725312979251, ; 319: Xamarin.AndroidX.Lifecycle.Process => 0x74f26ed7aa033133 => 265
	i64 8518412311883997971, ; 320: System.Collections.Immutable => 0x76377add7c28e313 => 9
	i64 8519205576476231015, ; 321: Microsoft.AspNetCore.Mvc.Core.dll => 0x763a4c55ca648567 => 187
	i64 8563666267364444763, ; 322: System.Private.Uri => 0x76d841191140ca5b => 85
	i64 8598790081731763592, ; 323: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x77550a055fc61d88 => 255
	i64 8601935802264776013, ; 324: Xamarin.AndroidX.Transition.dll => 0x7760370982b4ed4d => 288
	i64 8611142787134128904, ; 325: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll => 0x7780ecbdb94c0308 => 180
	i64 8614108721271900878, ; 326: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 333
	i64 8623059219396073920, ; 327: System.Net.Quic.dll => 0x77ab42ac514299c0 => 70
	i64 8626175481042262068, ; 328: Java.Interop => 0x77b654e585b55834 => 167
	i64 8638972117149407195, ; 329: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 1
	i64 8639588376636138208, ; 330: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 275
	i64 8648495978913578441, ; 331: Microsoft.Win32.Registry.dll => 0x7805a1456889bdc9 => 5
	i64 8677882282824630478, ; 332: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 333
	i64 8684531736582871431, ; 333: System.IO.Compression.FileSystem => 0x7885a79a0fa0d987 => 43
	i64 8725526185868997716, ; 334: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 223
	i64 8816904670177563593, ; 335: Microsoft.Extensions.Diagnostics => 0x7a5bf015646a93c9 => 200
	i64 8853378295825400934, ; 336: Xamarin.Kotlin.StdLib.Common.dll => 0x7add84a720d38466 => 307
	i64 8941376889969657626, ; 337: System.Xml.XDocument => 0x7c1626e87187471a => 157
	i64 8951477988056063522, ; 338: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0x7c3a09cd9ccf5e22 => 278
	i64 8954753533646919997, ; 339: System.Runtime.Serialization.Json => 0x7c45ace50032d93d => 111
	i64 9045785047181495996, ; 340: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 343
	i64 9138683372487561558, ; 341: System.Security.Cryptography.Csp => 0x7ed3201bc3e3d156 => 120
	i64 9286073997824813334, ; 342: BouncyCastle.Cryptography => 0x80dec319ee56e916 => 172
	i64 9312692141327339315, ; 343: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 293
	i64 9324707631942237306, ; 344: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 234
	i64 9413000421947348542, ; 345: Microsoft.AspNetCore.Hosting.Abstractions.dll => 0x82a1b202f4c6163e => 179
	i64 9468215723722196442, ; 346: System.Xml.XPath.XDocument.dll => 0x8365dc09353ac5da => 158
	i64 9554839972845591462, ; 347: System.ServiceModel.Web => 0x84999c54e32a1ba6 => 130
	i64 9575902398040817096, ; 348: Xamarin.Google.Crypto.Tink.Android.dll => 0x84e4707ee708bdc8 => 298
	i64 9584643793929893533, ; 349: System.IO.dll => 0x85037ebfbbd7f69d => 56
	i64 9659729154652888475, ; 350: System.Text.RegularExpressions => 0x860e407c9991dd9b => 137
	i64 9662334977499516867, ; 351: System.Numerics.dll => 0x8617827802b0cfc3 => 82
	i64 9667360217193089419, ; 352: System.Diagnostics.StackTrace => 0x86295ce5cd89898b => 29
	i64 9678050649315576968, ; 353: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 245
	i64 9702891218465930390, ; 354: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 10
	i64 9780093022148426479, ; 355: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x87b9dec9576efaef => 295
	i64 9808709177481450983, ; 356: Mono.Android.dll => 0x881f890734e555e7 => 170
	i64 9825649861376906464, ; 357: Xamarin.AndroidX.Concurrent.Futures => 0x885bb87d8abc94e0 => 242
	i64 9834056768316610435, ; 358: System.Transactions.dll => 0x8879968718899783 => 149
	i64 9836529246295212050, ; 359: System.Reflection.Metadata => 0x88825f3bbc2ac012 => 93
	i64 9875200773399460291, ; 360: Xamarin.GooglePlayServices.Base.dll => 0x890bc2c8482339c3 => 301
	i64 9907349773706910547, ; 361: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x897dfa20b758db53 => 255
	i64 9933555792566666578, ; 362: System.Linq.Queryable.dll => 0x89db145cf475c552 => 59
	i64 9938556199016768930, ; 363: Microsoft.AspNetCore.Routing => 0x89ecd834cea6a5a2 => 190
	i64 9956195530459977388, ; 364: Microsoft.Maui => 0x8a2b8315b36616ac => 216
	i64 9974604633896246661, ; 365: System.Xml.Serialization.dll => 0x8a6cea111a59dd85 => 156
	i64 9991543690424095600, ; 366: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 318
	i64 10017511394021241210, ; 367: Microsoft.Extensions.Logging.Debug => 0x8b055989ae10717a => 207
	i64 10038780035334861115, ; 368: System.Net.Http.dll => 0x8b50e941206af13b => 63
	i64 10051358222726253779, ; 369: System.Private.Xml => 0x8b7d990c97ccccd3 => 87
	i64 10078727084704864206, ; 370: System.Net.WebSockets.Client => 0x8bded4e257f117ce => 78
	i64 10089571585547156312, ; 371: System.IO.FileSystem.AccessControl => 0x8c055be67469bb58 => 46
	i64 10092835686693276772, ; 372: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 213
	i64 10105485790837105934, ; 373: System.Threading.Tasks.Parallel => 0x8c3de5c91d9a650e => 142
	i64 10143853363526200146, ; 374: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 315
	i64 10205853378024263619, ; 375: Microsoft.Extensions.Configuration.Binder => 0x8da279930adb4fc3 => 196
	i64 10226222362177979215, ; 376: Xamarin.Kotlin.StdLib.Jdk7 => 0x8dead70ebbc6434f => 308
	i64 10229024438826829339, ; 377: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 249
	i64 10236703004850800690, ; 378: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 73
	i64 10243523786148452761, ; 379: Microsoft.AspNetCore.Http.Abstractions => 0x8e284e9c69a49999 => 182
	i64 10245369515835430794, ; 380: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 90
	i64 10252714262739571204, ; 381: Microsoft.Maui.Controls.HotReload.Forms => 0x8e48f54cfe2c5204 => 346
	i64 10321854143672141184, ; 382: Xamarin.Jetbrains.Annotations.dll => 0x8f3e97a7f8f8c580 => 305
	i64 10360651442923773544, ; 383: System.Text.Encoding => 0x8fc86d98211c1e68 => 134
	i64 10364469296367737616, ; 384: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 89
	i64 10376576884623852283, ; 385: Xamarin.AndroidX.Tracing.Tracing => 0x900101b2f888c2fb => 287
	i64 10406448008575299332, ; 386: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 311
	i64 10430153318873392755, ; 387: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 246
	i64 10458986597687352396, ; 388: Microsoft.AspNetCore.Routing.Abstractions => 0x9125c8e581b9dc4c => 191
	i64 10506226065143327199, ; 389: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 313
	i64 10546663366131771576, ; 390: System.Runtime.Serialization.Json.dll => 0x925d4673efe8e8b8 => 111
	i64 10566960649245365243, ; 391: System.Globalization.dll => 0x92a562b96dcd13fb => 41
	i64 10595762989148858956, ; 392: System.Xml.XPath.XDocument => 0x930bb64cc472ea4c => 158
	i64 10670374202010151210, ; 393: Microsoft.Win32.Primitives.dll => 0x9414c8cd7b4ea92a => 4
	i64 10714184849103829812, ; 394: System.Runtime.Extensions.dll => 0x94b06e5aa4b4bb34 => 102
	i64 10785150219063592792, ; 395: System.Net.Primitives => 0x95ac8cfb68830758 => 69
	i64 10809043855025277762, ; 396: Microsoft.Extensions.Options.ConfigurationExtensions => 0x9601701e0c668b42 => 210
	i64 10822644899632537592, ; 397: System.Linq.Queryable => 0x9631c23204ca5ff8 => 59
	i64 10830817578243619689, ; 398: System.Formats.Tar => 0x964ecb340a447b69 => 38
	i64 10847732767863316357, ; 399: Xamarin.AndroidX.Arch.Core.Common => 0x968ae37a86db9f85 => 236
	i64 10899834349646441345, ; 400: System.Web => 0x9743fd975946eb81 => 152
	i64 10943875058216066601, ; 401: System.IO.UnmanagedMemoryStream.dll => 0x97e07461df39de29 => 55
	i64 10964653383833615866, ; 402: System.Diagnostics.Tracing => 0x982a4628ccaffdfa => 33
	i64 11002576679268595294, ; 403: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 206
	i64 11009005086950030778, ; 404: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 216
	i64 11019817191295005410, ; 405: Xamarin.AndroidX.Annotation.Jvm.dll => 0x98ee415998e1b2e2 => 233
	i64 11023048688141570732, ; 406: System.Core => 0x98f9bc61168392ac => 21
	i64 11037814507248023548, ; 407: System.Xml => 0x992e31d0412bf7fc => 162
	i64 11050168729868392624, ; 408: Microsoft.AspNetCore.Http.Features => 0x995a15e9dbef58b0 => 184
	i64 11071824625609515081, ; 409: Xamarin.Google.ErrorProne.Annotations => 0x99a705d600e0a049 => 299
	i64 11103970607964515343, ; 410: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 324
	i64 11136029745144976707, ; 411: Jsr305Binding.dll => 0x9a8b200d4f8cd543 => 297
	i64 11162124722117608902, ; 412: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 292
	i64 11188319605227840848, ; 413: System.Threading.Overlapped => 0x9b44e5671724e550 => 139
	i64 11220793807500858938, ; 414: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 327
	i64 11226290749488709958, ; 415: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 209
	i64 11235648312900863002, ; 416: System.Reflection.DispatchProxy.dll => 0x9bed0a9c8fac441a => 88
	i64 11329751333533450475, ; 417: System.Threading.Timer.dll => 0x9d3b5ccf6cc500eb => 146
	i64 11340910727871153756, ; 418: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 248
	i64 11347436699239206956, ; 419: System.Xml.XmlSerializer.dll => 0x9d7a318e8162502c => 161
	i64 11392833485892708388, ; 420: Xamarin.AndroidX.Print.dll => 0x9e1b79b18fcf6824 => 277
	i64 11432101114902388181, ; 421: System.AppContext => 0x9ea6fb64e61a9dd5 => 6
	i64 11446671985764974897, ; 422: Mono.Android.Export => 0x9edabf8623efc131 => 168
	i64 11448276831755070604, ; 423: System.Diagnostics.TextWriterTraceListener => 0x9ee0731f77186c8c => 30
	i64 11485890710487134646, ; 424: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 106
	i64 11508496261504176197, ; 425: Xamarin.AndroidX.Fragment.Ktx.dll => 0x9fb664600dde1045 => 258
	i64 11518296021396496455, ; 426: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 325
	i64 11529969570048099689, ; 427: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 292
	i64 11530571088791430846, ; 428: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 205
	i64 11580057168383206117, ; 429: Xamarin.AndroidX.Annotation => 0xa0b4a0a4103262e5 => 231
	i64 11591352189662810718, ; 430: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0xa0dcc167234c525e => 285
	i64 11597940890313164233, ; 431: netstandard => 0xa0f429ca8d1805c9 => 166
	i64 11672361001936329215, ; 432: Xamarin.AndroidX.Interpolator => 0xa1fc8e7d0a8999ff => 259
	i64 11692977985522001935, ; 433: System.Threading.Overlapped.dll => 0xa245cd869980680f => 139
	i64 11705530742807338875, ; 434: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 321
	i64 11707554492040141440, ; 435: System.Linq.Parallel.dll => 0xa27996c7fe94da80 => 58
	i64 11743665907891708234, ; 436: System.Threading.Tasks => 0xa2f9e1ec30c0214a => 143
	i64 11991047634523762324, ; 437: System.Net => 0xa668c24ad493ae94 => 80
	i64 12040886584167504988, ; 438: System.Net.ServicePoint => 0xa719d28d8e121c5c => 73
	i64 12063623837170009990, ; 439: System.Security => 0xa76a99f6ce740786 => 129
	i64 12096697103934194533, ; 440: System.Diagnostics.Contracts => 0xa7e019eccb7e8365 => 25
	i64 12102847907131387746, ; 441: System.Buffers => 0xa7f5f40c43256f62 => 7
	i64 12123043025855404482, ; 442: System.Reflection.Extensions.dll => 0xa83db366c0e359c2 => 92
	i64 12137774235383566651, ; 443: Xamarin.AndroidX.VectorDrawable => 0xa872095bbfed113b => 289
	i64 12145679461940342714, ; 444: System.Text.Json => 0xa88e1f1ebcb62fba => 136
	i64 12191646537372739477, ; 445: Xamarin.Android.Glide.dll => 0xa9316dee7f392795 => 225
	i64 12201331334810686224, ; 446: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 112
	i64 12269460666702402136, ; 447: System.Collections.Immutable.dll => 0xaa45e178506c9258 => 9
	i64 12332222936682028543, ; 448: System.Runtime.Handles => 0xab24db6c07db5dff => 103
	i64 12375446203996702057, ; 449: System.Configuration.dll => 0xabbe6ac12e2e0569 => 19
	i64 12441092376399691269, ; 450: Microsoft.AspNetCore.Authentication.Abstractions.dll => 0xaca7a399c11fbe05 => 175
	i64 12451044538927396471, ; 451: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 257
	i64 12466513435562512481, ; 452: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 271
	i64 12475113361194491050, ; 453: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 349
	i64 12487638416075308985, ; 454: Xamarin.AndroidX.DocumentFile.dll => 0xad4d00fa21b0bfb9 => 251
	i64 12517810545449516888, ; 455: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 32
	i64 12538491095302438457, ; 456: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 239
	i64 12550732019250633519, ; 457: System.IO.Compression => 0xae2d28465e8e1b2f => 45
	i64 12681088699309157496, ; 458: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 326
	i64 12699999919562409296, ; 459: System.Diagnostics.StackTrace.dll => 0xb03f76a3ad01c550 => 29
	i64 12700543734426720211, ; 460: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 240
	i64 12708238894395270091, ; 461: System.IO => 0xb05cbbf17d3ba3cb => 56
	i64 12708922737231849740, ; 462: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 133
	i64 12717050818822477433, ; 463: System.Runtime.Serialization.Xml.dll => 0xb07c0a5786811679 => 113
	i64 12753841065332862057, ; 464: Xamarin.AndroidX.Window => 0xb0febee04cf46c69 => 294
	i64 12823819093633476069, ; 465: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 339
	i64 12828192437253469131, ; 466: Xamarin.Kotlin.StdLib.Jdk8.dll => 0xb206e50e14d873cb => 309
	i64 12835242264250840079, ; 467: System.IO.Pipes => 0xb21ff0d5d6c0740f => 54
	i64 12843321153144804894, ; 468: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 211
	i64 12843770487262409629, ; 469: System.AppContext.dll => 0xb23e3d357debf39d => 6
	i64 12854393673938618003, ; 470: HaBHADbMauiApp => 0xb263faf0e223c693 => 0
	i64 12859557719246324186, ; 471: System.Net.WebHeaderCollection.dll => 0xb276539ce04f41da => 76
	i64 12982280885948128408, ; 472: Xamarin.AndroidX.CustomView.PoolingContainer => 0xb42a53aec5481c98 => 250
	i64 13068258254871114833, ; 473: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 110
	i64 13070736518021853291, ; 474: Microsoft.AspNetCore.JsonPatch => 0xb564959c856b306b => 185
	i64 13129914918964716986, ; 475: Xamarin.AndroidX.Emoji2.dll => 0xb636d40db3fe65ba => 254
	i64 13173818576982874404, ; 476: System.Runtime.CompilerServices.VisualC.dll => 0xb6d2ce32a8819924 => 101
	i64 13221551921002590604, ; 477: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 313
	i64 13222659110913276082, ; 478: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 327
	i64 13308002692117796025, ; 479: Microsoft.AspNetCore.Routing.Abstractions.dll => 0xb8af85f08d9f94b9 => 191
	i64 13343850469010654401, ; 480: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 169
	i64 13370592475155966277, ; 481: System.Runtime.Serialization => 0xb98de304062ea945 => 114
	i64 13381594904270902445, ; 482: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 321
	i64 13401370062847626945, ; 483: Xamarin.AndroidX.VectorDrawable.dll => 0xb9fb3b1193964ec1 => 289
	i64 13404347523447273790, ; 484: Xamarin.AndroidX.ConstraintLayout.Core => 0xba05cf0da4f6393e => 244
	i64 13404984788036896679, ; 485: Microsoft.AspNetCore.Http.Abstractions.dll => 0xba0812a45e7447a7 => 182
	i64 13431476299110033919, ; 486: System.Net.WebClient => 0xba663087f18829ff => 75
	i64 13454009404024712428, ; 487: Xamarin.Google.Guava.ListenableFuture => 0xbab63e4543a86cec => 300
	i64 13463706743370286408, ; 488: System.Private.DataContractSerialization.dll => 0xbad8b1f3069e0548 => 84
	i64 13465488254036897740, ; 489: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 306
	i64 13467053111158216594, ; 490: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 341
	i64 13491513212026656886, ; 491: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0xbb3b7bc905569876 => 237
	i64 13540124433173649601, ; 492: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 342
	i64 13545416393490209236, ; 493: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 325
	i64 13550417756503177631, ; 494: Microsoft.Extensions.FileProviders.Abstractions.dll => 0xbc0cc1280684799f => 202
	i64 13572454107664307259, ; 495: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 279
	i64 13578472628727169633, ; 496: System.Xml.XPath => 0xbc706ce9fba5c261 => 159
	i64 13580399111273692417, ; 497: Microsoft.VisualBasic.Core.dll => 0xbc77450a277fbd01 => 2
	i64 13618112415141049676, ; 498: Microsoft.AspNetCore.Mvc.Core => 0xbcfd4116f7d1b54c => 187
	i64 13621154251410165619, ; 499: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0xbd080f9faa1acf73 => 250
	i64 13647894001087880694, ; 500: System.Data.dll => 0xbd670f48cb071df6 => 24
	i64 13675589307506966157, ; 501: Xamarin.AndroidX.Activity.Ktx => 0xbdc97404d0153e8d => 230
	i64 13702626353344114072, ; 502: System.Diagnostics.Tools.dll => 0xbe29821198fb6d98 => 31
	i64 13710614125866346983, ; 503: System.Security.AccessControl.dll => 0xbe45e2e7d0b769e7 => 116
	i64 13713329104121190199, ; 504: System.Dynamic.Runtime => 0xbe4f8829f32b5737 => 36
	i64 13717397318615465333, ; 505: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 16
	i64 13755568601956062840, ; 506: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 320
	i64 13768883594457632599, ; 507: System.IO.IsolatedStorage => 0xbf14e6adb159cf57 => 51
	i64 13814445057219246765, ; 508: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 323
	i64 13828521679616088467, ; 509: Xamarin.Kotlin.StdLib.Common => 0xbfe8c733724e1993 => 307
	i64 13881769479078963060, ; 510: System.Console.dll => 0xc0a5f3cade5c6774 => 20
	i64 13911222732217019342, ; 511: System.Security.Cryptography.OpenSsl.dll => 0xc10e975ec1226bce => 122
	i64 13921917134693230900, ; 512: Microsoft.AspNetCore.WebUtilities => 0xc13495df5dd06934 => 192
	i64 13928444506500929300, ; 513: System.Windows.dll => 0xc14bc67b8bba9714 => 153
	i64 13955418299340266673, ; 514: Microsoft.Extensions.DependencyModel.dll => 0xc1ab9b0118299cb1 => 199
	i64 13959074834287824816, ; 515: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 257
	i64 13961013029440053076, ; 516: MailKit => 0xc1bf7b61b45fdf54 => 174
	i64 14075334701871371868, ; 517: System.ServiceModel.Web.dll => 0xc355a25647c5965c => 130
	i64 14100563506285742564, ; 518: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 315
	i64 14124974489674258913, ; 519: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 239
	i64 14125464355221830302, ; 520: System.Threading.dll => 0xc407bafdbc707a9e => 147
	i64 14178052285788134900, ; 521: Xamarin.Android.Glide.Annotations.dll => 0xc4c28f6f75511df4 => 226
	i64 14212104595480609394, ; 522: System.Security.Cryptography.Cng.dll => 0xc53b89d4a4518272 => 119
	i64 14220608275227875801, ; 523: System.Diagnostics.FileVersionInfo.dll => 0xc559bfe1def019d9 => 27
	i64 14226382999226559092, ; 524: System.ServiceProcess => 0xc56e43f6938e2a74 => 131
	i64 14232023429000439693, ; 525: System.Resources.Writer.dll => 0xc5824de7789ba78d => 99
	i64 14254574811015963973, ; 526: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 133
	i64 14261073672896646636, ; 527: Xamarin.AndroidX.Print => 0xc5e982f274ae0dec => 277
	i64 14261232074598307362, ; 528: Microsoft.AspNetCore.Mvc.Abstractions => 0xc5ea130339d6d622 => 186
	i64 14298246716367104064, ; 529: System.Web.dll => 0xc66d93a217f4e840 => 152
	i64 14327695147300244862, ; 530: System.Reflection.dll => 0xc6d632d338eb4d7e => 96
	i64 14327709162229390963, ; 531: System.Security.Cryptography.X509Certificates => 0xc6d63f9253cade73 => 124
	i64 14331727281556788554, ; 532: Xamarin.Android.Glide.DiskLruCache.dll => 0xc6e48607a2f7954a => 227
	i64 14346402571976470310, ; 533: System.Net.Ping.dll => 0xc718a920f3686f26 => 68
	i64 14461014870687870182, ; 534: System.Net.Requests.dll => 0xc8afd8683afdece6 => 71
	i64 14464374589798375073, ; 535: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 336
	i64 14486659737292545672, ; 536: Xamarin.AndroidX.Lifecycle.LiveData => 0xc90af44707469e88 => 262
	i64 14495724990987328804, ; 537: Xamarin.AndroidX.ResourceInspection.Annotation => 0xc92b2913e18d5d24 => 280
	i64 14522721392235705434, ; 538: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 317
	i64 14528548208938697926, ; 539: Microsoft.AspNetCore.Mvc.Abstractions.dll => 0xc99fc59ed7edc4c6 => 186
	i64 14551742072151931844, ; 540: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 135
	i64 14561513370130550166, ; 541: System.Security.Cryptography.Primitives.dll => 0xca14e3428abb8d96 => 123
	i64 14574160591280636898, ; 542: System.Net.Quic => 0xca41d1d72ec783e2 => 70
	i64 14622043554576106986, ; 543: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 110
	i64 14644440854989303794, ; 544: Xamarin.AndroidX.LocalBroadcastManager.dll => 0xcb3b815e37daeff2 => 272
	i64 14669215534098758659, ; 545: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 197
	i64 14690985099581930927, ; 546: System.Web.HttpUtility => 0xcbe0dd1ca5233daf => 151
	i64 14705122255218365489, ; 547: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 328
	i64 14744092281598614090, ; 548: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 344
	i64 14792063746108907174, ; 549: Xamarin.Google.Guava.ListenableFuture.dll => 0xcd47f79af9c15ea6 => 300
	i64 14832630590065248058, ; 550: System.Security.Claims => 0xcdd816ef5d6e873a => 117
	i64 14852515768018889994, ; 551: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 248
	i64 14889905118082851278, ; 552: GoogleGson.dll => 0xcea391d0969961ce => 173
	i64 14892012299694389861, ; 553: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 345
	i64 14904040806490515477, ; 554: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 312
	i64 14912225920358050525, ; 555: System.Security.Principal.Windows => 0xcef2de7759506add => 126
	i64 14935719434541007538, ; 556: System.Text.Encoding.CodePages.dll => 0xcf4655b160b702b2 => 132
	i64 14954917835170835695, ; 557: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 198
	i64 14984936317414011727, ; 558: System.Net.WebHeaderCollection => 0xcff5302fe54ff34f => 76
	i64 14987728460634540364, ; 559: System.IO.Compression.dll => 0xcfff1ba06622494c => 45
	i64 14988210264188246988, ; 560: Xamarin.AndroidX.DocumentFile => 0xd000d1d307cddbcc => 251
	i64 15015154896917945444, ; 561: System.Net.Security.dll => 0xd0608bd33642dc64 => 72
	i64 15024878362326791334, ; 562: System.Net.Http.Json => 0xd0831743ebf0f4a6 => 62
	i64 15051741671811457419, ; 563: Microsoft.Extensions.Diagnostics.Abstractions.dll => 0xd0e2874d8f44218b => 201
	i64 15071021337266399595, ; 564: System.Resources.Reader.dll => 0xd127060e7a18a96b => 97
	i64 15076659072870671916, ; 565: System.ObjectModel.dll => 0xd13b0d8c1620662c => 83
	i64 15111608613780139878, ; 566: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 329
	i64 15115185479366240210, ; 567: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 42
	i64 15133485256822086103, ; 568: System.Linq.dll => 0xd204f0a9127dd9d7 => 60
	i64 15150743910298169673, ; 569: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xd2424150783c3149 => 278
	i64 15227001540531775957, ; 570: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 195
	i64 15234786388537674379, ; 571: System.Dynamic.Runtime.dll => 0xd36cd580c5be8a8b => 36
	i64 15250465174479574862, ; 572: System.Globalization.Calendars.dll => 0xd3a489469852174e => 39
	i64 15272359115529052076, ; 573: Xamarin.AndroidX.Collection.Ktx => 0xd3f251b2fb4edfac => 241
	i64 15279429628684179188, ; 574: Xamarin.KotlinX.Coroutines.Android.dll => 0xd40b704b1c4c96f4 => 310
	i64 15299439993936780255, ; 575: System.Xml.XPath.dll => 0xd452879d55019bdf => 159
	i64 15338463749992804988, ; 576: System.Resources.Reader => 0xd4dd2b839286f27c => 97
	i64 15370334346939861994, ; 577: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 246
	i64 15391712275433856905, ; 578: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 198
	i64 15526743539506359484, ; 579: System.Text.Encoding.dll => 0xd77a12fc26de2cbc => 134
	i64 15527772828719725935, ; 580: System.Console => 0xd77dbb1e38cd3d6f => 20
	i64 15530465045505749832, ; 581: System.Net.HttpListener.dll => 0xd7874bacc9fdb348 => 64
	i64 15536481058354060254, ; 582: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 316
	i64 15541854775306130054, ; 583: System.Security.Cryptography.X509Certificates.dll => 0xd7afc292e8d49286 => 124
	i64 15557562860424774966, ; 584: System.Net.Sockets => 0xd7e790fe7a6dc536 => 74
	i64 15565247197164990907, ; 585: Microsoft.AspNetCore.Http.Extensions => 0xd802dddb8c29f1bb => 183
	i64 15582737692548360875, ; 586: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 270
	i64 15592226634512578529, ; 587: Microsoft.AspNetCore.Authorization.dll => 0xd862b7834f81b7e1 => 177
	i64 15609085926864131306, ; 588: System.dll => 0xd89e9cf3334914ea => 163
	i64 15620595871140898079, ; 589: Microsoft.Extensions.DependencyModel => 0xd8c7812eef49651f => 199
	i64 15620612276725577442, ; 590: BouncyCastle.Cryptography.dll => 0xd8c7901aa85576e2 => 172
	i64 15661133872274321916, ; 591: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 155
	i64 15664356999916475676, ; 592: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 316
	i64 15710114879900314733, ; 593: Microsoft.Win32.Registry => 0xda058a3f5d096c6d => 5
	i64 15743187114543869802, ; 594: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 324
	i64 15755368083429170162, ; 595: System.IO.FileSystem.Primitives => 0xdaa64fcbde529bf2 => 48
	i64 15777549416145007739, ; 596: Xamarin.AndroidX.SlidingPaneLayout.dll => 0xdaf51d99d77eb47b => 284
	i64 15783653065526199428, ; 597: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 317
	i64 15817206913877585035, ; 598: System.Threading.Tasks.dll => 0xdb8201e29086ac8b => 143
	i64 15847085070278954535, ; 599: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 138
	i64 15852824340364052161, ; 600: Microsoft.AspNetCore.Http.Features.dll => 0xdc008bbee610c6c1 => 184
	i64 15885744048853936810, ; 601: System.Resources.Writer => 0xdc75800bd0b6eaaa => 99
	i64 15928521404965645318, ; 602: Microsoft.Maui.Controls.Compatibility => 0xdd0d79d32c2eec06 => 212
	i64 15930129725311349754, ; 603: Xamarin.GooglePlayServices.Tasks.dll => 0xdd1330956f12f3fa => 304
	i64 15934062614519587357, ; 604: System.Security.Cryptography.OpenSsl => 0xdd2129868f45a21d => 122
	i64 15937190497610202713, ; 605: System.Security.Cryptography.Cng => 0xdd2c465197c97e59 => 119
	i64 15963349826457351533, ; 606: System.Threading.Tasks.Extensions => 0xdd893616f748b56d => 141
	i64 15971679995444160383, ; 607: System.Formats.Tar.dll => 0xdda6ce5592a9677f => 38
	i64 16018552496348375205, ; 608: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 67
	i64 16046481083542319511, ; 609: Microsoft.Extensions.ObjectPool => 0xdeb08d870f90b197 => 208
	i64 16054465462676478687, ; 610: System.Globalization.Extensions => 0xdecceb47319bdadf => 40
	i64 16154507427712707110, ; 611: System => 0xe03056ea4e39aa26 => 163
	i64 16182611612321266217, ; 612: Microsoft.Maui.Maps => 0xe0942f85b2853a29 => 219
	i64 16219561732052121626, ; 613: System.Net.Security => 0xe1177575db7c781a => 72
	i64 16288847719894691167, ; 614: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 330
	i64 16315482530584035869, ; 615: WindowsBase.dll => 0xe26c3ceb1e8d821d => 164
	i64 16321164108206115771, ; 616: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 206
	i64 16337011941688632206, ; 617: System.Security.Principal.Windows.dll => 0xe2b8b9cdc3aa638e => 126
	i64 16344871930018146979, ; 618: Microsoft.AspNetCore.ResponseCaching.Abstractions => 0xe2d4a66be7fc2aa3 => 189
	i64 16361933716545543812, ; 619: Xamarin.AndroidX.ExifInterface.dll => 0xe3114406a52f1e84 => 256
	i64 16423015068819898779, ; 620: Xamarin.Kotlin.StdLib.Jdk8 => 0xe3ea453135e5c19b => 309
	i64 16454459195343277943, ; 621: System.Net.NetworkInformation => 0xe459fb756d988f77 => 67
	i64 16496768397145114574, ; 622: Mono.Android.Export.dll => 0xe4f04b741db987ce => 168
	i64 16558262036769511634, ; 623: Microsoft.Extensions.Http => 0xe5cac397cf7b98d2 => 204
	i64 16589693266713801121, ; 624: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xe63a6e214f2a71a1 => 269
	i64 16621146507174665210, ; 625: Xamarin.AndroidX.ConstraintLayout => 0xe6aa2caf87dedbfa => 243
	i64 16649148416072044166, ; 626: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 218
	i64 16677317093839702854, ; 627: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 276
	i64 16702652415771857902, ; 628: System.ValueTuple => 0xe7cbbde0b0e6d3ee => 150
	i64 16709499819875633724, ; 629: System.IO.Compression.ZipFile => 0xe7e4118e32240a3c => 44
	i64 16737807731308835127, ; 630: System.Runtime.Intrinsics => 0xe848a3736f733137 => 107
	i64 16758309481308491337, ; 631: System.IO.FileSystem.DriveInfo => 0xe89179af15740e49 => 47
	i64 16762783179241323229, ; 632: System.Reflection.TypeExtensions => 0xe8a15e7d0d927add => 95
	i64 16765015072123548030, ; 633: System.Diagnostics.TextWriterTraceListener.dll => 0xe8a94c621bfe717e => 30
	i64 16822611501064131242, ; 634: System.Data.DataSetExtensions => 0xe975ec07bb5412aa => 23
	i64 16833383113903931215, ; 635: mscorlib => 0xe99c30c1484d7f4f => 165
	i64 16856067890322379635, ; 636: System.Data.Common.dll => 0xe9ecc87060889373 => 22
	i64 16890310621557459193, ; 637: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 137
	i64 16933958494752847024, ; 638: System.Net.WebProxy.dll => 0xeb018187f0f3b4b0 => 77
	i64 16942731696432749159, ; 639: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 337
	i64 16977952268158210142, ; 640: System.IO.Pipes.AccessControl => 0xeb9dcda2851b905e => 53
	i64 16989020923549080504, ; 641: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xebc52084add25bb8 => 269
	i64 16998075588627545693, ; 642: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 274
	i64 17008137082415910100, ; 643: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 10
	i64 17024911836938395553, ; 644: Xamarin.AndroidX.Annotation.Experimental.dll => 0xec44a31d250e5fa1 => 232
	i64 17026344819618783825, ; 645: Microsoft.VisualStudio.DesignTools.TapContract.dll => 0xec49ba676cb0a251 => 348
	i64 17027804579603049667, ; 646: Microsoft.Maui.Controls.Maps.dll => 0xec4eea0c48026cc3 => 214
	i64 17031351772568316411, ; 647: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 273
	i64 17037200463775726619, ; 648: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xec704b8e0a78fc1b => 260
	i64 17062143951396181894, ; 649: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 16
	i64 17089008752050867324, ; 650: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 344
	i64 17118171214553292978, ; 651: System.Threading.Channels => 0xed8ff6060fc420b2 => 138
	i64 17126545051278881272, ; 652: Microsoft.Net.Http.Headers.dll => 0xedadb5fbdb33b1f8 => 220
	i64 17187273293601214786, ; 653: System.ComponentModel.Annotations.dll => 0xee8575ff9aa89142 => 13
	i64 17201328579425343169, ; 654: System.ComponentModel.EventBasedAsync => 0xeeb76534d96c16c1 => 15
	i64 17202182880784296190, ; 655: System.Security.Cryptography.Encoding.dll => 0xeeba6e30627428fe => 121
	i64 17230721278011714856, ; 656: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 86
	i64 17234219099804750107, ; 657: System.Transactions.Local.dll => 0xef2c3ef5e11d511b => 148
	i64 17260702271250283638, ; 658: System.Data.Common => 0xef8a5543bba6bc76 => 22
	i64 17311256152179951039, ; 659: Microsoft.AspNetCore.Mvc.Formatters.Json => 0xf03defc05e7b45bf => 188
	i64 17333249706306540043, ; 660: System.Diagnostics.Tracing.dll => 0xf08c12c5bb8b920b => 33
	i64 17338386382517543202, ; 661: System.Net.WebSockets.Client.dll => 0xf09e528d5c6da122 => 78
	i64 17342750010158924305, ; 662: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 322
	i64 17360349973592121190, ; 663: Xamarin.Google.Crypto.Tink.Android => 0xf0ec5a52686b9f66 => 298
	i64 17438153253682247751, ; 664: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 337
	i64 17470386307322966175, ; 665: System.Threading.Timer => 0xf27347c8d0d5709f => 146
	i64 17509662556995089465, ; 666: System.Net.WebSockets.dll => 0xf2fed1534ea67439 => 79
	i64 17514990004910432069, ; 667: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 320
	i64 17522591619082469157, ; 668: GoogleGson => 0xf32cc03d27a5bf25 => 173
	i64 17590473451926037903, ; 669: Xamarin.Android.Glide => 0xf41dea67fcfda58f => 225
	i64 17623389608345532001, ; 670: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 332
	i64 17627500474728259406, ; 671: System.Globalization => 0xf4a176498a351f4e => 41
	i64 17685921127322830888, ; 672: System.Diagnostics.Debug.dll => 0xf571038fafa74828 => 26
	i64 17702523067201099846, ; 673: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 343
	i64 17704177640604968747, ; 674: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 271
	i64 17710060891934109755, ; 675: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 268
	i64 17712670374920797664, ; 676: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 106
	i64 17777860260071588075, ; 677: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 109
	i64 17838668724098252521, ; 678: System.Buffers.dll => 0xf78faeb0f5bf3ee9 => 7
	i64 17891337867145587222, ; 679: Xamarin.Jetbrains.Annotations => 0xf84accff6fb52a16 => 305
	i64 17911643751311784505, ; 680: Microsoft.Net.Http.Headers => 0xf892f1178448ba39 => 220
	i64 17928294245072900555, ; 681: System.IO.Compression.FileSystem.dll => 0xf8ce18a0b24011cb => 43
	i64 17969331831154222830, ; 682: Xamarin.GooglePlayServices.Maps => 0xf95fe418471126ee => 303
	i64 17986907704309214542, ; 683: Xamarin.GooglePlayServices.Basement.dll => 0xf99e554223166d4e => 302
	i64 17992315986609351877, ; 684: System.Xml.XmlDocument.dll => 0xf9b18c0ffc6eacc5 => 160
	i64 18025913125965088385, ; 685: System.Threading => 0xfa28e87b91334681 => 147
	i64 18099568558057551825, ; 686: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 331
	i64 18116111925905154859, ; 687: Xamarin.AndroidX.Arch.Core.Runtime => 0xfb695bd036cb632b => 237
	i64 18121036031235206392, ; 688: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 273
	i64 18146411883821974900, ; 689: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 37
	i64 18146811631844267958, ; 690: System.ComponentModel.EventBasedAsync.dll => 0xfbd66d08820117b6 => 15
	i64 18203743254473369877, ; 691: System.Security.Cryptography.Pkcs.dll => 0xfca0b00ad94c6915 => 224
	i64 18225059387460068507, ; 692: System.Threading.ThreadPool.dll => 0xfcec6af3cff4a49b => 145
	i64 18245806341561545090, ; 693: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 8
	i64 18260797123374478311, ; 694: Xamarin.AndroidX.Emoji2 => 0xfd6b623bde35f3e7 => 254
	i64 18305135509493619199, ; 695: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 275
	i64 18318849532986632368, ; 696: System.Security.dll => 0xfe39a097c37fa8b0 => 129
	i64 18324163916253801303, ; 697: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 326
	i64 18380184030268848184, ; 698: Xamarin.AndroidX.VersionedParcelable => 0xff1387fe3e7b7838 => 291
	i64 18439108438687598470 ; 699: System.Reflection.Metadata.dll => 0xffe4df6e2ee1c786 => 93
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [700 x i32] [
	i32 193, ; 0
	i32 253, ; 1
	i32 211, ; 2
	i32 170, ; 3
	i32 217, ; 4
	i32 203, ; 5
	i32 57, ; 6
	i32 240, ; 7
	i32 150, ; 8
	i32 281, ; 9
	i32 284, ; 10
	i32 247, ; 11
	i32 131, ; 12
	i32 210, ; 13
	i32 348, ; 14
	i32 55, ; 15
	i32 283, ; 16
	i32 208, ; 17
	i32 319, ; 18
	i32 94, ; 19
	i32 219, ; 20
	i32 266, ; 21
	i32 128, ; 22
	i32 196, ; 23
	i32 301, ; 24
	i32 144, ; 25
	i32 241, ; 26
	i32 18, ; 27
	i32 322, ; 28
	i32 252, ; 29
	i32 267, ; 30
	i32 149, ; 31
	i32 103, ; 32
	i32 189, ; 33
	i32 176, ; 34
	i32 94, ; 35
	i32 296, ; 36
	i32 330, ; 37
	i32 35, ; 38
	i32 27, ; 39
	i32 236, ; 40
	i32 274, ; 41
	i32 49, ; 42
	i32 114, ; 43
	i32 69, ; 44
	i32 213, ; 45
	i32 64, ; 46
	i32 169, ; 47
	i32 144, ; 48
	i32 328, ; 49
	i32 0, ; 50
	i32 295, ; 51
	i32 235, ; 52
	i32 270, ; 53
	i32 260, ; 54
	i32 39, ; 55
	i32 88, ; 56
	i32 80, ; 57
	i32 222, ; 58
	i32 65, ; 59
	i32 61, ; 60
	i32 85, ; 61
	i32 234, ; 62
	i32 105, ; 63
	i32 318, ; 64
	i32 281, ; 65
	i32 101, ; 66
	i32 34, ; 67
	i32 231, ; 68
	i32 340, ; 69
	i32 283, ; 70
	i32 215, ; 71
	i32 340, ; 72
	i32 221, ; 73
	i32 118, ; 74
	i32 268, ; 75
	i32 314, ; 76
	i32 332, ; 77
	i32 141, ; 78
	i32 140, ; 79
	i32 308, ; 80
	i32 52, ; 81
	i32 34, ; 82
	i32 140, ; 83
	i32 222, ; 84
	i32 228, ; 85
	i32 238, ; 86
	i32 207, ; 87
	i32 252, ; 88
	i32 8, ; 89
	i32 14, ; 90
	i32 336, ; 91
	i32 280, ; 92
	i32 50, ; 93
	i32 263, ; 94
	i32 135, ; 95
	i32 100, ; 96
	i32 245, ; 97
	i32 290, ; 98
	i32 115, ; 99
	i32 229, ; 100
	i32 162, ; 101
	i32 339, ; 102
	i32 165, ; 103
	i32 66, ; 104
	i32 197, ; 105
	i32 314, ; 106
	i32 79, ; 107
	i32 100, ; 108
	i32 285, ; 109
	i32 116, ; 110
	i32 319, ; 111
	i32 297, ; 112
	i32 188, ; 113
	i32 77, ; 114
	i32 296, ; 115
	i32 178, ; 116
	i32 347, ; 117
	i32 113, ; 118
	i32 120, ; 119
	i32 47, ; 120
	i32 203, ; 121
	i32 177, ; 122
	i32 127, ; 123
	i32 261, ; 124
	i32 232, ; 125
	i32 81, ; 126
	i32 109, ; 127
	i32 74, ; 128
	i32 311, ; 129
	i32 202, ; 130
	i32 302, ; 131
	i32 217, ; 132
	i32 52, ; 133
	i32 287, ; 134
	i32 194, ; 135
	i32 68, ; 136
	i32 286, ; 137
	i32 82, ; 138
	i32 171, ; 139
	i32 334, ; 140
	i32 115, ; 141
	i32 195, ; 142
	i32 155, ; 143
	i32 194, ; 144
	i32 226, ; 145
	i32 166, ; 146
	i32 279, ; 147
	i32 253, ; 148
	i32 205, ; 149
	i32 31, ; 150
	i32 215, ; 151
	i32 121, ; 152
	i32 71, ; 153
	i32 61, ; 154
	i32 160, ; 155
	i32 112, ; 156
	i32 87, ; 157
	i32 212, ; 158
	i32 345, ; 159
	i32 104, ; 160
	i32 18, ; 161
	i32 145, ; 162
	i32 117, ; 163
	i32 57, ; 164
	i32 247, ; 165
	i32 17, ; 166
	i32 175, ; 167
	i32 51, ; 168
	i32 183, ; 169
	i32 304, ; 170
	i32 179, ; 171
	i32 91, ; 172
	i32 347, ; 173
	i32 342, ; 174
	i32 54, ; 175
	i32 346, ; 176
	i32 128, ; 177
	i32 151, ; 178
	i32 40, ; 179
	i32 91, ; 180
	i32 291, ; 181
	i32 204, ; 182
	i32 49, ; 183
	i32 312, ; 184
	i32 161, ; 185
	i32 13, ; 186
	i32 265, ; 187
	i32 229, ; 188
	i32 286, ; 189
	i32 35, ; 190
	i32 66, ; 191
	i32 108, ; 192
	i32 230, ; 193
	i32 98, ; 194
	i32 98, ; 195
	i32 11, ; 196
	i32 192, ; 197
	i32 181, ; 198
	i32 11, ; 199
	i32 272, ; 200
	i32 25, ; 201
	i32 127, ; 202
	i32 75, ; 203
	i32 264, ; 204
	i32 108, ; 205
	i32 290, ; 206
	i32 174, ; 207
	i32 288, ; 208
	i32 105, ; 209
	i32 2, ; 210
	i32 26, ; 211
	i32 243, ; 212
	i32 156, ; 213
	i32 338, ; 214
	i32 21, ; 215
	i32 341, ; 216
	i32 48, ; 217
	i32 42, ; 218
	i32 125, ; 219
	i32 214, ; 220
	i32 233, ; 221
	i32 58, ; 222
	i32 190, ; 223
	i32 176, ; 224
	i32 118, ; 225
	i32 293, ; 226
	i32 256, ; 227
	i32 242, ; 228
	i32 3, ; 229
	i32 262, ; 230
	i32 282, ; 231
	i32 37, ; 232
	i32 123, ; 233
	i32 200, ; 234
	i32 335, ; 235
	i32 282, ; 236
	i32 335, ; 237
	i32 136, ; 238
	i32 148, ; 239
	i32 84, ; 240
	i32 89, ; 241
	i32 266, ; 242
	i32 349, ; 243
	i32 263, ; 244
	i32 221, ; 245
	i32 185, ; 246
	i32 323, ; 247
	i32 238, ; 248
	i32 249, ; 249
	i32 294, ; 250
	i32 209, ; 251
	i32 299, ; 252
	i32 264, ; 253
	i32 132, ; 254
	i32 95, ; 255
	i32 3, ; 256
	i32 331, ; 257
	i32 104, ; 258
	i32 334, ; 259
	i32 32, ; 260
	i32 153, ; 261
	i32 157, ; 262
	i32 154, ; 263
	i32 81, ; 264
	i32 180, ; 265
	i32 258, ; 266
	i32 142, ; 267
	i32 86, ; 268
	i32 19, ; 269
	i32 259, ; 270
	i32 224, ; 271
	i32 50, ; 272
	i32 303, ; 273
	i32 228, ; 274
	i32 338, ; 275
	i32 60, ; 276
	i32 53, ; 277
	i32 4, ; 278
	i32 181, ; 279
	i32 96, ; 280
	i32 227, ; 281
	i32 17, ; 282
	i32 193, ; 283
	i32 154, ; 284
	i32 83, ; 285
	i32 28, ; 286
	i32 44, ; 287
	i32 63, ; 288
	i32 65, ; 289
	i32 329, ; 290
	i32 171, ; 291
	i32 267, ; 292
	i32 1, ; 293
	i32 306, ; 294
	i32 46, ; 295
	i32 24, ; 296
	i32 178, ; 297
	i32 235, ; 298
	i32 201, ; 299
	i32 164, ; 300
	i32 107, ; 301
	i32 12, ; 302
	i32 261, ; 303
	i32 62, ; 304
	i32 223, ; 305
	i32 23, ; 306
	i32 92, ; 307
	i32 167, ; 308
	i32 12, ; 309
	i32 310, ; 310
	i32 218, ; 311
	i32 28, ; 312
	i32 102, ; 313
	i32 14, ; 314
	i32 125, ; 315
	i32 244, ; 316
	i32 276, ; 317
	i32 90, ; 318
	i32 265, ; 319
	i32 9, ; 320
	i32 187, ; 321
	i32 85, ; 322
	i32 255, ; 323
	i32 288, ; 324
	i32 180, ; 325
	i32 333, ; 326
	i32 70, ; 327
	i32 167, ; 328
	i32 1, ; 329
	i32 275, ; 330
	i32 5, ; 331
	i32 333, ; 332
	i32 43, ; 333
	i32 223, ; 334
	i32 200, ; 335
	i32 307, ; 336
	i32 157, ; 337
	i32 278, ; 338
	i32 111, ; 339
	i32 343, ; 340
	i32 120, ; 341
	i32 172, ; 342
	i32 293, ; 343
	i32 234, ; 344
	i32 179, ; 345
	i32 158, ; 346
	i32 130, ; 347
	i32 298, ; 348
	i32 56, ; 349
	i32 137, ; 350
	i32 82, ; 351
	i32 29, ; 352
	i32 245, ; 353
	i32 10, ; 354
	i32 295, ; 355
	i32 170, ; 356
	i32 242, ; 357
	i32 149, ; 358
	i32 93, ; 359
	i32 301, ; 360
	i32 255, ; 361
	i32 59, ; 362
	i32 190, ; 363
	i32 216, ; 364
	i32 156, ; 365
	i32 318, ; 366
	i32 207, ; 367
	i32 63, ; 368
	i32 87, ; 369
	i32 78, ; 370
	i32 46, ; 371
	i32 213, ; 372
	i32 142, ; 373
	i32 315, ; 374
	i32 196, ; 375
	i32 308, ; 376
	i32 249, ; 377
	i32 73, ; 378
	i32 182, ; 379
	i32 90, ; 380
	i32 346, ; 381
	i32 305, ; 382
	i32 134, ; 383
	i32 89, ; 384
	i32 287, ; 385
	i32 311, ; 386
	i32 246, ; 387
	i32 191, ; 388
	i32 313, ; 389
	i32 111, ; 390
	i32 41, ; 391
	i32 158, ; 392
	i32 4, ; 393
	i32 102, ; 394
	i32 69, ; 395
	i32 210, ; 396
	i32 59, ; 397
	i32 38, ; 398
	i32 236, ; 399
	i32 152, ; 400
	i32 55, ; 401
	i32 33, ; 402
	i32 206, ; 403
	i32 216, ; 404
	i32 233, ; 405
	i32 21, ; 406
	i32 162, ; 407
	i32 184, ; 408
	i32 299, ; 409
	i32 324, ; 410
	i32 297, ; 411
	i32 292, ; 412
	i32 139, ; 413
	i32 327, ; 414
	i32 209, ; 415
	i32 88, ; 416
	i32 146, ; 417
	i32 248, ; 418
	i32 161, ; 419
	i32 277, ; 420
	i32 6, ; 421
	i32 168, ; 422
	i32 30, ; 423
	i32 106, ; 424
	i32 258, ; 425
	i32 325, ; 426
	i32 292, ; 427
	i32 205, ; 428
	i32 231, ; 429
	i32 285, ; 430
	i32 166, ; 431
	i32 259, ; 432
	i32 139, ; 433
	i32 321, ; 434
	i32 58, ; 435
	i32 143, ; 436
	i32 80, ; 437
	i32 73, ; 438
	i32 129, ; 439
	i32 25, ; 440
	i32 7, ; 441
	i32 92, ; 442
	i32 289, ; 443
	i32 136, ; 444
	i32 225, ; 445
	i32 112, ; 446
	i32 9, ; 447
	i32 103, ; 448
	i32 19, ; 449
	i32 175, ; 450
	i32 257, ; 451
	i32 271, ; 452
	i32 349, ; 453
	i32 251, ; 454
	i32 32, ; 455
	i32 239, ; 456
	i32 45, ; 457
	i32 326, ; 458
	i32 29, ; 459
	i32 240, ; 460
	i32 56, ; 461
	i32 133, ; 462
	i32 113, ; 463
	i32 294, ; 464
	i32 339, ; 465
	i32 309, ; 466
	i32 54, ; 467
	i32 211, ; 468
	i32 6, ; 469
	i32 0, ; 470
	i32 76, ; 471
	i32 250, ; 472
	i32 110, ; 473
	i32 185, ; 474
	i32 254, ; 475
	i32 101, ; 476
	i32 313, ; 477
	i32 327, ; 478
	i32 191, ; 479
	i32 169, ; 480
	i32 114, ; 481
	i32 321, ; 482
	i32 289, ; 483
	i32 244, ; 484
	i32 182, ; 485
	i32 75, ; 486
	i32 300, ; 487
	i32 84, ; 488
	i32 306, ; 489
	i32 341, ; 490
	i32 237, ; 491
	i32 342, ; 492
	i32 325, ; 493
	i32 202, ; 494
	i32 279, ; 495
	i32 159, ; 496
	i32 2, ; 497
	i32 187, ; 498
	i32 250, ; 499
	i32 24, ; 500
	i32 230, ; 501
	i32 31, ; 502
	i32 116, ; 503
	i32 36, ; 504
	i32 16, ; 505
	i32 320, ; 506
	i32 51, ; 507
	i32 323, ; 508
	i32 307, ; 509
	i32 20, ; 510
	i32 122, ; 511
	i32 192, ; 512
	i32 153, ; 513
	i32 199, ; 514
	i32 257, ; 515
	i32 174, ; 516
	i32 130, ; 517
	i32 315, ; 518
	i32 239, ; 519
	i32 147, ; 520
	i32 226, ; 521
	i32 119, ; 522
	i32 27, ; 523
	i32 131, ; 524
	i32 99, ; 525
	i32 133, ; 526
	i32 277, ; 527
	i32 186, ; 528
	i32 152, ; 529
	i32 96, ; 530
	i32 124, ; 531
	i32 227, ; 532
	i32 68, ; 533
	i32 71, ; 534
	i32 336, ; 535
	i32 262, ; 536
	i32 280, ; 537
	i32 317, ; 538
	i32 186, ; 539
	i32 135, ; 540
	i32 123, ; 541
	i32 70, ; 542
	i32 110, ; 543
	i32 272, ; 544
	i32 197, ; 545
	i32 151, ; 546
	i32 328, ; 547
	i32 344, ; 548
	i32 300, ; 549
	i32 117, ; 550
	i32 248, ; 551
	i32 173, ; 552
	i32 345, ; 553
	i32 312, ; 554
	i32 126, ; 555
	i32 132, ; 556
	i32 198, ; 557
	i32 76, ; 558
	i32 45, ; 559
	i32 251, ; 560
	i32 72, ; 561
	i32 62, ; 562
	i32 201, ; 563
	i32 97, ; 564
	i32 83, ; 565
	i32 329, ; 566
	i32 42, ; 567
	i32 60, ; 568
	i32 278, ; 569
	i32 195, ; 570
	i32 36, ; 571
	i32 39, ; 572
	i32 241, ; 573
	i32 310, ; 574
	i32 159, ; 575
	i32 97, ; 576
	i32 246, ; 577
	i32 198, ; 578
	i32 134, ; 579
	i32 20, ; 580
	i32 64, ; 581
	i32 316, ; 582
	i32 124, ; 583
	i32 74, ; 584
	i32 183, ; 585
	i32 270, ; 586
	i32 177, ; 587
	i32 163, ; 588
	i32 199, ; 589
	i32 172, ; 590
	i32 155, ; 591
	i32 316, ; 592
	i32 5, ; 593
	i32 324, ; 594
	i32 48, ; 595
	i32 284, ; 596
	i32 317, ; 597
	i32 143, ; 598
	i32 138, ; 599
	i32 184, ; 600
	i32 99, ; 601
	i32 212, ; 602
	i32 304, ; 603
	i32 122, ; 604
	i32 119, ; 605
	i32 141, ; 606
	i32 38, ; 607
	i32 67, ; 608
	i32 208, ; 609
	i32 40, ; 610
	i32 163, ; 611
	i32 219, ; 612
	i32 72, ; 613
	i32 330, ; 614
	i32 164, ; 615
	i32 206, ; 616
	i32 126, ; 617
	i32 189, ; 618
	i32 256, ; 619
	i32 309, ; 620
	i32 67, ; 621
	i32 168, ; 622
	i32 204, ; 623
	i32 269, ; 624
	i32 243, ; 625
	i32 218, ; 626
	i32 276, ; 627
	i32 150, ; 628
	i32 44, ; 629
	i32 107, ; 630
	i32 47, ; 631
	i32 95, ; 632
	i32 30, ; 633
	i32 23, ; 634
	i32 165, ; 635
	i32 22, ; 636
	i32 137, ; 637
	i32 77, ; 638
	i32 337, ; 639
	i32 53, ; 640
	i32 269, ; 641
	i32 274, ; 642
	i32 10, ; 643
	i32 232, ; 644
	i32 348, ; 645
	i32 214, ; 646
	i32 273, ; 647
	i32 260, ; 648
	i32 16, ; 649
	i32 344, ; 650
	i32 138, ; 651
	i32 220, ; 652
	i32 13, ; 653
	i32 15, ; 654
	i32 121, ; 655
	i32 86, ; 656
	i32 148, ; 657
	i32 22, ; 658
	i32 188, ; 659
	i32 33, ; 660
	i32 78, ; 661
	i32 322, ; 662
	i32 298, ; 663
	i32 337, ; 664
	i32 146, ; 665
	i32 79, ; 666
	i32 320, ; 667
	i32 173, ; 668
	i32 225, ; 669
	i32 332, ; 670
	i32 41, ; 671
	i32 26, ; 672
	i32 343, ; 673
	i32 271, ; 674
	i32 268, ; 675
	i32 106, ; 676
	i32 109, ; 677
	i32 7, ; 678
	i32 305, ; 679
	i32 220, ; 680
	i32 43, ; 681
	i32 303, ; 682
	i32 302, ; 683
	i32 160, ; 684
	i32 147, ; 685
	i32 331, ; 686
	i32 237, ; 687
	i32 273, ; 688
	i32 37, ; 689
	i32 15, ; 690
	i32 224, ; 691
	i32 145, ; 692
	i32 8, ; 693
	i32 254, ; 694
	i32 275, ; 695
	i32 129, ; 696
	i32 326, ; 697
	i32 291, ; 698
	i32 93 ; 699
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

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
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
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
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" }

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ df9aaf29a52042a4fbf800daf2f3a38964b9e958"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
