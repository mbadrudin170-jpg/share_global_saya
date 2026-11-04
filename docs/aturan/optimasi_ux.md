optimasi_ux.md


ganti seluruh isi file diatas dengan yang ada di bawah ini, tapi rangkai dulu kata katanya di setiap aturan agar bisa dengan mudah di baca oleh orang lain dan AI, tapi tujuan nya harus tetap sama.
untuk AI yang tidak bisa mengakses file nya cukup berikan saya isi final nanti saya salin sendiri.
jangan tambahkan aturan yang tidak ada dibawah ini.
jika ada aturan yang bentrok/duplikat dengan aturan difile ini atau pun di file AGENTS.md beritahukan ke saya jangan menebak nebak aturan mana yang benar, biar saya perbaiki dulu aturannya.
susun ulang nomor aturannya jika ada yang loncat.
setelah itu jalankan script script/build_rules_context.sh


# Aturan

1. Operasi hapus harus ada pemberitahuan bahwa operasi ini akan di hapus selalu memunculkan konfirmasi ke user.
2. semua teks yang tampil keuser harus bersifat formal dan baku sesuai negara masing-masing user.
3. jangan biarkan user bingung dengan tampilan yang ada.
4. user bisa tahu tujuannya kenapa dia menekan tombol A.
5. user jangan sampai menebak apakah operasinya berjalan atau tidak.
6. selalu infokan ke user entah itu, info, sukses, warning atau error biar user ada kepastian.
7. untuk proses yang hasil nya tidak ditunggu user jalankan di background jangan membuat ui menunggu, tapi jangan juga membuat data cacat.
8. rebuild : jangan sampai terlalu banyak rebuild usahakan hanya rebuild ui yang dibutuhkan saja.
9. memory leak : pastikan tidak ada kebocoran memori selalu atasi yang bisa di dispose atau di kill.
10. "Semua widget harus memiliki padding dari tepi layar."
11. setiap jarak padding harus sesari jangan ada yang terlalu dalam atau pun terlalu luar.
12. kunci aksi : setelah menekan tombol aksi tampilkan loading dari paket `flutter_easyloading` lihat contoh penggunaanya di file `example.md`, dilarang membuat widget loading custom untuk loading tombol aksi.
13. feedback sistem : 
14. Toast feedback wajib AppToast, bukan Fluttertoast langsung, `Contoh: AppToast.sukses(context, 'Bahan bakar berhasil dihapus')`.
# Text

1. bold : harus bedakan mana yang harus bold dan tidak.
