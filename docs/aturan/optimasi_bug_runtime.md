<!-- optimasi_bug_runtime.md -->

ganti seluruh isi file diatas dengan yang ada di bawah ini, tapi rangkai dulu kata katanya di setiap aturan agar bisa dengan mudah di baca oleh orang lain dan AI, tapi tujuan nya harus tetap sama.
untuk AI yang tidak bisa mengakses file nya cukup berikan saya isi final nanti saya salin sendiri.
jangan tambahkan aturan yang tidak ada dibawah ini.
jika ada aturan yang bentrok/duplikat dengan aturan difile ini atau pun di file AGENTS.md beritahukan ke saya jangan menebak nebak aturan mana yang benar, biar saya perbaiki dulu aturannya.
susun ulang nomor aturannya jika ada yang loncat.
setelah itu jalankan script script/build_rules_context.sh

# Aturan

1. data null : selalu atasi data null hindari `!` dan `as`, dan untuk tanda `??` jika jika data boleh diganti ke default boleh pakai tanda `??` tapi usahakan seminimal mungkin jangan pakai tanda `??`.
2. parsing :hindari `dynamic` parsing wajib pakai `tryParse` bukan `parse`.
   - semua constructor & variabel privat yang bernilai null wajib dijadikan variabel local dulu baru atasi nullnya
3. Baris database harus dibuatkan modelnya, Nama kolom dan nama tabelnya.
4. mounted : setelah await selalu cek ketersediaan mounted.
5. jangan membuat future di dalam build.
6. try/catch : selalu bungkus operasi dengan try/catch dan tambahkan logger contoh di bawah L.e dan kirim rethrow ke ui.
7. Dispose — tutup controller, stream subscription, timer, listener di dispose(); jangan setState setelah unmounted.
8. Transaksi DB dengan rollback — begin/commit/rollback pada insert/update/delete; rollback jika gagal dan rethrow.
9. string literasi : jangan gunakan string literasi usahakan ubah ke konstanta atau enum dulu.
10. await / unawaited : untuk aksi yang tidak perlu ditunggu harus gunakan unawaited, dan aksi yang harus ditunggu baru gunakan await. seperti navigasi jika tidak perlu ditunggu bungkus saja dengan unawaited.
    import : `import 'dart:async';`

11. logger : gunakan logger dari class `L` yang sudah ada
    L.i : alur normal (mulai proses, selesai proses, build selesai). Tidak boleh di dalam loop ketat.
    L.s : operasi berhasil (simpan, hapus, tambah ke DB).
    L.w : kondisi tidak normal yang tidak menggagalkan operasi (mis. data kosong, izin ditolak).
    L.e : error runtime yang di-catch. Wajib di dalam setiap blok catch.
12. analyzer : harus bersih dari lint analyzer tanpa error, info maupun warning baik itu folder lib maupun folder test.
13. "Restart aplikasi: panggil Restart.restartApp() dengan await, tangani RestartResult (cek success, code, message), periksa mounted sebelum setState, dan bungkus dengan try/catch dengan log L.e pada kegagalan."
14. Parsing nilai dynamic dari Map database/jaringan wajib ParserUtil.
15. Inisialisasi async di initState wajib Future.microtask + unawaited + guard mounted.
16. Guard aksi dengan flag \_sedangMemuat/\_isLoading untuk mencegah double-submit, Contoh: if (\_isLoading) return;.
