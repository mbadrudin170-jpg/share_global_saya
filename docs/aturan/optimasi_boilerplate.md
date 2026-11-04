# Aturan

1. (Tidak ada di sumber.)
2. State & model: selalu gunakan `freezed` untuk state dan model.
3. Paket: saat menyarankan atau menambahkan paket, gunakan tools `websearch` untuk mencari paket di pub.dev yang tujuan dan fungsinya sama dengan kebutuhan kode. Gunakan query umum, misalnya paket loading, paket stream, paket notifikasi, atau paket lainnya; jangan terlalu spesifik. Kembalikan hasilnya berupa tautan paket.
4. Fungsi: jika terdapat kode yang mirip di dua tempat atau lebih, buat satu file khusus untuk kode tersebut. Kedua file yang membutuhkan cukup memanggil kode dari file baru tersebut, agar tidak terjadi duplikasi dan lebih mudah dirawat.
5. Abstraksi: jangan membuat abstraksi hanya demi mengurangi jumlah baris kode. Setiap abstraksi harus memberikan manfaat yang jelas, seperti penggunaan ulang, pemisahan tanggung jawab, atau kemudahan pengujian.
6. Manfaatkan fitur bawaan: sebelum menulis implementasi manual, periksa apakah Flutter, Dart, atau paket yang sudah digunakan menyediakan fungsi yang dibutuhkan. Jangan membuat ulang mekanisme yang sudah tersedia dan memadai.
7. Jumlah kode:
   - Usahakan menggunakan jumlah kode yang efisien tanpa mengurangi keterbacaan, kejelasan, dan kemudahan pemeliharaan.
   - Tetap pertahankan tujuan dan perilaku kode yang sama, tetapi tidak boleh mengubah fungsi atau hasil yang diharapkan.
8. SDK: cari kode yang sudah dibuat oleh sebuah SDK. Cari terlebih dahulu secara lokal; jika tidak ditemukan, carikan di pub.dev.
9. Folder notifier: khusus untuk menyimpan file class notifier saja, yaitu file yang memiliki fungsi read.
10. Folder provider: khusus untuk menyimpan file provider yang tidak mempunyai fungsi read.
11. Enum yang ditampilkan ke pengguna wajib memiliki getter `label` (dan `icon` bila perlu) via extension. Contoh: `extension SortBahanBakarExtension on SortBahanBakarEnum { String get label { switch (this) { ... } } }`.
