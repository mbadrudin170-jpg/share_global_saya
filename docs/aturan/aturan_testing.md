aturan_testing.md

# Aturan

semua method public di file state wajib dibuatkan file test nya.
mockito : untuk testing gunakan paket mockito.
struktur file : jika sebuah file yang ingin di test berada diposisi seperti ini `lib/fitur/bahan_bakar/state/bahan_bakar_state.dart` maka file test nya juga harus seperti ini `test/fitur/bahan_bakar/state/bahan_bakar_state.dart`.
Test state wajib menggunakan dummy data dari folder dummy,`Contoh: final state = BahanBakarState(listBahanBakar: dummyBahanBakar);`.
