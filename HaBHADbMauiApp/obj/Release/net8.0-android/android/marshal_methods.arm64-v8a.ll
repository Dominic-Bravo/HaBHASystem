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

@assembly_image_cache = dso_local local_unnamed_addr global [197 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [394 x i64] [
	i64 15690660930947125, ; 0: Microsoft.DotNet.PlatformAbstractions.dll => 0x37be92af148835 => 54
	i64 98382396393917666, ; 1: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 69
	i64 120698629574877762, ; 2: Mono.Android => 0x1accec39cafe242 => 196
	i64 131669012237370309, ; 3: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 74
	i64 160518225272466977, ; 4: Microsoft.Extensions.Hosting.Abstractions => 0x23a4679b5576e21 => 63
	i64 196720943101637631, ; 5: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 138
	i64 210515253464952879, ; 6: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 84
	i64 232391251801502327, ; 7: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 101
	i64 435118502366263740, ; 8: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x609d9f8f8bdb9bc => 102
	i64 535107122908063503, ; 9: Microsoft.Extensions.ObjectPool.dll => 0x76d1517d9b7670f => 67
	i64 545109961164950392, ; 10: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 7
	i64 560278790331054453, ; 11: System.Reflection.Primitives => 0x7c6829760de3975 => 159
	i64 590337075967009532, ; 12: Microsoft.Maui.Maps.dll => 0x8314c715ec1a2fc => 76
	i64 687654259221141486, ; 13: Xamarin.GooglePlayServices.Base => 0x98b09e7c92917ee => 108
	i64 750875890346172408, ; 14: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 186
	i64 799765834175365804, ; 15: System.ComponentModel.dll => 0xb1956c9f18442ac => 125
	i64 849051935479314978, ; 16: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 10
	i64 872800313462103108, ; 17: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 89
	i64 982068613551266738, ; 18: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll => 0xda1023367c89bb2 => 50
	i64 1001381392624924420, ; 19: Microsoft.AspNetCore.Authentication.Core.dll => 0xde59f1230183704 => 37
	i64 1010599046655515943, ; 20: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 159
	i64 1120440138749646132, ; 21: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 106
	i64 1121665720830085036, ; 22: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 18
	i64 1268860745194512059, ; 23: System.Drawing.dll => 0x119be62002c19ebb => 131
	i64 1369545283391376210, ; 24: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 97
	i64 1476839205573959279, ; 25: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 146
	i64 1486715745332614827, ; 26: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 70
	i64 1513467482682125403, ; 27: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 195
	i64 1537168428375924959, ; 28: System.Threading.Thread.dll => 0x15551e8a954ae0df => 186
	i64 1556147632182429976, ; 29: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 16
	i64 1563692358899906069, ; 30: HaBHADbMauiApp.dll => 0x15b359ea6638b615 => 114
	i64 1624659445732251991, ; 31: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 82
	i64 1628611045998245443, ; 32: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 94
	i64 1731380447121279447, ; 33: Newtonsoft.Json => 0x18071957e9b889d7 => 78
	i64 1735388228521408345, ; 34: System.Net.Mail.dll => 0x181556663c69b759 => 143
	i64 1743969030606105336, ; 35: System.Memory.dll => 0x1833d297e88f2af8 => 140
	i64 1767386781656293639, ; 36: System.Private.Uri.dll => 0x188704e9f5582107 => 154
	i64 1795316252682057001, ; 37: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 81
	i64 1825687700144851180, ; 38: System.Runtime.InteropServices.RuntimeInformation.dll => 0x1956254a55ef08ec => 164
	i64 1835311033149317475, ; 39: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 6
	i64 1836611346387731153, ; 40: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 101
	i64 1875417405349196092, ; 41: System.Drawing.Primitives => 0x1a06d2319b6c713c => 130
	i64 1881198190668717030, ; 42: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 28
	i64 1897575647115118287, ; 43: Xamarin.AndroidX.Security.SecurityCrypto => 0x1a558aff4cba86cf => 102
	i64 1920760634179481754, ; 44: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 72
	i64 1959996714666907089, ; 45: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 28
	i64 1972385128188460614, ; 46: System.Security.Cryptography.Algorithms => 0x1b5f51d2edefbe46 => 173
	i64 1981742497975770890, ; 47: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 93
	i64 1983698669889758782, ; 48: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 2
	i64 2019660174692588140, ; 49: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 20
	i64 2040001226662520565, ; 50: System.Threading.Tasks.Extensions.dll => 0x1c4f8a4ea894a6f5 => 184
	i64 2102659300918482391, ; 51: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 130
	i64 2133195048986300728, ; 52: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 78
	i64 2262844636196693701, ; 53: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 89
	i64 2287834202362508563, ; 54: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 118
	i64 2302323944321350744, ; 55: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 24
	i64 2315304989185124968, ; 56: System.IO.FileSystem.dll => 0x20219d9ee311aa68 => 136
	i64 2329709569556905518, ; 57: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 92
	i64 2335503487726329082, ; 58: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 180
	i64 2337758774805907496, ; 59: System.Runtime.CompilerServices.Unsafe => 0x207163383edbc828 => 162
	i64 2470498323731680442, ; 60: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 85
	i64 2497223385847772520, ; 61: System.Runtime => 0x22a7eb7046413568 => 171
	i64 2547086958574651984, ; 62: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 80
	i64 2602673633151553063, ; 63: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 27
	i64 2632269733008246987, ; 64: System.Net.NameResolution => 0x2487b36034f808cb => 144
	i64 2656907746661064104, ; 65: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 57
	i64 2662981627730767622, ; 66: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 2
	i64 2706075432581334785, ; 67: System.Net.WebSockets => 0x258de944be6c0701 => 151
	i64 2783046991838674048, ; 68: System.Runtime.CompilerServices.Unsafe.dll => 0x269f5e7e6dc37c80 => 162
	i64 2895129759130297543, ; 69: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 7
	i64 2974029546067041986, ; 70: Microsoft.AspNetCore.Mvc.Formatters.Json.dll => 0x2945e01d74d79ec2 => 49
	i64 3017704767998173186, ; 71: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 106
	i64 3021884968805928991, ; 72: Microsoft.AspNetCore.Authorization.Policy => 0x29efe45e55c5101f => 39
	i64 3110390492489056344, ; 73: System.Security.Cryptography.Csp.dll => 0x2b2a53ac61900058 => 174
	i64 3168817962471953758, ; 74: Microsoft.Extensions.Hosting.Abstractions.dll => 0x2bf9e725d304955e => 63
	i64 3266690593535380875, ; 75: Microsoft.AspNetCore.Authorization => 0x2d559dc982c94d8b => 38
	i64 3289520064315143713, ; 76: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 91
	i64 3311221304742556517, ; 77: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 152
	i64 3325875462027654285, ; 78: System.Runtime.Numerics => 0x2e27e21c8958b48d => 168
	i64 3328853167529574890, ; 79: System.Net.Sockets.dll => 0x2e327651a008c1ea => 150
	i64 3344514922410554693, ; 80: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 113
	i64 3396143930648122816, ; 81: Microsoft.Extensions.FileProviders.Abstractions => 0x2f2186e9506155c0 => 62
	i64 3411255996856937470, ; 82: Xamarin.GooglePlayServices.Basement => 0x2f5737416a942bfe => 109
	i64 3429672777697402584, ; 83: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 74
	i64 3494946837667399002, ; 84: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 55
	i64 3522470458906976663, ; 85: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 103
	i64 3551103847008531295, ; 86: System.Private.CoreLib.dll => 0x31480e226177735f => 193
	i64 3567343442040498961, ; 87: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 22
	i64 3571415421602489686, ; 88: System.Runtime.dll => 0x319037675df7e556 => 171
	i64 3638003163729360188, ; 89: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 56
	i64 3647754201059316852, ; 90: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 189
	i64 3655542548057982301, ; 91: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 55
	i64 3716579019761409177, ; 92: netstandard.dll => 0x3393f0ed5c8c5c99 => 192
	i64 3727469159507183293, ; 93: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 100
	i64 3869221888984012293, ; 94: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 65
	i64 3890352374528606784, ; 95: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 72
	i64 3919223565570527920, ; 96: System.Security.Cryptography.Encoding => 0x3663e111652bd2b0 => 175
	i64 3933965368022646939, ; 97: System.Net.Requests => 0x369840a8bfadc09b => 147
	i64 3966267475168208030, ; 98: System.Memory => 0x370b03412596249e => 140
	i64 4009997192427317104, ; 99: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 170
	i64 4073500526318903918, ; 100: System.Private.Xml.dll => 0x3887fb25779ae26e => 156
	i64 4120493066591692148, ; 101: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 33
	i64 4154383907710350974, ; 102: System.ComponentModel => 0x39a7562737acb67e => 125
	i64 4168469861834746866, ; 103: System.Security.Claims.dll => 0x39d96140fb94ebf2 => 172
	i64 4187479170553454871, ; 104: System.Linq.Expressions => 0x3a1cea1e912fa117 => 138
	i64 4205801962323029395, ; 105: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 124
	i64 4225924121207573736, ; 106: Microsoft.AspNetCore.Authentication.Abstractions => 0x3aa57f992c550ce8 => 36
	i64 4243591448627561453, ; 107: Microsoft.AspNetCore.Http.Extensions.dll => 0x3ae443f06354c3ed => 44
	i64 4247996603072512073, ; 108: Xamarin.GooglePlayServices.Tasks => 0x3af3ea6755340049 => 111
	i64 4250192876909962317, ; 109: Microsoft.AspNetCore.Hosting.Abstractions => 0x3afbb7e72f1d244d => 40
	i64 4356591372459378815, ; 110: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 30
	i64 4657212095206026001, ; 111: Microsoft.Extensions.Http.dll => 0x40a1bdb9c2686b11 => 64
	i64 4679594760078841447, ; 112: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 0
	i64 4794310189461587505, ; 113: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 80
	i64 4795410492532947900, ; 114: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 103
	i64 4809057822547766521, ; 115: System.Drawing => 0x42bd349c3145ecf9 => 131
	i64 4814660307502931973, ; 116: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 144
	i64 4853321196694829351, ; 117: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 167
	i64 5081566143765835342, ; 118: System.Resources.ResourceManager.dll => 0x4685597c05d06e4e => 161
	i64 5099468265966638712, ; 119: System.Resources.ResourceManager => 0x46c4f35ea8519678 => 161
	i64 5103417709280584325, ; 120: System.Collections.Specialized => 0x46d2fb5e161b6285 => 120
	i64 5112836352847824253, ; 121: Microsoft.AspNetCore.WebUtilities.dll => 0x46f47192ee32c57d => 53
	i64 5177565741364132164, ; 122: Microsoft.AspNetCore.Http => 0x47da689c1f3db944 => 42
	i64 5182934613077526976, ; 123: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 120
	i64 5290786973231294105, ; 124: System.Runtime.Loader => 0x496ca6b869b72699 => 167
	i64 5423376490970181369, ; 125: System.Runtime.InteropServices.RuntimeInformation => 0x4b43b42f2b7b6ef9 => 164
	i64 5446034149219586269, ; 126: System.Diagnostics.Debug => 0x4b94333452e150dd => 128
	i64 5471532531798518949, ; 127: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 26
	i64 5522859530602327440, ; 128: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 29
	i64 5527431512186326818, ; 129: System.IO.FileSystem.Primitives.dll => 0x4cb561acbc2a8f22 => 135
	i64 5570799893513421663, ; 130: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 133
	i64 5573260873512690141, ; 131: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 178
	i64 5573669443803475672, ; 132: Microsoft.Maui.Controls.Maps => 0x4d59a6d41d5aeed8 => 71
	i64 5593115988096097561, ; 133: Microsoft.AspNetCore.Routing.dll => 0x4d9ebd5b8a069d19 => 51
	i64 5610815111739789596, ; 134: Microsoft.AspNetCore.Authentication.Core => 0x4ddd9e9de3a4d11c => 37
	i64 5650097808083101034, ; 135: System.Security.Cryptography.Algorithms.dll => 0x4e692e055d01a56a => 173
	i64 5692067934154308417, ; 136: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 105
	i64 5979151488806146654, ; 137: System.Formats.Asn1 => 0x52fa3699a489d25e => 132
	i64 5984759512290286505, ; 138: System.Security.Cryptography.Primitives => 0x530e23115c33dba9 => 176
	i64 6010974535988770325, ; 139: Microsoft.Extensions.Diagnostics.dll => 0x536b457e33877615 => 60
	i64 6068057819846744445, ; 140: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 23
	i64 6200764641006662125, ; 141: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 23
	i64 6222399776351216807, ; 142: System.Text.Json.dll => 0x565a67a0ffe264a7 => 181
	i64 6284145129771520194, ; 143: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 157
	i64 6357457916754632952, ; 144: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 34
	i64 6401687960814735282, ; 145: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 92
	i64 6459596646370694080, ; 146: Microsoft.AspNetCore.JsonPatch.dll => 0x59a518eceb3ad3c0 => 46
	i64 6478287442656530074, ; 147: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 11
	i64 6548213210057960872, ; 148: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 88
	i64 6560151584539558821, ; 149: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 68
	i64 6743165466166707109, ; 150: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 19
	i64 6777482997383978746, ; 151: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 22
	i64 6786606130239981554, ; 152: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 129
	i64 6814185388980153342, ; 153: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 190
	i64 6876862101832370452, ; 154: System.Xml.Linq => 0x5f6f85a57d108914 => 188
	i64 6894844156784520562, ; 155: System.Numerics.Vectors => 0x5faf683aead1ad72 => 152
	i64 6911788284027924527, ; 156: Microsoft.AspNetCore.Hosting.Server.Abstractions => 0x5feb9ad2f830f02f => 41
	i64 7083547580668757502, ; 157: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 155
	i64 7112547816752919026, ; 158: System.IO.FileSystem => 0x62b4d88e3189b1f2 => 136
	i64 7141281584637745974, ; 159: Xamarin.GooglePlayServices.Maps.dll => 0x631aedc3dd5f1b36 => 110
	i64 7220009545223068405, ; 160: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 26
	i64 7270811800166795866, ; 161: System.Linq => 0x64e71ccf51a90a5a => 139
	i64 7331765743953618630, ; 162: Microsoft.AspNetCore.Http.dll => 0x65bfaa1948bba6c6 => 42
	i64 7338192458477945005, ; 163: System.Reflection => 0x65d67f295d0740ad => 160
	i64 7377312882064240630, ; 164: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 124
	i64 7473077275758116397, ; 165: Microsoft.DotNet.PlatformAbstractions => 0x67b5b430309b3e2d => 54
	i64 7488575175965059935, ; 166: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 188
	i64 7489048572193775167, ; 167: System.ObjectModel => 0x67ee71ff6b419e3f => 153
	i64 7654504624184590948, ; 168: System.Net.Http => 0x6a3a4366801b8264 => 142
	i64 7694700312542370399, ; 169: System.Net.Mail => 0x6ac9112a7e2cda5f => 143
	i64 7708790323521193081, ; 170: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 17
	i64 7714652370974252055, ; 171: System.Private.CoreLib => 0x6b0ff375198b9c17 => 193
	i64 7735176074855944702, ; 172: Microsoft.CSharp => 0x6b58dda848e391fe => 115
	i64 7735352534559001595, ; 173: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 112
	i64 7824823231109474690, ; 174: Microsoft.AspNetCore.Authorization.Policy.dll => 0x6c975b4560812982 => 39
	i64 7836164640616011524, ; 175: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 82
	i64 7919757340696389605, ; 176: Microsoft.Extensions.Diagnostics.Abstractions => 0x6de8a157378027e5 => 61
	i64 8031450141206250471, ; 177: System.Runtime.Intrinsics.dll => 0x6f757159d9dc03e7 => 166
	i64 8064050204834738623, ; 178: System.Collections.dll => 0x6fe942efa61731bf => 121
	i64 8083354569033831015, ; 179: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 91
	i64 8085230611270010360, ; 180: System.Net.Http.Json.dll => 0x703482674fdd05f8 => 141
	i64 8087206902342787202, ; 181: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 79
	i64 8167236081217502503, ; 182: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 194
	i64 8185542183669246576, ; 183: System.Collections => 0x7198e33f4794aa70 => 121
	i64 8246048515196606205, ; 184: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 75
	i64 8290740647658429042, ; 185: System.Runtime.Extensions => 0x730ea0b15c929a72 => 163
	i64 8368701292315763008, ; 186: System.Security.Cryptography => 0x7423997c6fd56140 => 178
	i64 8400357532724379117, ; 187: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 99
	i64 8410671156615598628, ; 188: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 158
	i64 8519205576476231015, ; 189: Microsoft.AspNetCore.Mvc.Core.dll => 0x763a4c55ca648567 => 48
	i64 8563666267364444763, ; 190: System.Private.Uri => 0x76d841191140ca5b => 154
	i64 8611142787134128904, ; 191: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll => 0x7780ecbdb94c0308 => 41
	i64 8614108721271900878, ; 192: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 21
	i64 8626175481042262068, ; 193: Java.Interop => 0x77b654e585b55834 => 194
	i64 8638972117149407195, ; 194: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 115
	i64 8639588376636138208, ; 195: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 98
	i64 8677882282824630478, ; 196: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 21
	i64 8725526185868997716, ; 197: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 79
	i64 8816904670177563593, ; 198: Microsoft.Extensions.Diagnostics => 0x7a5bf015646a93c9 => 60
	i64 8941376889969657626, ; 199: System.Xml.XDocument => 0x7c1626e87187471a => 190
	i64 9045785047181495996, ; 200: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 31
	i64 9138683372487561558, ; 201: System.Security.Cryptography.Csp => 0x7ed3201bc3e3d156 => 174
	i64 9286073997824813334, ; 202: BouncyCastle.Cryptography => 0x80dec319ee56e916 => 35
	i64 9312692141327339315, ; 203: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 105
	i64 9324707631942237306, ; 204: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 81
	i64 9413000421947348542, ; 205: Microsoft.AspNetCore.Hosting.Abstractions.dll => 0x82a1b202f4c6163e => 40
	i64 9575902398040817096, ; 206: Xamarin.Google.Crypto.Tink.Android.dll => 0x84e4707ee708bdc8 => 107
	i64 9584643793929893533, ; 207: System.IO.dll => 0x85037ebfbbd7f69d => 137
	i64 9659729154652888475, ; 208: System.Text.RegularExpressions => 0x860e407c9991dd9b => 182
	i64 9678050649315576968, ; 209: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 85
	i64 9702891218465930390, ; 210: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 119
	i64 9808709177481450983, ; 211: Mono.Android.dll => 0x881f890734e555e7 => 196
	i64 9875200773399460291, ; 212: Xamarin.GooglePlayServices.Base.dll => 0x890bc2c8482339c3 => 108
	i64 9938556199016768930, ; 213: Microsoft.AspNetCore.Routing => 0x89ecd834cea6a5a2 => 51
	i64 9956195530459977388, ; 214: Microsoft.Maui => 0x8a2b8315b36616ac => 73
	i64 9991543690424095600, ; 215: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 6
	i64 10038780035334861115, ; 216: System.Net.Http.dll => 0x8b50e941206af13b => 142
	i64 10051358222726253779, ; 217: System.Private.Xml => 0x8b7d990c97ccccd3 => 156
	i64 10092835686693276772, ; 218: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 70
	i64 10143853363526200146, ; 219: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 3
	i64 10229024438826829339, ; 220: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 88
	i64 10236703004850800690, ; 221: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 149
	i64 10243523786148452761, ; 222: Microsoft.AspNetCore.Http.Abstractions => 0x8e284e9c69a49999 => 43
	i64 10245369515835430794, ; 223: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 158
	i64 10364469296367737616, ; 224: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 157
	i64 10406448008575299332, ; 225: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 113
	i64 10430153318873392755, ; 226: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 86
	i64 10458986597687352396, ; 227: Microsoft.AspNetCore.Routing.Abstractions => 0x9125c8e581b9dc4c => 52
	i64 10506226065143327199, ; 228: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 1
	i64 10714184849103829812, ; 229: System.Runtime.Extensions.dll => 0x94b06e5aa4b4bb34 => 163
	i64 10785150219063592792, ; 230: System.Net.Primitives => 0x95ac8cfb68830758 => 146
	i64 11002576679268595294, ; 231: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 66
	i64 11009005086950030778, ; 232: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 73
	i64 11050168729868392624, ; 233: Microsoft.AspNetCore.Http.Features => 0x995a15e9dbef58b0 => 45
	i64 11103970607964515343, ; 234: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 12
	i64 11162124722117608902, ; 235: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 104
	i64 11220793807500858938, ; 236: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 15
	i64 11226290749488709958, ; 237: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 68
	i64 11340910727871153756, ; 238: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 87
	i64 11432101114902388181, ; 239: System.AppContext => 0x9ea6fb64e61a9dd5 => 116
	i64 11485890710487134646, ; 240: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 165
	i64 11518296021396496455, ; 241: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 13
	i64 11529969570048099689, ; 242: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 104
	i64 11530571088791430846, ; 243: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 65
	i64 11597940890313164233, ; 244: netstandard => 0xa0f429ca8d1805c9 => 192
	i64 11705530742807338875, ; 245: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 9
	i64 11743665907891708234, ; 246: System.Threading.Tasks => 0xa2f9e1ec30c0214a => 185
	i64 12040886584167504988, ; 247: System.Net.ServicePoint => 0xa719d28d8e121c5c => 149
	i64 12102847907131387746, ; 248: System.Buffers => 0xa7f5f40c43256f62 => 117
	i64 12145679461940342714, ; 249: System.Text.Json => 0xa88e1f1ebcb62fba => 181
	i64 12201331334810686224, ; 250: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 170
	i64 12441092376399691269, ; 251: Microsoft.AspNetCore.Authentication.Abstractions.dll => 0xaca7a399c11fbe05 => 36
	i64 12451044538927396471, ; 252: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 90
	i64 12466513435562512481, ; 253: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 95
	i64 12475113361194491050, ; 254: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 34
	i64 12517810545449516888, ; 255: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 129
	i64 12538491095302438457, ; 256: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 83
	i64 12550732019250633519, ; 257: System.IO.Compression => 0xae2d28465e8e1b2f => 134
	i64 12681088699309157496, ; 258: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 14
	i64 12700543734426720211, ; 259: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 84
	i64 12708238894395270091, ; 260: System.IO => 0xb05cbbf17d3ba3cb => 137
	i64 12708922737231849740, ; 261: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 179
	i64 12823819093633476069, ; 262: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 27
	i64 12843321153144804894, ; 263: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 69
	i64 12843770487262409629, ; 264: System.AppContext.dll => 0xb23e3d357debf39d => 116
	i64 12854393673938618003, ; 265: HaBHADbMauiApp => 0xb263faf0e223c693 => 114
	i64 13068258254871114833, ; 266: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 169
	i64 13070736518021853291, ; 267: Microsoft.AspNetCore.JsonPatch => 0xb564959c856b306b => 46
	i64 13221551921002590604, ; 268: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 1
	i64 13222659110913276082, ; 269: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 15
	i64 13308002692117796025, ; 270: Microsoft.AspNetCore.Routing.Abstractions.dll => 0xb8af85f08d9f94b9 => 52
	i64 13343850469010654401, ; 271: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 195
	i64 13381594904270902445, ; 272: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 9
	i64 13404984788036896679, ; 273: Microsoft.AspNetCore.Http.Abstractions.dll => 0xba0812a45e7447a7 => 43
	i64 13465488254036897740, ; 274: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 112
	i64 13467053111158216594, ; 275: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 29
	i64 13540124433173649601, ; 276: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 30
	i64 13545416393490209236, ; 277: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 13
	i64 13550417756503177631, ; 278: Microsoft.Extensions.FileProviders.Abstractions.dll => 0xbc0cc1280684799f => 62
	i64 13572454107664307259, ; 279: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 100
	i64 13618112415141049676, ; 280: Microsoft.AspNetCore.Mvc.Core => 0xbcfd4116f7d1b54c => 48
	i64 13717397318615465333, ; 281: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 123
	i64 13755568601956062840, ; 282: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 8
	i64 13814445057219246765, ; 283: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 11
	i64 13881769479078963060, ; 284: System.Console.dll => 0xc0a5f3cade5c6774 => 126
	i64 13921917134693230900, ; 285: Microsoft.AspNetCore.WebUtilities => 0xc13495df5dd06934 => 53
	i64 13955418299340266673, ; 286: Microsoft.Extensions.DependencyModel.dll => 0xc1ab9b0118299cb1 => 59
	i64 13959074834287824816, ; 287: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 90
	i64 14100563506285742564, ; 288: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 3
	i64 14124974489674258913, ; 289: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 83
	i64 14125464355221830302, ; 290: System.Threading.dll => 0xc407bafdbc707a9e => 187
	i64 14254574811015963973, ; 291: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 179
	i64 14261232074598307362, ; 292: Microsoft.AspNetCore.Mvc.Abstractions => 0xc5ea130339d6d622 => 47
	i64 14327695147300244862, ; 293: System.Reflection.dll => 0xc6d632d338eb4d7e => 160
	i64 14327709162229390963, ; 294: System.Security.Cryptography.X509Certificates => 0xc6d63f9253cade73 => 177
	i64 14461014870687870182, ; 295: System.Net.Requests.dll => 0xc8afd8683afdece6 => 147
	i64 14464374589798375073, ; 296: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 24
	i64 14522721392235705434, ; 297: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 5
	i64 14528548208938697926, ; 298: Microsoft.AspNetCore.Mvc.Abstractions.dll => 0xc99fc59ed7edc4c6 => 47
	i64 14551742072151931844, ; 299: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 180
	i64 14561513370130550166, ; 300: System.Security.Cryptography.Primitives.dll => 0xca14e3428abb8d96 => 176
	i64 14622043554576106986, ; 301: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 169
	i64 14669215534098758659, ; 302: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 57
	i64 14705122255218365489, ; 303: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 16
	i64 14744092281598614090, ; 304: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 32
	i64 14832630590065248058, ; 305: System.Security.Claims => 0xcdd816ef5d6e873a => 172
	i64 14852515768018889994, ; 306: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 87
	i64 14892012299694389861, ; 307: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 33
	i64 14904040806490515477, ; 308: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 0
	i64 14954917835170835695, ; 309: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 58
	i64 14987728460634540364, ; 310: System.IO.Compression.dll => 0xcfff1ba06622494c => 134
	i64 15015154896917945444, ; 311: System.Net.Security.dll => 0xd0608bd33642dc64 => 148
	i64 15024878362326791334, ; 312: System.Net.Http.Json => 0xd0831743ebf0f4a6 => 141
	i64 15051741671811457419, ; 313: Microsoft.Extensions.Diagnostics.Abstractions.dll => 0xd0e2874d8f44218b => 61
	i64 15076659072870671916, ; 314: System.ObjectModel.dll => 0xd13b0d8c1620662c => 153
	i64 15111608613780139878, ; 315: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 17
	i64 15115185479366240210, ; 316: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 133
	i64 15133485256822086103, ; 317: System.Linq.dll => 0xd204f0a9127dd9d7 => 139
	i64 15227001540531775957, ; 318: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 56
	i64 15370334346939861994, ; 319: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 86
	i64 15391712275433856905, ; 320: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 58
	i64 15527772828719725935, ; 321: System.Console => 0xd77dbb1e38cd3d6f => 126
	i64 15536481058354060254, ; 322: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 4
	i64 15541854775306130054, ; 323: System.Security.Cryptography.X509Certificates.dll => 0xd7afc292e8d49286 => 177
	i64 15557562860424774966, ; 324: System.Net.Sockets => 0xd7e790fe7a6dc536 => 150
	i64 15565247197164990907, ; 325: Microsoft.AspNetCore.Http.Extensions => 0xd802dddb8c29f1bb => 44
	i64 15582737692548360875, ; 326: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 94
	i64 15592226634512578529, ; 327: Microsoft.AspNetCore.Authorization.dll => 0xd862b7834f81b7e1 => 38
	i64 15609085926864131306, ; 328: System.dll => 0xd89e9cf3334914ea => 191
	i64 15620595871140898079, ; 329: Microsoft.Extensions.DependencyModel => 0xd8c7812eef49651f => 59
	i64 15620612276725577442, ; 330: BouncyCastle.Cryptography.dll => 0xd8c7901aa85576e2 => 35
	i64 15661133872274321916, ; 331: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 189
	i64 15664356999916475676, ; 332: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 4
	i64 15743187114543869802, ; 333: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 12
	i64 15755368083429170162, ; 334: System.IO.FileSystem.Primitives => 0xdaa64fcbde529bf2 => 135
	i64 15783653065526199428, ; 335: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 5
	i64 15817206913877585035, ; 336: System.Threading.Tasks.dll => 0xdb8201e29086ac8b => 185
	i64 15847085070278954535, ; 337: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 183
	i64 15852824340364052161, ; 338: Microsoft.AspNetCore.Http.Features.dll => 0xdc008bbee610c6c1 => 45
	i64 15930129725311349754, ; 339: Xamarin.GooglePlayServices.Tasks.dll => 0xdd1330956f12f3fa => 111
	i64 15963349826457351533, ; 340: System.Threading.Tasks.Extensions => 0xdd893616f748b56d => 184
	i64 16018552496348375205, ; 341: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 145
	i64 16046481083542319511, ; 342: Microsoft.Extensions.ObjectPool => 0xdeb08d870f90b197 => 67
	i64 16154507427712707110, ; 343: System => 0xe03056ea4e39aa26 => 191
	i64 16182611612321266217, ; 344: Microsoft.Maui.Maps => 0xe0942f85b2853a29 => 76
	i64 16219561732052121626, ; 345: System.Net.Security => 0xe1177575db7c781a => 148
	i64 16288847719894691167, ; 346: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 18
	i64 16321164108206115771, ; 347: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 66
	i64 16344871930018146979, ; 348: Microsoft.AspNetCore.ResponseCaching.Abstractions => 0xe2d4a66be7fc2aa3 => 50
	i64 16454459195343277943, ; 349: System.Net.NetworkInformation => 0xe459fb756d988f77 => 145
	i64 16558262036769511634, ; 350: Microsoft.Extensions.Http => 0xe5cac397cf7b98d2 => 64
	i64 16649148416072044166, ; 351: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 75
	i64 16677317093839702854, ; 352: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 99
	i64 16737807731308835127, ; 353: System.Runtime.Intrinsics => 0xe848a3736f733137 => 166
	i64 16856067890322379635, ; 354: System.Data.Common.dll => 0xe9ecc87060889373 => 127
	i64 16890310621557459193, ; 355: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 182
	i64 16942731696432749159, ; 356: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 25
	i64 16998075588627545693, ; 357: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 97
	i64 17008137082415910100, ; 358: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 119
	i64 17027804579603049667, ; 359: Microsoft.Maui.Controls.Maps.dll => 0xec4eea0c48026cc3 => 71
	i64 17031351772568316411, ; 360: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 96
	i64 17062143951396181894, ; 361: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 123
	i64 17089008752050867324, ; 362: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 32
	i64 17118171214553292978, ; 363: System.Threading.Channels => 0xed8ff6060fc420b2 => 183
	i64 17126545051278881272, ; 364: Microsoft.Net.Http.Headers.dll => 0xedadb5fbdb33b1f8 => 77
	i64 17201328579425343169, ; 365: System.ComponentModel.EventBasedAsync => 0xeeb76534d96c16c1 => 122
	i64 17202182880784296190, ; 366: System.Security.Cryptography.Encoding.dll => 0xeeba6e30627428fe => 175
	i64 17230721278011714856, ; 367: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 155
	i64 17260702271250283638, ; 368: System.Data.Common => 0xef8a5543bba6bc76 => 127
	i64 17311256152179951039, ; 369: Microsoft.AspNetCore.Mvc.Formatters.Json => 0xf03defc05e7b45bf => 49
	i64 17342750010158924305, ; 370: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 10
	i64 17360349973592121190, ; 371: Xamarin.Google.Crypto.Tink.Android => 0xf0ec5a52686b9f66 => 107
	i64 17438153253682247751, ; 372: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 25
	i64 17509662556995089465, ; 373: System.Net.WebSockets.dll => 0xf2fed1534ea67439 => 151
	i64 17514990004910432069, ; 374: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 8
	i64 17623389608345532001, ; 375: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 20
	i64 17685921127322830888, ; 376: System.Diagnostics.Debug.dll => 0xf571038fafa74828 => 128
	i64 17702523067201099846, ; 377: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 31
	i64 17704177640604968747, ; 378: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 95
	i64 17710060891934109755, ; 379: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 93
	i64 17712670374920797664, ; 380: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 165
	i64 17777860260071588075, ; 381: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 168
	i64 17838668724098252521, ; 382: System.Buffers.dll => 0xf78faeb0f5bf3ee9 => 117
	i64 17911643751311784505, ; 383: Microsoft.Net.Http.Headers => 0xf892f1178448ba39 => 77
	i64 17969331831154222830, ; 384: Xamarin.GooglePlayServices.Maps => 0xf95fe418471126ee => 110
	i64 17986907704309214542, ; 385: Xamarin.GooglePlayServices.Basement.dll => 0xf99e554223166d4e => 109
	i64 18025913125965088385, ; 386: System.Threading => 0xfa28e87b91334681 => 187
	i64 18099568558057551825, ; 387: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 19
	i64 18121036031235206392, ; 388: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 96
	i64 18146411883821974900, ; 389: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 132
	i64 18146811631844267958, ; 390: System.ComponentModel.EventBasedAsync.dll => 0xfbd66d08820117b6 => 122
	i64 18245806341561545090, ; 391: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 118
	i64 18305135509493619199, ; 392: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 98
	i64 18324163916253801303 ; 393: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 14
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [394 x i32] [
	i32 54, ; 0
	i32 69, ; 1
	i32 196, ; 2
	i32 74, ; 3
	i32 63, ; 4
	i32 138, ; 5
	i32 84, ; 6
	i32 101, ; 7
	i32 102, ; 8
	i32 67, ; 9
	i32 7, ; 10
	i32 159, ; 11
	i32 76, ; 12
	i32 108, ; 13
	i32 186, ; 14
	i32 125, ; 15
	i32 10, ; 16
	i32 89, ; 17
	i32 50, ; 18
	i32 37, ; 19
	i32 159, ; 20
	i32 106, ; 21
	i32 18, ; 22
	i32 131, ; 23
	i32 97, ; 24
	i32 146, ; 25
	i32 70, ; 26
	i32 195, ; 27
	i32 186, ; 28
	i32 16, ; 29
	i32 114, ; 30
	i32 82, ; 31
	i32 94, ; 32
	i32 78, ; 33
	i32 143, ; 34
	i32 140, ; 35
	i32 154, ; 36
	i32 81, ; 37
	i32 164, ; 38
	i32 6, ; 39
	i32 101, ; 40
	i32 130, ; 41
	i32 28, ; 42
	i32 102, ; 43
	i32 72, ; 44
	i32 28, ; 45
	i32 173, ; 46
	i32 93, ; 47
	i32 2, ; 48
	i32 20, ; 49
	i32 184, ; 50
	i32 130, ; 51
	i32 78, ; 52
	i32 89, ; 53
	i32 118, ; 54
	i32 24, ; 55
	i32 136, ; 56
	i32 92, ; 57
	i32 180, ; 58
	i32 162, ; 59
	i32 85, ; 60
	i32 171, ; 61
	i32 80, ; 62
	i32 27, ; 63
	i32 144, ; 64
	i32 57, ; 65
	i32 2, ; 66
	i32 151, ; 67
	i32 162, ; 68
	i32 7, ; 69
	i32 49, ; 70
	i32 106, ; 71
	i32 39, ; 72
	i32 174, ; 73
	i32 63, ; 74
	i32 38, ; 75
	i32 91, ; 76
	i32 152, ; 77
	i32 168, ; 78
	i32 150, ; 79
	i32 113, ; 80
	i32 62, ; 81
	i32 109, ; 82
	i32 74, ; 83
	i32 55, ; 84
	i32 103, ; 85
	i32 193, ; 86
	i32 22, ; 87
	i32 171, ; 88
	i32 56, ; 89
	i32 189, ; 90
	i32 55, ; 91
	i32 192, ; 92
	i32 100, ; 93
	i32 65, ; 94
	i32 72, ; 95
	i32 175, ; 96
	i32 147, ; 97
	i32 140, ; 98
	i32 170, ; 99
	i32 156, ; 100
	i32 33, ; 101
	i32 125, ; 102
	i32 172, ; 103
	i32 138, ; 104
	i32 124, ; 105
	i32 36, ; 106
	i32 44, ; 107
	i32 111, ; 108
	i32 40, ; 109
	i32 30, ; 110
	i32 64, ; 111
	i32 0, ; 112
	i32 80, ; 113
	i32 103, ; 114
	i32 131, ; 115
	i32 144, ; 116
	i32 167, ; 117
	i32 161, ; 118
	i32 161, ; 119
	i32 120, ; 120
	i32 53, ; 121
	i32 42, ; 122
	i32 120, ; 123
	i32 167, ; 124
	i32 164, ; 125
	i32 128, ; 126
	i32 26, ; 127
	i32 29, ; 128
	i32 135, ; 129
	i32 133, ; 130
	i32 178, ; 131
	i32 71, ; 132
	i32 51, ; 133
	i32 37, ; 134
	i32 173, ; 135
	i32 105, ; 136
	i32 132, ; 137
	i32 176, ; 138
	i32 60, ; 139
	i32 23, ; 140
	i32 23, ; 141
	i32 181, ; 142
	i32 157, ; 143
	i32 34, ; 144
	i32 92, ; 145
	i32 46, ; 146
	i32 11, ; 147
	i32 88, ; 148
	i32 68, ; 149
	i32 19, ; 150
	i32 22, ; 151
	i32 129, ; 152
	i32 190, ; 153
	i32 188, ; 154
	i32 152, ; 155
	i32 41, ; 156
	i32 155, ; 157
	i32 136, ; 158
	i32 110, ; 159
	i32 26, ; 160
	i32 139, ; 161
	i32 42, ; 162
	i32 160, ; 163
	i32 124, ; 164
	i32 54, ; 165
	i32 188, ; 166
	i32 153, ; 167
	i32 142, ; 168
	i32 143, ; 169
	i32 17, ; 170
	i32 193, ; 171
	i32 115, ; 172
	i32 112, ; 173
	i32 39, ; 174
	i32 82, ; 175
	i32 61, ; 176
	i32 166, ; 177
	i32 121, ; 178
	i32 91, ; 179
	i32 141, ; 180
	i32 79, ; 181
	i32 194, ; 182
	i32 121, ; 183
	i32 75, ; 184
	i32 163, ; 185
	i32 178, ; 186
	i32 99, ; 187
	i32 158, ; 188
	i32 48, ; 189
	i32 154, ; 190
	i32 41, ; 191
	i32 21, ; 192
	i32 194, ; 193
	i32 115, ; 194
	i32 98, ; 195
	i32 21, ; 196
	i32 79, ; 197
	i32 60, ; 198
	i32 190, ; 199
	i32 31, ; 200
	i32 174, ; 201
	i32 35, ; 202
	i32 105, ; 203
	i32 81, ; 204
	i32 40, ; 205
	i32 107, ; 206
	i32 137, ; 207
	i32 182, ; 208
	i32 85, ; 209
	i32 119, ; 210
	i32 196, ; 211
	i32 108, ; 212
	i32 51, ; 213
	i32 73, ; 214
	i32 6, ; 215
	i32 142, ; 216
	i32 156, ; 217
	i32 70, ; 218
	i32 3, ; 219
	i32 88, ; 220
	i32 149, ; 221
	i32 43, ; 222
	i32 158, ; 223
	i32 157, ; 224
	i32 113, ; 225
	i32 86, ; 226
	i32 52, ; 227
	i32 1, ; 228
	i32 163, ; 229
	i32 146, ; 230
	i32 66, ; 231
	i32 73, ; 232
	i32 45, ; 233
	i32 12, ; 234
	i32 104, ; 235
	i32 15, ; 236
	i32 68, ; 237
	i32 87, ; 238
	i32 116, ; 239
	i32 165, ; 240
	i32 13, ; 241
	i32 104, ; 242
	i32 65, ; 243
	i32 192, ; 244
	i32 9, ; 245
	i32 185, ; 246
	i32 149, ; 247
	i32 117, ; 248
	i32 181, ; 249
	i32 170, ; 250
	i32 36, ; 251
	i32 90, ; 252
	i32 95, ; 253
	i32 34, ; 254
	i32 129, ; 255
	i32 83, ; 256
	i32 134, ; 257
	i32 14, ; 258
	i32 84, ; 259
	i32 137, ; 260
	i32 179, ; 261
	i32 27, ; 262
	i32 69, ; 263
	i32 116, ; 264
	i32 114, ; 265
	i32 169, ; 266
	i32 46, ; 267
	i32 1, ; 268
	i32 15, ; 269
	i32 52, ; 270
	i32 195, ; 271
	i32 9, ; 272
	i32 43, ; 273
	i32 112, ; 274
	i32 29, ; 275
	i32 30, ; 276
	i32 13, ; 277
	i32 62, ; 278
	i32 100, ; 279
	i32 48, ; 280
	i32 123, ; 281
	i32 8, ; 282
	i32 11, ; 283
	i32 126, ; 284
	i32 53, ; 285
	i32 59, ; 286
	i32 90, ; 287
	i32 3, ; 288
	i32 83, ; 289
	i32 187, ; 290
	i32 179, ; 291
	i32 47, ; 292
	i32 160, ; 293
	i32 177, ; 294
	i32 147, ; 295
	i32 24, ; 296
	i32 5, ; 297
	i32 47, ; 298
	i32 180, ; 299
	i32 176, ; 300
	i32 169, ; 301
	i32 57, ; 302
	i32 16, ; 303
	i32 32, ; 304
	i32 172, ; 305
	i32 87, ; 306
	i32 33, ; 307
	i32 0, ; 308
	i32 58, ; 309
	i32 134, ; 310
	i32 148, ; 311
	i32 141, ; 312
	i32 61, ; 313
	i32 153, ; 314
	i32 17, ; 315
	i32 133, ; 316
	i32 139, ; 317
	i32 56, ; 318
	i32 86, ; 319
	i32 58, ; 320
	i32 126, ; 321
	i32 4, ; 322
	i32 177, ; 323
	i32 150, ; 324
	i32 44, ; 325
	i32 94, ; 326
	i32 38, ; 327
	i32 191, ; 328
	i32 59, ; 329
	i32 35, ; 330
	i32 189, ; 331
	i32 4, ; 332
	i32 12, ; 333
	i32 135, ; 334
	i32 5, ; 335
	i32 185, ; 336
	i32 183, ; 337
	i32 45, ; 338
	i32 111, ; 339
	i32 184, ; 340
	i32 145, ; 341
	i32 67, ; 342
	i32 191, ; 343
	i32 76, ; 344
	i32 148, ; 345
	i32 18, ; 346
	i32 66, ; 347
	i32 50, ; 348
	i32 145, ; 349
	i32 64, ; 350
	i32 75, ; 351
	i32 99, ; 352
	i32 166, ; 353
	i32 127, ; 354
	i32 182, ; 355
	i32 25, ; 356
	i32 97, ; 357
	i32 119, ; 358
	i32 71, ; 359
	i32 96, ; 360
	i32 123, ; 361
	i32 32, ; 362
	i32 183, ; 363
	i32 77, ; 364
	i32 122, ; 365
	i32 175, ; 366
	i32 155, ; 367
	i32 127, ; 368
	i32 49, ; 369
	i32 10, ; 370
	i32 107, ; 371
	i32 25, ; 372
	i32 151, ; 373
	i32 8, ; 374
	i32 20, ; 375
	i32 128, ; 376
	i32 31, ; 377
	i32 95, ; 378
	i32 93, ; 379
	i32 165, ; 380
	i32 168, ; 381
	i32 117, ; 382
	i32 77, ; 383
	i32 110, ; 384
	i32 109, ; 385
	i32 187, ; 386
	i32 19, ; 387
	i32 96, ; 388
	i32 132, ; 389
	i32 122, ; 390
	i32 118, ; 391
	i32 98, ; 392
	i32 14 ; 393
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
