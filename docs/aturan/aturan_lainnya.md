prompt/aturan/aturan_lainnya.md

2. baca dulu `optimasi_ui.md` untuk mengetahui refrensi dsain yang saya inginkan.
3. selalu baca isi dari folder `/flutter/bin/cache/` untuk sdk flutter dan dart atau baca `/.pub-cache/hosted/pub.dev/` untuk paket pihak ketiga.
4. instal paket : jika ingin menginstall paket harus pakai flutter pub add / flutter pub remove jangan tulis manual di `pubscl.yml`.
5. flutter analyze & dart format : selalu jalankan flutter analyze setelah melakukan pekerjaan agar tidak error lagi, lalu rapikan kodenya dengan menjalankan dart format untuk file file itu.
6. fokus ke code yang di dalam topik saja, selalu gunakan tools yang hanya edit sebagian kode tidak menulis ulang seluruh kode meminimalisir kesalahan.
7. jangan edit file .g.dart dan .freezed.dart.
8. konsisten : kode wajib konsisten kalau perlu cari referensi dari code di file file lain untuk referensi.
9. print / debug print : dilarang pakai print atau debug print selalu gunakan class p yang sudah ada untuk mencetk log di console.
10. log debug : untuk debug gunakan class l.dart yang sudah ada untuk mencetak log ke apk bukan ke console.
11. penamaan : Variabel, fungsi, class, method, getter, dan provider wajib menggunakan bahasa Indonesia sesuai konvensi proyek; nama file wajib snake case, lalu usahakan namanya singkat namun bisa di pahami maksudnya hanya dengan melihat nama nya, untuk nama file wajib snack case;
12. Dokumentasi Kode — Tambahkan doc comment (///) pada API publik dan logika kompleks;
13. git : hanya untuk read saja selain itu tanyakan user.
14. Manajemen Resource — Aset (gambar, font) wajib didaftarkan di pubspec.yaml dan dimuat via path yang konsisten.
15. baca kode : selalu baca kode terlebih dahulu sebelum menganalisa, karena berasumsi liar itu dilarang di projek saya, khusus untuk AI jangan terlalu mengandalkan cache karena cache bisa base.
16. Font — Gunakan google fonts dengan cache; jangan load font dari jaringan berulang.
17. Splash Screen — Gunakan flutter native splash untuk splash; jangan buat manual.
18. Toast — Gunakan flutter toast untuk feedback singkat; hindari spam toast.
19. UUID — Gunakan uuid untuk ID unik; jangan gunakan timestamp sebagai ID.
20. Shared Preferences — Gunakan untuk pengaturan sederhana; jangan simpan data sensitif atau besar.
21. Daftar Panjang — Gunakan ListView.builder/SliverList untuk daftar > 20 item; jangan render semua item sekaligus.
22. alur kerja : jadi alurnya begini kita analisis dulu apa yang kita inginkan misalnya menampilkan judul, nah kita analisa cara menampilkan judul itu bagaimana, kita baca pubscl.lock kota cari kode nya di di sebelah mana apakah di flutter atau di pub.cache, nah jika ternyata ada di flutter maka kita cari di folder flutter apa saja kode nya pasti kan setiap kode di flutter dan di paket pihak ketiga itu cuma pembantu mempermudah kita untuk membuat sebuah aplikasi, maka jika di dalam kode kita membutuhkan kode dari mereka itu, kita wajib mengikuti aturan nya, maksudnya mengikuti aturan nya itu supaya kode kita itu tidak ada error dan bug runtime. ya kalau bisa cari di web misal nya cara menampilkan judul di atas layar, nah jika ada kita baca dari dokumentasi resminya baik itu dari flutter, dart dan paket pihak ketiga itu. sebisa mungkin kita baca kode dari flutter dan pub.cache karena terkadang pelatihan ai itu tidak menyimpan kode versi flutter dart dan paket pihak ketiga yang saya install ini, dan juga dengan membaca kode mereka itu kita bisa tahu bahwa ternyata ada yang deprecated, ternyata ada konstruktor baru, parameter baru, sedangkan kita tidak akan tahu jika kita tidak melihat nya.
23. kalau kita mengerjakan sebuah kode kita wajib baca file -file dependency nya kemungkinan masalah nya bukan berada di file ini mungkin di file lain.
24. minal anda read 10 file gitu untuk pengecekan jangan khawatirkan token.
25. semua aturan di file ini wajib dipatuhi jangan sampai ada satupun aturan yang diabaikan.
26. khusus AI kalau ingin merubah kode AI gunakan tools write/edit dulu jangan pakai terminal.
27. perintah cari : gunakan rg untuk untuk mencari teks, gunakan glob untuk mencari file berdasarkan nama, gunakan ls untuk melihat isi satu folder,pakai grep -rn hanya jika rg gagal, Jika `rg` dilaporkan belum terinstall, jalankan `which rg` lewat perintah shell dulu dan jangan langsung berhenti.
28. question : selalu berikan pertanyaan ke saya dengan tools question jangan menebak nebak saya tidak suka itu, biarkan saya beri kepastian.
29. komentar dokumen : format dokumen wajib pakai `///` dan hanya satu baris saja jangan terlalu panjang juga.
30. SKILLs : selalu baca skills yang tersedia atau load skills nya dulu agar AI bisa mendapatkan pengetahuan baru.
31. tool todowrite : gunakan tool ini untuk peta jalan agar saya tahu apa saja yang akan anda kerjakan.
32. example : selalu baca folder example dari masing masing paket di .pub.cache untuk mengetahui implementasikan paket tersebut apakah implementasi di projek saya tidak sesuai dengan folder example yang disediakan oleh paket.
33. Inisialisasi sqflite FFI: panggil sqfliteFfiInit() dan set databaseFactory sesuai platform (databaseFactoryFfi untuk desktop, databaseFactoryFfiWeb untuk web) sebelum membuka database."
34. komentar : hapus komentar yang tidak penting.
35. Navigasi antar halaman wajib helper Nav (core_shared), ` Contoh: unawaited(Nav.to(context, const StatistikBahanBakar()))`.
36. Import wajib `package:` (bukan relative import).
    Contoh: `import 'package:myapp/fitur/.../x.dart';`
