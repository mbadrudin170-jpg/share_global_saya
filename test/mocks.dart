// Template mock manual memakai `package:mocktail` (tanpa codegen).
// Berkas ini BUKAN file test (bukan `*_test.dart`) sehingga tidak dijalankan
// oleh `flutter test`; import dari file test dengan `import 'mocks.dart';`.
//
// Cara pakai:
//   1. Pastikan `mocktail` ada di `dev_dependencies` (sudah terpasang, sesi 158).
//   2. Buat kelas mock manual untuk repository/service yang ingin di-mock:
//
//        import 'package:mocktail/mocktail.dart';
//
//        class MockXxx extends Mock implements Xxx {}
//
//   3. Stub dengan `when(() => mock.metode()).thenAnswer((_) async => ...);`
//      dan verifikasi dengan `verify(() => mock.metode()).called(1);`.
//
// Catatan: kelas dengan hanya static method (mis. `SharedPrefService`,
// `ParserUtil`, `L`) TIDAK bisa di-mock dengan mocktail; abstraksikan ke
// kelas/instance eksternal bila perlu di-mock (lihat skill `pola-testing`
// bagian 4 dan `hasil_diskusi/diskusi_5.md`, R-4).
