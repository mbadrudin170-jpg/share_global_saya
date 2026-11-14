# share_global_saya

Pustaka Flutter berisi kode bersama untuk digunakan di beberapa proyek: logging dan overlay debug, utilitas umum, serta kumpulan widget UI (input, dialog konfirmasi, pemilih tanggal/waktu, dan toast). Pustaka ini bersifat internal dan tidak diterbitkan ke pub.dev.

## Identitas Paket

| Atribut | Nilai |
| --- | --- |
| Nama paket | `share_global_saya` |
| Versi | `1.0.0` |
| SDK Dart | `>=3.4.0 <4.0.0` |
| Flutter | `>=3.22.0` |
| Publikasi | `publish_to: "none"` |
| Repositori | `https://github.com/mbadrudin170-jpg/share_global_saya.git` |
| Lokasi di workspace | Submodule [`share_global_saya/`](../README.md) pada repositori [`workspace`](../README.md) |

## Fitur yang Tersedia

### Logging dan Debug

- `L` sebagai pintu masuk logging (`L.i()`, `L.s()`, `L.w()`, `L.e()`, `L.json()`, `L.list()`, `L.api()`, dan pengelolaan buffer/inisialisasi).
- `LogDebugNotifier` (Riverpod, `keepAlive`) dengan state Freezed untuk menyimpan dan mengelola log di memori.
- `LogDebugPage` untuk menampilkan dan mengelola daftar log.
- `PengelolaOverlayLogDebug`/overlay log debug untuk menampilkan akses log di atas aplikasi.
- Model dan tipe log pada `db/model/log_debug_model.dart` serta utilitas cetak (`print_custom.dart`).

### Utilitas

- `Nav` untuk navigasi terpusat (`to`, `toReplacement`, `pop`, `pushAndRemoveUntil`).
- `ParserUtil` untuk parsing nilai dinamis (`DateTime`, `bool`, `int`, `double`, `String`, enum) termasuk varian nullable.
- Format waktu/tanggal/jam/uang/nomor (`FormatWaktuLengkap`, `FormatTanggal`, `FormatJam`, `FormatUang`, `FormatNomor`) dengan locale `id_ID` (paket `intl`).
- `SharedPrefService` sebagai pembungkus `SharedPreferencesAsync` (inisialisasi wajib sebelum digunakan).
- `AsyncValueX.whenDefault` untuk penyederhanaan penanganan `AsyncValue`.
- Kunci global aplikasi (`app_keys.dart`, mis. navigator/scaffold messenger sesuai implementasi).

### Widget

- Input: `InputTeks`, `InputAngka`, `InputRupiah`, `InputTelepon`, `InputPassword`, `InputDropdown`, `InputAutocomplete`.
- Formatter: `RupiahInputFormatter`, `ThousandsAndNegativeInputFormatter`.
- Dialog: `ConfirmationDialog` (`show`, `showDelete`, `showDeleteAll`, `showInfo`).
- Lainnya: `PemilihTanggalWaktuWidget`, `AppToast` (`sukses`, `gagal`, `info`, `warning`).

Seluruh API publik diekspor melalui:

```dart
import 'package:share_global_saya/core_shared.dart';
```

## Teknologi

| Komponen | Keterangan |
| --- | --- |
| Framework | Flutter (Material) |
| Bahasa | Dart `>=3.4.0 <4.0.0` |
| State/Codegen | `flutter_riverpod`, `riverpod_annotation`, `freezed_annotation`, `freezed` |
| Utilitas | `intl`, `uuid`, `shared_preferences`, `fluttertoast`, `stack_trace` |
| Dev/Codegen | `flutter_test`, `flutter_lints`, `build_runner`, `riverpod_generator`, `riverpod_lint` |

## Struktur Paket

| Lokasi | Keterangan |
| --- | --- |
| `lib/core_shared.dart` | Titik ekspor utama API paket. |
| `lib/log_debug/` | Logging, notifier/state, overlay, halaman log, dan utilitas cetak. |
| `lib/db/model/log_debug_model.dart` | Model dan tipe log debug. |
| `lib/src/utils/` | Navigasi, format, parser, shared preferences, kunci, ekstensi, dan helper logging. |
| `lib/src/widget/` | Widget input (+ formatter), dialog, pemilih tanggal/waktu, dan toast. |
| `docs/` | Dokumentasi pendukung paket/proyek (laporan linter, snippet, struktur, dll.). |
| `aturan_sumber_kode _flutter_dan_paket.md` | Catatan/aturan sumber kode Flutter dan paket. |

Berkas hasil generate yang ada: `lib/log_debug/log_debug_notifier.freezed.dart` dan `lib/log_debug/log_debug_notifier.g.dart`.

## Pemasangan

Paket tidak tersedia di pub.dev (`publish_to: "none"`). Tambahkan sebagai dependensi path atau Git sesuai kebutuhan.

Contoh dependensi path:

```yaml
dependencies:
  share_global_saya:
    path: ../workspace/share_global_saya
```

Kemudian jalankan:

```bash
flutter pub get
```

## Inisialisasi

`SharedPrefService` wajib diinisialisasi sebelum digunakan. Untuk menampilkan log pada overlay debug, inisialisasi `L` dengan `ProviderContainer` yang sama dan bungkus aplikasi dengan `PengelolaOverlayLogDebug`.

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
L.i('Memuat data');
L.s('Operasi berhasil');
L.w('Peringatan');
L.e('Terjadi kesalahan');
```

### Navigasi, Dialog, dan Toast

```dart
Nav.to(context, const HalamanDetail());

final konfirmasi = await ConfirmationDialog.showDelete(
  context: context,
  itemName: 'Item contoh',
);

if (konfirmasi == true) {
  AppToast.sukses(context, 'Data berhasil dihapus');
}
```

### Format dan Parsing

```dart
final rupiah = FormatUang.formatRupiah(150000);
final tanggal = FormatTanggal.formatDasar(DateTime.now());
final angka = ParserUtil.parseIntOrNull('42');
```

## Pengembangan dan Verifikasi

```bash
flutter pub get
dart analyze
```

Regenerasi kode (setelah mengubah sumber Freezed/Riverpod):

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Catatan

- Folder `test/` belum tersedia di repositori ini, sehingga belum ada pengujian otomatis bawaan yang dapat dijalankan.
- Jangan mengedit berkas hasil generate (`*.g.dart`, `*.freezed.dart`) secara manual; ubah sumbernya lalu jalankan `build_runner`.
- Dokumentasi internal tambahan tersedia di `docs/` (mis. `laporan_linter.md`).
- Perubahan pada submodule ini perlu di-commit di repositori submodule dan pointer-nya diperbarui di repositori induk bila diperlukan.
