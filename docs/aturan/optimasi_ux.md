# Aturan

1. Operasi hapus: setiap operasi penghapusan harus memberi tahu pengguna bahwa data atau objek akan dihapus, dan selalu memunculkan konfirmasi sebelum dijalankan.
2. Bahasa formal dan baku: semua teks yang ditampilkan kepada pengguna harus bersifat formal dan baku sesuai negara masing-masing pengguna.
3. Kejelasan tampilan: jangan biarkan pengguna bingung dengan tampilan yang ada.
4. Kejelasan tujuan tindakan: pengguna harus dapat mengetahui tujuan dari setiap tindakan. Sebelum menekan tombol, pengguna harus dapat memahami tujuan tindakan tersebut.
5. Kepastian status operasi: pengguna tidak boleh menebak apakah suatu operasi sedang berjalan, berhasil, gagal, atau belum dijalankan. Status operasi harus jelas.
6. Feedback kepada pengguna: selalu informasikan hasil atau kondisi suatu operasi (info, sukses, peringatan, atau error) agar pengguna memiliki kepastian.
7. Proses background: untuk proses yang hasilnya tidak ditunggu pengguna, jalankan di background agar UI tidak membuat pengguna menunggu. Proses background tidak boleh membuat data cacat atau tidak konsisten.
8. Optimasi rebuild: jangan melakukan rebuild secara berlebihan. Rebuild hanya pada bagian UI yang membutuhkan pembaruan.
9. Pencegahan memory leak: pastikan tidak ada kebocoran memori. Setiap resource yang dapat di-dispose atau di-kill harus ditangani dengan benar.
10. Padding dari tepi layar: semua widget harus memiliki padding dari tepi layar.
11. Konsistensi jarak padding: setiap jarak padding harus serasi. Jangan gunakan padding yang terlalu dalam maupun terlalu luar.
12. Kunci aksi: setelah menekan tombol aksi, tampilkan loading dari paket `flutter_easyloading` (lihat contoh penggunaannya di file `example.md`). Dilarang membuat widget loading custom untuk loading tombol aksi.
13. Feedback sistem: (isi tujuannya).
14. Toast feedback wajib `AppToast`, bukan `Fluttertoast` langsung. Contoh: `AppToast.sukses(context, 'Bahan bakar berhasil dihapus')`.

## Text

1. Bold: harus dibedakan mana teks yang harus bold dan mana yang tidak.
