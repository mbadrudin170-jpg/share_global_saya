# Laporan Linter `share_global_saya`

Dokumen ini mencatat hasil `flutter analyze` pada submodule `share_global_saya` beserta rencana penanganan temuan linter. Dokumen bersifat rujukan kerja; perubahan kode tetap dilakukan pada berkas sumber yang bersangkutan.

## Status

- Tanggal analisis: 2026-11-14
- Perintah: `flutter analyze` (dijalankan dari root `share_global_saya`)
- Flutter: 3.47.9 (stable), Dart 3.13.7
- Hasil: **235 temuan, seluruhnya level `info`** (0 `warning`, 0 `error`)
- Status implementasi perbaikan: **Belum Diimplementasikan**

## Ringkasan Temuan

| Aturan linter | Jumlah | Sifat |
| --- | ---: | --- |
| `public_member_api_docs` | 231 | Dokumentasi API publik belum lengkap |
| `discarded_futures` | 3 | `Future` dibuang tanpa `await`/`unawaited` |
| `avoid_print` | 1 | Pemakaian `print` langsung |
| **Total** | **235** | Seluruhnya `info` |

Catatan: `flutter analyze` keluar dengan kode `1` karena masih ada temuan, meskipun tidak ada error kompilasi. Submodule `base_coc` terpisah dan bersih (`No issues found`).

## Sebaran per Berkas

| Berkas | `public_member_api_docs` | Temuan lain |
| --- | ---: | --- |
| `lib/src/widget/input/input_teks.dart` | 40 | - |
| `lib/src/widget/input/input_rupiah.dart` | 21 | - |
| `lib/src/widget/input/input_angka.dart` | 19 | - |
| `lib/src/utils/format_utils.dart` | 16 | - |
| `lib/log_debug/overlay_log_debug.dart` | 15 | - |
| `lib/src/widget/input/input_telepon.dart` | 13 | - |
| `lib/src/utils/shared_pref_service.dart` | 13 | - |
| `lib/db/model/log_debug_model.dart` | 13 | - |
| `lib/src/widget/input/input_password.dart` | 12 | - |
| `lib/src/widget/input/input_autocomplete.dart` | 12 | - |
| `lib/src/utils/l.dart` | 11 | `discarded_futures` (1) |
| `lib/log_debug/log_debug_notifier.dart` | 11 | - |
| `lib/src/widget/pemilih_tanggal_waktu.dart` | 8 | - |
| `lib/src/utils/parser_util.dart` | 6 | - |
| `lib/src/widget/toast_widget.dart` | 5 | - |
| `lib/log_debug/log_debug_page.dart` | 5 | `discarded_futures` (2) |
| `lib/src/widget/confirmation_dialog.dart` | 4 | - |
| `lib/src/utils/async_value_x.dart` | 2 | - |
| `lib/src/utils/app_keys.dart` | 2 | - |
| `lib/src/widget/input/rupiah_input_formatter.dart` | 1 | - |
| `lib/src/widget/input/input_dropdown.dart` | 1 | - |
| `lib/log_debug/print_custom.dart` | 1 | `avoid_print` (1) |

## Temuan Non-Dokumentasi

### 1. `lib/log_debug/log_debug_page.dart:28` — `discarded_futures`

`_loadData()` mengembalikan `Future<void>` dan dipanggil di `initState` tanpa ditunggu.

```dart
// Sebelum
@override
void initState() {
  super.initState();
  _loadData();
}
```

```dart
// Sesudah — pilih salah satu
import 'dart:async';

@override
void initState() {
  super.initState();
  unawaited(_loadData());
}
```

Alternatif: ubah `_loadData` agar menangani error sendiri dan tetap gunakan `unawaited`; `initState` tidak boleh menjadi `async`.

### 2. `lib/log_debug/log_debug_page.dart:229` — `discarded_futures`

`Clipboard.setData(...)` mengembalikan `Future<void>` dan tidak ditunggu di dalam `onPressed`.

```dart
// Sebelum
onPressed: () {
  final valueText = _formatValue(entry.value);
  Clipboard.setData(ClipboardData(text: valueText));
  AppToast.sukses(context, 'Nilai "${entry.key}" disalin ke clipboard');
},
```

```dart
// Sesudah
onPressed: () async {
  final valueText = _formatValue(entry.value);
  await Clipboard.setData(ClipboardData(text: valueText));
  if (!context.mounted) return;
  AppToast.sukses(context, 'Nilai "${entry.key}" disalin ke clipboard');
},
```

### 3. `lib/src/utils/l.dart:112` — `discarded_futures`

`tambah(model)` pada notifier mengembalikan `Future`, sementara pemanggilnya berada di callback non-`async`.

```dart
// Sebelum
Future.delayed(const Duration(milliseconds: 50), () {
  try {
    container.read(logDebugProvider.notifier).tambah(model);
  } catch (e) {
    if (kDebugMode) debugPrint('L._kirimKeOverlayDebug gagal: $e');
  }
});
```

