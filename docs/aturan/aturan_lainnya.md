# Aturan

1. (Nomor 1 tidak ada di sumber.)
2. Baca terlebih dahulu `optimasi_ui.md` sebagai referensi desain UI/UX (layout, font, jarak, ukuran, padding, dan margin).
3. Jadikan folder `/flutter/bin/cache/` (SDK Flutter dan Dart) serta `/.pub-cache/hosted/pub.dev/` (paket pihak ketiga) sebagai sumber kebenaran.
4. Untuk instalasi atau penghapusan paket, gunakan `flutter pub add` atau `flutter pub remove`. Jangan menulis langsung di `pubspec.yaml`.
5. Selalu jalankan `flutter analyze` setelah bekerja agar error tidak tertinggal, lalu rapikan kode dengan `dart format` pada file-file yang diubah.
6. Fokus hanya pada kode dalam topik yang sedang dikerjakan. Gunakan alat yang mengedit sebagian kode, bukan menulis ulang seluruh file, untuk meminimalkan kesalahan.
7. Dilarang mengedit file `.g.dart` dan `.freezed.dart`.
8. Kode wajib konsisten. Jika perlu, cari referensi dari kode di file lain dalam proyek.
9. Dilarang menggunakan `print` atau `debugPrint`. Untuk log console, selalu gunakan fungsi `p` yang sudah ada.
10. Untuk debug, gunakan class `L` pada `l.dart` yang sudah ada agar log tercetak ke APK, bukan ke console.
11. Variabel, fungsi, class, method, getter, dan provider wajib menggunakan bahasa Indonesia sesuai konvensi proyek. Nama file wajib `snake_case`. Usahakan namanya singkat namun mudah dipahami hanya dengan melihat namanya.
12. Tambahkan doc comment (`///`) pada API publik dan logika kompleks agar mudah dipahami saat pemeliharaan.
13. Git hanya digunakan untuk operasi baca. Untuk operasi lain, tanyakan terlebih dahulu kepada pengguna.
14. Aset seperti gambar dan font wajib didaftarkan di `pubspec.yaml` dan dimuat melalui path yang konsisten.
15. Selalu baca kode terlebih dahulu sebelum menganalisis; berasumsi liar dilarang. Khusus AI, jangan terlalu mengandalkan cache karena cache bisa basi.
16. Gunakan `google_fonts` dengan cache; jangan memuat font dari jaringan secara berulang.
17. Gunakan `flutter_native_splash` untuk splash screen; jangan membuat splash secara manual.
18. Gunakan `fluttertoast` untuk feedback singkat; hindari spam toast.
19. Gunakan paket `uuid` untuk ID unik; jangan menggunakan timestamp sebagai ID.
20. Gunakan `SharedPreferences` hanya untuk pengaturan sederhana; jangan menyimpan data sensitif atau data berukuran besar.
21. Untuk daftar dengan lebih dari 20 item, wajib gunakan `ListView.builder` atau `SliverList`; jangan merender semua item sekaligus.
22. Analisis dulu hasil yang diinginkan, lalu cara menampilkannya. Baca `pubspec.lock` untuk mengetahui paket terinstal, dan cari kode di SDK Flutter atau `pub-cache`. Kode Flutter dan paket pihak ketiga hanya pembantu; jika membutuhkan kode dari mereka, ikuti aturannya agar tidak terjadi error atau bug runtime. Baca juga dokumentasi resmi Flutter, Dart, dan paket pihak ketiga bila perlu. Terutama baca kode dari folder Flutter dan `pub-cache` langsung, karena pelatihan AI terkadang tidak menyimpan kode versi Flutter, Dart, dan paket yang terinstal; dari kode tersebut kita bisa tahu bagian yang sudah deprecated, konstruktor baru, atau parameter baru.
23. Saat mengerjakan sebuah kode, wajib baca file-file dependency-nya; kemungkinan masalahnya bukan berada di file ini, melainkan di file lain.
24. Jangan khawatirkan token; lakukan pengecekan dengan membaca minimal sekitar 10 file.
25. Semua aturan di file ini wajib dipatuhi tanpa pengecualian.
26. Khusus AI: jika ingin mengubah kode, gunakan tool `write` / `edit` terlebih dahulu; jangan gunakan terminal.
27. Untuk pencarian: gunakan `rg` untuk mencari teks, `glob` untuk mencari file berdasarkan nama, dan `ls` untuk melihat isi satu folder. Gunakan `grep -rn` hanya jika `rg` gagal. Jika `rg` dilaporkan belum terinstal, jalankan `which rg` lewat perintah shell terlebih dahulu dan jangan langsung berhenti.
28. Selalu berikan pertanyaan kepada pengguna dengan tool `question`; jangan menebak-nebak; biarkan pengguna memberi kepastian.
29. Format dokumentasi wajib pakai `///` dan hanya satu baris saja; jangan terlalu panjang.
30. Selalu baca atau load skill yang tersedia terlebih dahulu agar AI bisa mendapatkan pengetahuan baru.
31. Gunakan tool `todowrite` sebagai peta jalan agar pengguna tahu apa saja yang akan dikerjakan.
32. Selalu baca folder `example` dari masing-masing paket di `.pub-cache` untuk mengetahui implementasi paket tersebut, serta memastikan implementasi di proyek sesuai dengan contoh yang disediakan oleh paket.
33. Panggil `sqfliteFfiInit()` dan set `databaseFactory` sesuai platform (`databaseFactoryFfi` untuk desktop, `databaseFactoryFfiWeb` untuk web) sebelum membuka database.
34. Hapus komentar yang tidak penting agar kode tetap bersih dan mudah dibaca.
35. Navigasi antar halaman wajib helper `Nav` (core_shared). Contoh: `unawaited(Nav.to(context, const StatistikBahanBakar()))`.
36. Import wajib `package:` (bukan relative import). Contoh: `import 'package:myapp/fitur/.../x.dart';`
