# Aturan

1. Gunakan file ini sebagai referensi untuk layout, font, jarak, ukuran, padding, dan margin.
2. Semua desain UI/UX harus merujuk ke file ini.
3. Dilarang membuat nilai baru untuk ukuran, jarak, padding, dan margin; gunakan file ini sebagai referensi.
4. Terapkan ketentuan ini di seluruh file `.dart` agar tampilan konsisten, profesional, dan premium.
5. Warna: gunakan `Theme.of(context)` untuk teks maupun elemen lainnya agar responsif terhadap mode tema. Warna boleh di-hardcode hanya jika memang sengaja agar sama di semua mode. Nilai hex dan RGBA jangan diubah menjadi colorscheme.
6. Text overflow: antisipasi teks yang diperkirakan panjang agar tidak overflow. Gunakan `FittedBox` atau `Flexible` hanya untuk teks yang wajib terlihat dan tidak boleh terpotong.
7. Jarak antar anak:
   - Row dan Column: gunakan properti `spacing` untuk jarak antar anak. Gunakan `SizedBox` hanya untuk jarak khusus.
   - Teks: gunakan `Theme.of(context).textTheme`, lalu `copyWith` untuk penyesuaian. Warna boleh di-hardcode jika diperlukan agar sesuai untuk mode terang dan gelap.
8. Dialog konfirmasi: gunakan komponen yang tersedia di paket `adaptive_dialog`.
