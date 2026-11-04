# Aturan

1. Data null: selalu tangani nilai `null` dengan aman. Hindari operator `!` dan cast `as`. Gunakan `??` hanya jika data boleh diganti ke nilai default, dan minimalkan penggunaannya.
2. Parsing: hindari parsing bertipe `dynamic`. Wajib gunakan `tryParse`, bukan `parse`. Semua constructor dan variabel privat yang bernilai `null` wajib dijadikan variabel lokal terlebih dahulu, baru tangani nilai `null`-nya.
3. Baris database: setiap baris database wajib dibuatkan model yang merepresentasikannya, lengkap dengan nama kolom dan nama tabel.
4. Mounted: setelah operasi `await`, selalu periksa ketersediaan `mounted` sebelum melanjutkan.
5. Future di dalam build: jangan membuat `Future` langsung di dalam fungsi `build`.
6. Try/catch: selalu bungkus operasi dengan blok `try`/`catch`. Tambahkan log dari class `L` (`L.e` pada blok `catch`) dan kirim `rethrow` ke UI.
7. Dispose: tutup controller, stream subscription, timer, dan listener di `dispose()`. Jangan memicu `setState` setelah widget unmounted.
8. Transaksi DB dengan rollback: bungkus operasi tulis database (`insert`/`update`/`delete`) dengan transaksi (`begin`/`commit`/`rollback`). Jika gagal, lakukan rollback dan kirim `rethrow`.
9. String literasi: jangan gunakan string literasi. Ubah ke konstanta atau enum terlebih dahulu.
10. Await/unawaited: untuk aksi yang tidak perlu ditunggu, gunakan `unawaited`. Untuk aksi yang harus ditunggu, gunakan `await`. Misalnya, navigasi yang tidak perlu ditunggu cukup dibungkus dengan `unawaited`.
    - Import: `import 'dart:async';`
11. Logger: gunakan logger dari class `L`.
    - `L.i`: alur normal (mulai proses, selesai proses, build selesai). Tidak boleh di dalam loop ketat.
    - `L.s`: operasi berhasil (simpan, hapus, tambah ke DB).
    - `L.w`: kondisi tidak normal yang tidak menggagalkan operasi (mis. data kosong, izin ditolak).
    - `L.e`: error runtime yang di-catch. Wajib di dalam setiap blok `catch`.
12. Analyzer: kode wajib bersih dari lint analyzer, tanpa error, info, maupun warning, baik pada folder `lib` maupun folder `test`.
13. Restart aplikasi: panggil `Restart.restartApp()` dengan `await`. Tangani `RestartResult` dengan memeriksa `success`, `code`, dan `message`. Periksa `mounted` sebelum memanggil `setState`. Bungkus operasi dengan try/catch dan catat kegagalan dengan `L.e`.
14. Parsing nilai dynamic dari Map database/jaringan wajib menggunakan `ParserUtil`.
15. Inisialisasi async di `initState` wajib menggunakan `Future.microtask` + `unawaited` + guard `mounted`.
16. Guard aksi dengan flag `_sedangMemuat`/`_isLoading` untuk mencegah double-submit. Contoh: `if (_isLoading) return;`.
