# share_global_saya

Paket Flutter berisi kode bersama untuk digunakan di banyak proyek: utilitas, widget input, dialog, toast, serta logging dan overlay debug. Paket ini bersifat internal dan tidak diterbitkan ke pub.dev.

## Identitas Paket

| Atribut | Nilai |
| ------- | ----- |
| Nama paket | `share_global_saya` |
| Versi | `1.0.0` |
| SDK Dart | `>=3.4.0 <4.0.0` |
| Flutter | `>=3.22.0` |
| Publikasi | `publish_to: "none"` |
| Repositori | `https://github.com/mbadrudin170-jpg/share_global_saya.git` |

`share_global_saya` merupakan submodule dari repositori [`workspace`](https://github.com/mbadrudin170-jpg/workspace.git).

## Cakupan Fitur

### Logging dan Debug

- `L` sebagai pintu masuk logging dengan metode `L.i()`, `L.s()`, `L.w()`, `L.e()`, `L.json()`, `L.list()`, dan `L.api()`.
- `LogDebugNotifier` berbasis Riverpod dengan `keepAlive` untuk menyimpan daftar log di memori.
- `LogDebugPage` untuk menampilkan daftar log dan menghapus seluruh log.
- `PengelolaOverlayLogDebug` untuk menampilkan ikon melayang dan panel log di atas aplikasi.
- `TipeLog` dan `LogDebugModel` sebagai model kategori dan data log.
- `p()` pada `print_custom.dart` untuk pencetakan debug sederhana.

### Utilitas

- `Nav` untuk navigasi terpusat: `to`, `toReplacement`, `pop`, dan `pushAndRemoveUntil`.
- `ParserUtil` untuk parsing `DateTime`, `bool`, `int`, `double`, `String`, dan enum dari nilai dinamis, termasuk varian nullable.
- `FormatWaktuLengkap`, `FormatTanggal`, `FormatJam`, `FormatUang`, dan `FormatNomor` untuk pemformatan tanggal, waktu, Rupiah, ribuan, dan persen dengan locale `id_ID`.
- `SharedPrefService` sebagai pembungkus `SharedPreferencesAsync` untuk menyimpan dan membaca nilai sederhana.
- `AsyncValueX.whenDefault` sebagai penyederhanaan `AsyncValue.when` dengan opsi `skipLoadingOnReload` dan `skipLoadingOnRefresh`.
- `scaffoldMessengerKey` dan `navigatorKey` untuk akses dari luar pohon halaman aktif.

### Widget Input

- `InputTeks`, `InputAngka`, `InputRupiah`, `InputTelepon`, `InputPassword`, `InputDropdown`, dan `InputAutocomplete`.
- `RupiahInputFormatter` dan `ThousandsAndNegativeInputFormatter` sebagai formatter input angka.
- Dukungan label, hint, ikon, validator, fokus antar-field, serta mode validasi otomatis.

### Widget Lainnya

- `ConfirmationDialog` dengan varian `show`, `showDelete`, `showDeleteAll`, dan `showInfo`.
- `PemilihTanggalWaktuWidget` untuk menampilkan dan memilih tanggal/waktu melalui callback.
- `AppToast` dengan varian `sukses`, `gagal`, `info`, dan `warning`.

## Struktur Paket

| Lokasi | Keterangan |
| ------ | ---------- |
| `lib/core_shared.dart` | Titik ekspor utama seluruh API paket |
| `lib/log_debug/` | Logging, halaman log, overlay debug, dan notifier |
| `lib/db/model/log_debug_model.dart` | Model dan enum log debug |
| `lib/src/utils/` | Navigasi, parsing, format, shared preferences, key global, dan ekstensi `AsyncValue` |
| `lib/src/widget/` | Widget input, dialog, pemilih tanggal/waktu, dan toast |
| `docs/` | Aturan, command, dan dokumentasi pendukung proyek |
| `.vscode/` | Snippet dan konfigurasi editor |

Seluruh API publik dapat diimpor melalui:

```dart
import 'package:share_global_saya/core_shared.dart';
```

## Pemasangan

Karena `publish_to` bernilai `none`, paket tidak tersedia di pub.dev. Gunakan dependensi path atau Git sesuai kebutuhan proyek. Contoh dependensi path:

```yaml
dependencies:
  share_global_saya:
    path: ../workspace/share_global_saya
```

Setelah menambahkan dependensi:

```bash
flutter pub get
```

## Inisialisasi

`SharedPrefService` wajib diinisialisasi sebelum digunakan. Agar log juga tampil pada overlay debug, inisialisasi `L` dengan `ProviderContainer` yang sama dengan yang dipakai aplikasi.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();

  final container = ProviderContainer();
  L.init(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PengelolaOverlayLogDebug(
        child: AplikasiSaya(),
      ),
    ),
  );
}
```

## Contoh Penggunaan

### Logging

```dart
L.i('Memuat data pengguna');
L.s('Data berhasil disimpan');
L.w('Data kosong, memakai nilai default');
L.e('Gagal menyimpan data');
```

### Navigasi, Dialog, dan Toast

```dart
Nav.to(context, const HalamanDetail());

final yakin = await ConfirmationDialog.showDelete(
  context: context,
  itemName: 'Catatan 1',
);

if (yakin == true) {
  AppToast.sukses(context, 'Data berhasil dihapus');
}
```

### Format dan Parsing

```dart
final rupiah = FormatUang.formatRupiah(150000);
final tanggal = FormatTanggal.formatDasar(DateTime.now());
final jumlah = ParserUtil.parseIntOrNull(nilaiDariDatabase);
```

## Berkas Hasil Generate

`lib/log_debug/log_debug_notifier.freezed.dart` dan `lib/log_debug/log_debug_notifier.g.dart` merupakan berkas hasil `build_runner`. Jangan mengeditnya secara manual. Setelah mengubah sumber Freezed atau Riverpod, jalankan:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Verifikasi

```bash
flutter pub get
dart analyze
```

Repositori ini belum memiliki folder `test/`, sehingga belum ada pengujian otomatis yang dapat dijalankan dengan `flutter test`.

## Kelebihan

- Menghimpun kode yang sering dipakai ulang sehingga tidak perlu disalin ke setiap proyek.
- Logging terintegrasi dengan Riverpod dan overlay debug, termasuk pencatatan lokasi pemanggil.
- Menyediakan widget input siap pakai dengan formatter Rupiah dan ribuan.
- Pemformatan tanggal, waktu, dan angka mengikuti locale `id_ID`.
- Navigasi, dialog konfirmasi, dan toast memiliki API terpusat sehingga konsisten antarproyek.

## Catatan

- Paket ini internal dan belum diterbitkan sebagai paket publik.
- Dokumentasi pada `docs/` memuat aturan dan command pendukung proyek.
- Perubahan pada submodule ini tidak di-commit otomatis ke repositori induk.
