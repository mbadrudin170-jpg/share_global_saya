# Optimasi Boilerplate

**Path:** `prompt/aturan/optimasi_boilerplate.md`

## Aturan

### 1. State dan Model

- Wajib menggunakan `Freezed` untuk seluruh pembuatan state dan model data, meliputi:
  - Domain model.
  - State notifier.
  - DTO.
  - Entity.
- Class yang berfungsi sebagai descriptor, view model agregat untuk kebutuhan rendering, atau helper UI yang berisi callback/fungsi boleh menggunakan class manual tanpa `Freezed`.
- Pengecualian tersebut berlaku selama class tidak membutuhkan `copyWith`, equality berbasis nilai, atau serialisasi.
- Jika kebutuhan class manual berkembang sehingga memerlukan `copyWith`, equality berbasis nilai, atau serialisasi, pertimbangkan untuk mengonversinya menjadi `Freezed`.

### 2. Pencarian Paket di pub.dev

- Cari paket yang tersedia di `pub.dev` menggunakan tool `websearch`.
- Bandingkan tujuan dan fungsi paket dengan kode yang sudah ada di proyek.
- Gunakan kata kunci pencarian yang umum dan tidak terlalu spesifik, misalnya:
  - Paket loading.
  - Paket stream.
  - Paket notifikasi.
  - Paket lain sesuai fungsi kode yang ditemukan.
- Lakukan pencarian secara luas berdasarkan kebutuhan dan fungsi kode yang sudah digunakan dalam proyek.
- Sampaikan hasil pencarian kepada pengguna dalam bentuk daftar tautan paket `pub.dev`.
- Jangan langsung memasang atau mengganti paket. Cukup berikan hasil pencarian agar pengguna dapat mengevaluasinya.

### 3. Enum yang Ditampilkan kepada Pengguna

- Setiap enum yang ditampilkan kepada pengguna wajib memiliki getter `label` melalui extension.
- Jika diperlukan, extension juga dapat menyediakan getter `icon`.
- Gunakan `switch` untuk menentukan nilai berdasarkan setiap anggota enum.

Contoh:

```dart
extension SortBahanBakarExtension on SortBahanBakarEnum {
  String get label {
    switch (this) {
      // Sesuaikan dengan anggota enum.
    }
  }
}
```

### 4. Penggunaan Ulang Fungsi

- Jika terdapat kode dengan fungsi atau tujuan yang sama di dua tempat atau lebih, pertimbangkan untuk memindahkannya ke satu file khusus.
- File yang membutuhkan fungsi tersebut cukup memanggil fungsi dari file bersama.
- Tujuannya adalah menghindari duplikasi implementasi dan mempermudah pemeliharaan kode.
- Pastikan pemindahan kode tidak mengubah fungsi maupun hasil yang diharapkan.

### 5. Penggunaan Abstraksi

- Jangan membuat abstraksi hanya untuk mengurangi jumlah baris kode.
- Setiap abstraksi harus memberikan manfaat yang jelas, seperti:
  - Memungkinkan penggunaan ulang kode.
  - Memisahkan tanggung jawab.
  - Mempermudah pengujian.
- Hindari abstraksi yang justru menambah kompleksitas tanpa memberikan manfaat yang sepadan.

### 6. Memanfaatkan Fitur Bawaan

- Sebelum membuat implementasi secara manual, periksa terlebih dahulu apakah Flutter, Dart, atau paket yang sudah digunakan menyediakan fitur atau fungsi yang dibutuhkan.
- Jika tersedia fitur bawaan yang sudah memadai, manfaatkan fitur tersebut daripada membuat ulang mekanisme yang sama secara manual.

### 7. Efisiensi Jumlah Kode

- Usahakan menulis kode secara efisien tanpa mengurangi:
  - Keterbacaan.
  - Kejelasan.
  - Kemudahan pemeliharaan.
- Efisiensi kode tidak boleh mengubah fungsi, perilaku, maupun hasil yang diharapkan dari implementasi sebelumnya.

### 8. Pemanfaatan Kode SDK

- Sebelum membuat implementasi sendiri, cari terlebih dahulu apakah kode atau fungsi yang dibutuhkan sudah tersedia dalam SDK.
- Lakukan pencarian pada sumber SDK yang tersedia secara lokal terlebih dahulu.
- Jika tidak ditemukan, lanjutkan pencarian pada dokumentasi atau sumber kode paket terkait di `pub.dev`.
- Manfaatkan implementasi yang sudah tersedia apabila sesuai dengan kebutuhan proyek.

### 9. Pemisahan Folder Notifier dan Provider

- **Folder `notifier`:** khusus untuk menyimpan file yang berisi class notifier, termasuk notifier yang menyediakan fungsi pembacaan data (_read_).
- **Folder `provider`:** khusus untuk menyimpan file provider yang tidak memiliki fungsi `read`.
