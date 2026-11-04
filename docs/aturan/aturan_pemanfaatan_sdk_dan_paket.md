aturan_pemanfaatan_sdk_dan_paket.md

# Aturan

# Skills

1. Sebelum menulis atau mengubah kode, baca/load skill yang tersedia di `.agents/skills` agar implementasi sesuai panduan paket/fitur terkait. Jangan menulis ulang mekanisme yang sudah tersedia di skill.

# Lainnya

1. Jarak antar anak pada `Row` dan `Column`: gunakan properti `spacing` untuk mengatur jarak antar anak. Kecuali untuk anak yang membutuhkan jarak khusus, gunakan `SizedBox`.

2. Pengurutan data pada koleksi: gunakan fungsi `sorted` dari paket `collection`.

3. Pengambilan satu item dari koleksi: gunakan fungsi `firstWhereOrNull` dari paket `collection`.

4. Pengambilan satu item pertama dari koleksi: gunakan fungsi `maxBy` dari paket `collection`.

5. Gambar dari jaringan: gunakan `CachedNetworkImage` (bukan `Image.network`) mengikuti contoh pada folder `example` paket `cached_network_image` (lihat `example.md`), dengan menyediakan `placeholder` dan `errorWidget` agar status muat/gagal jelas.

# Uuid

1. id unik : gunakan uuid.v4() dari paket uuid ini dan dilarang menggunakan tanggal atau manual.

# URL Launcher

1. Membuka tautan/URL: gunakan `launchUrl` dari paket `url_launcher`. Buat `Uri` dengan `Uri.parse`, `Uri.tryParse`, `Uri(...)`, atau `Uri.file`. Periksa nilai balik `bool` (lempar `Exception` jika gagal) dan bungkus operasi dengan `try`/`catch`.
2. Mode peluncuran: tentukan `LaunchMode` sesuai kebutuhan (`externalApplication`, `inAppBrowserView`, `inAppWebView`, `externalNonBrowserApplication`). Untuk universal link, coba `externalNonBrowserApplication` terlebih dahulu, lalu fallback ke `inAppBrowserView` jika gagal.
3. Konfigurasi browser/web view: gunakan `BrowserConfiguration` (mis. `showTitle`) dan `WebViewConfiguration` (mis. `headers`, `enableJavaScript`, `enableDomStorage`) bila diperlukan. Untuk web, gunakan `webOnlyWindowName`.
4. Dukungan fitur: gunakan `canLaunchUrl` untuk memeriksa ketersediaan (mis. panggilan telepon) sebelum menampilkan aksi.
5. Email: susun `Uri` dengan `scheme: 'mailto'`, `path` alamat email, dan `query` hasil fungsi `encodeQueryParameters` yang memakai `Uri.encodeComponent`.
6. Berkas: gunakan `Uri.file`, pastikan berkas ada sebelum memanggil `launchUrl`.
7. Tautan deklaratif: gunakan widget `Link` dengan `uri` dan `target`.
8. Penutupan web view: gunakan `closeInAppWebView()` bila perlu menutup web view secara programatik.

Ikuti contoh pada folder `example` paket `url_launcher` (lihat `example.md`).

# Timezone

1. Inisialisasi: panggil `tz.initializeTimeZones()` sebelum menggunakan database zona waktu. Gunakan `tz.getLocation('...')` atau `tz.timeZoneDatabase` untuk memilih lokasi, dan konversi waktu dengan `tz.TZDateTime` (mis. `tz.TZDateTime.from(waktu, tz.local)`). Ikuti contoh pada folder `example` paket `timezone`.
2. Platform: untuk web, gunakan `initializeTimeZone()` dari `package:timezone/browser.dart`; untuk VM/standalone, gunakan `tz.initializeTimeZones()` dari `package:timezone/data/latest.dart`. Pastikan database zona waktu terinisialisasi sebelum memanggil `tz.getLocation` atau `tz.TZDateTime`.
3. Penanganan error: bungkus inisialisasi dengan `try`/`catch` dan catat kegagalan; untuk web, tangani `TimeZoneInitException` bila ada.

# Sqflite

1. Inisialisasi database: panggil `sqfliteFfiInit()` dan set `databaseFactory` sesuai platform (`databaseFactoryFfi` untuk desktop, `databaseFactoryFfiWeb` untuk web) sebelum membuka database. Ikuti contoh pada folder `example` paket `sqflite` (dan `sqflite_common_ffi`/`sqflite_common_ffi_web` untuk platform terkait).

# adaptive_dialog

1. Dialog konfirmasi wajib adaptive_dialog `Contoh: showOkCancelAlertDialog(context: context, title: ..., message: ..., okLabel: ..., cancelLabel: ..., isDestructiveAction: true)`