```dart
// Sesudah
unawaited(Future.delayed(const Duration(milliseconds: 50), () async {
  try {
    await container.read(logDebugProvider.notifier).tambah(model);
  } catch (e) {
    if (kDebugMode) debugPrint('L._kirimKeOverlayDebug gagal: $e');
  }
}));
```

Pastikan `dart:async` diimpor untuk `unawaited`. `try/catch` hanya menangkap error bila `Future` ditunggu, sehingga `await` lebih aman daripada sekadar `unawaited`.

### 4. `lib/log_debug/print_custom.dart:6` — `avoid_print`

Fungsi `p` adalah pembungkus debug yang sengaja memakai `print`.

```dart
// Sebelum
if (aktif && kDebugMode) {
  print(pesan);
}
```

```dart
// Sesudah — gunakan debugPrint yang sudah tersedia
if (aktif && kDebugMode) {
  debugPrint(pesan);
}
```

Alternatif yang dipertahankan hanya bila `print` memang dibutuhkan untuk perilaku tertentu: tambahkan `// ignore: avoid_print` dengan alasan eksplisit di baris yang sama. Opsi ini tidak dianjurkan untuk pustaka bersama.

## Strategi Penanganan `public_member_api_docs`

Aturan `public_member_api_docs` aktif di `analysis_options.yaml`. Seluruh anggota publik pada `lib/` wajib memiliki doc comment `///`. Berkas hasil generate (`*.g.dart`, `*.freezed.dart`) sudah dikecualikan dan tidak perlu disentuh.

### Urutan Pengerjaan yang Dianjurkan

1. Selesaikan empat temuan non-dokumentasi di atas agar perilaku async dan logging benar lebih dahulu.
2. Dokumentasikan berkas dengan jumlah temuan kecil terlebih dahulu: `rupiah_input_formatter.dart`, `input_dropdown.dart`, `app_keys.dart`, `async_value_x.dart`.
3. Lanjutkan ke kelompok widget input (`input_teks.dart`, `input_rupiah.dart`, `input_angka.dart`, `input_telepon.dart`, `input_password.dart`, `input_autocomplete.dart`).
4. Lanjutkan ke utilitas (`format_utils.dart`, `shared_pref_service.dart`, `l.dart`, `parser_util.dart`).
5. Lanjutkan ke logging (`overlay_log_debug.dart`, `log_debug_notifier.dart`, `log_debug_page.dart`, `print_custom.dart`).
6. Terakhir: `pemilih_tanggal_waktu.dart`, `toast_widget.dart`, `confirmation_dialog.dart`, dan `log_debug_model.dart`.
7. Verifikasi dengan `dart format lib test` lalu `flutter analyze` sampai bersih.

### Pola Doc Comment yang Benar

Dokumentasikan kelas, konstruktor, field, getter, method, enum, dan extension publik. Gunakan kalimat ringkas yang menjelaskan tujuan, bukan mengulang nama identifier.

```dart
/// Widget input teks dengan label, ikon, dan validasi opsional.
class InputTeks extends StatelessWidget {
  /// Membuat input teks dengan konfigurasi yang diberikan.
  const InputTeks({
    super.key,
    required this.label,
  });

  /// Label yang ditampilkan di atas kolom input.
  final String label;
}
```

```dart
/// Format nilai numerik menjadi teks rupiah.
///
/// Mengembalikan string kosong bila [nilai] bernilai `null`.
String formatRupiah(num? nilai) {
  // ...
}
```

### Contoh Salah

```dart
// salah: doc comment hanya mengulang nama method tanpa menjelaskan perilaku
/// Mengambil data.
Future<void> ambilData() async {
  // ...
}
```

## Larangan Saat Perbaikan

- DILARANG mengedit berkas hasil generate (`*.g.dart`, `*.freezed.dart`, `*.mocks.dart`); ubah sumber lalu jalankan `build_runner`.
- DILARANG menonaktifkan `public_member_api_docs` hanya untuk menghilangkan temuan tanpa keputusan pengguna.
- DILARANG mengubah perilaku kode selain yang diperlukan untuk memperbaiki temuan linter.
- DILARANG menghapus atau menyederhanakan doc comment yang sudah ada.
- DILARANG memakai `// ignore:` tanpa alasan tertulis yang disetujui pengguna.

## Verifikasi

Jalankan dari root `share_global_saya`:

```bash
dart format lib test
flutter analyze
```

Kriteria selesai:

- `flutter analyze` melaporkan `No issues found!`.
- Tidak ada perubahan pada berkas hasil generate.
- Tidak ada penurunan cakupan dokumentasi API publik.

## Rujukan

- Konfigurasi linter: `share_global_saya/analysis_options.yaml`
- Ekspor API publik: `share_global_saya/lib/core_shared.dart`
- Perintah terkait: `share_global_saya/docs/commands/cek_linter.md`, `share_global_saya/docs/commands/perbaiki_linter.md`
