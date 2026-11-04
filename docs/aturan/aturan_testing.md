# Aturan

1. Semua method public di file state wajib dibuatkan file test-nya.
2. Untuk testing gunakan paket `mockito`.
3. Struktur file test harus mencerminkan struktur file sumber yang diuji. Contoh: jika file yang diuji berada di `lib/fitur/bahan_bakar/state/bahan_bakar_state.dart`, maka file test-nya harus berada di `test/fitur/bahan_bakar/state/bahan_bakar_state.dart`.
4. Test state wajib menggunakan dummy data dari folder dummy. Contoh: `final state = BahanBakarState(listBahanBakar: dummyBahanBakar);`.
