aturan_testing.md


ganti seluruh isi file diatas dengan yang ada di bawah ini, tapi rangkai dulu kata katanya di setiap aturan agar bisa dengan mudah di baca oleh orang lain dan AI, tapi tujuan nya harus tetap sama.
untuk AI yang tidak bisa mengakses file nya cukup berikan saya isi final nanti saya salin sendiri.
jangan tambahkan aturan yang tidak ada dibawah ini.
jika ada aturan yang bentrok/duplikat dengan aturan difile ini atau pun di file AGENTS.md beritahukan ke saya jangan menebak nebak aturan mana yang benar, biar saya perbaiki dulu aturannya.
susun ulang nomor aturannya jika ada yang loncat.
setelah itu jalankan script script/build_rules_context.sh


# Aturan

semua method public di file state wajib dibuatkan file test nya.
mockito : untuk testing gunakan paket mockito.
struktur file : jika sebuah file yang ingin di test berada diposisi seperti ini `lib/fitur/bahan_bakar/state/bahan_bakar_state.dart`  maka file test nya juga harus seperti ini `test/fitur/bahan_bakar/state/bahan_bakar_state.dart`.
Test state wajib menggunakan dummy data dari folder dummy,`Contoh: final state = BahanBakarState(listBahanBakar: dummyBahanBakar);`.


