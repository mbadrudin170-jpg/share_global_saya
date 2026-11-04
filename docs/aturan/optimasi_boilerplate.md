prompt/aturan/optimasi_boilerplate.md

# Aturan

2. state & model : selalu pakai freezed
3. paket : carikan paket paket dipub.dev gunakan tools `websearch` paket yang tujuan nya sama dengan kode kode saya, gunakan query umum misal nya paket loading, paket stream, paket notifikasi, paket apapun untuk query jangan terlalu spesifik, tugas anda cari semua nya kembalikan hasilnya ke saya berupa link link paket tersebut.
4. fungsi : contoh jika ada sebuah kode yang mirip di dua tempat usahakan buat satu file khusus untuk kode tersebut dan kedua file itu tinggal panggil kode yang di file baru tersebut.
5. abstraksi : Jangan membuat abstraksi hanya demi mengurangi jumlah kode ditulis. Setiap abstraksi harus memberikan manfaat yang jelas, seperti penggunaan ulang, pemisahan tanggung jawab, atau kemudahan pengujian.
6. Manfaatkan Fitur Bawaan : Sebelum menulis implementasi manual, periksa apakah Flutter, Dart, atau paket yang sudah digunakan menyediakan fungsi yang dibutuhkan. Jangan membuat ulang mekanisme yang sudah tersedia dan memadai.
7. jumlah kode :
   - Usahakan menggunakan jumlah kode yang efisien tanpa mengurangi keterbacaan, kejelasan, dan kemudahan pemeliharaan.
   - dengan tetap mempertahankan tujuan dan perilaku kode yang sama tetapi tidak boleh mengubah fungsi atau hasil yang diharapkan.
8. sdk : carika kode yang sudah dibuat oleh sebuah sdk cari dulu di lokal kalau tidak ada carikan di pub.dev.
9. folder notifier : khusus untuk menyimpan file class notifier saja misal untuk file yang bisa read.
10. folder provider : khusus untuk menyimpan file provider yang tidak mempunyai fungsi read.
11. Enum yang ditampilkan ke pengguna wajib memiliki getter label (dan icon bila perlu) via extension`Contoh: extension SortBahanBakarExtension on SortBahanBakarEnum { String get label { switch (this) { ... } } }`.
