# Saran Aturan Baru

## Tujuan
Mengidentifikasi pola/konvensi yang sering muncul di kode tetapi belum diatur, lalu memberikan saran aturan baru.

## Langkah Kerja
1. Baca file `AGENTS.md` di root proyek untuk mengetahui aturan yang sudah ada.
2. Pindai kode di folder `lib/` dan `test/`, kecuali file `.g.dart` dan `.freezed.dart`.
3. Identifikasi pola, konvensi, atau praktik yang sering muncul di kode tetapi belum diatur oleh file aturan yang ada.
4. Tulis hasil ke file `saran_aturan_baru.md` di root proyek dengan format yang konsisten.
5. Jangan ubah kode Dart maupun file aturan yang sudah ada.
6. Tentukan apakah saran harus ditambahkan ke file apa di folder `prompt/aturan` atau saran buat file aturan baru di folder `prompt/aturan`.
7. Hapus saran aturan baru di file `saran_aturan_baru` di root jika ternyata aturan tersebut sudah ada di `AGENTS.md`.
8. Cari di web dan GitHub aturan-aturan yang biasa dibuat orang untuk AI, lalu pilih yang sesuai dengan proyek ini.
9. Cari referensi dari proyek orang lain (web/GitHub) walaupun itu untuk AI agent.
10. Terutama GitHub yang menunjukkan cara `Flutter Architecture Patterns`, `Flutter Clean Architecture Boilerplate`, `Flutter Architecture Hub`, `Flutter Riverpod Best Practices`.
11. Link referensi:
    1. GitHub: https://github.com/flutter/flutter
    2. Flutter:
       - https://docs.flutter.dev/resources/inside-flutter
       - https://docs.flutter.dev/app-architecture/concepts#layered-architecture
       - https://docs.flutter.dev/app-architecture/guide
       - https://docs.flutter.dev/app-architecture/case-study
       - https://docs.flutter.dev/app-architecture/case-study/ui-layer
       - https://docs.flutter.dev/app-architecture/case-study/data-layer
       - https://docs.flutter.dev/app-architecture/case-study/testing
       - https://docs.flutter.dev/app-architecture/case-study/dependency-injection
       - https://docs.flutter.dev/app-architecture/design-patterns
       - https://docs.flutter.dev/app-architecture/recommendations
       - https://docs.flutter.dev/perf/rendering-performance
       - https://docs.flutter.dev/perf/best-practices
       - https://docs.flutter.dev/perf/antialiasing
       - https://docs.flutter.dev/perf/impeller
       - https://docs.flutter.dev/perf
       - https://docs.flutter.dev/app-architecture/design-patterns
       - https://docs.flutter.dev/perf/isolates
12. Berikan saran aturan dari referensi-referensi tersebut, terutama mengenai Flutter dan Dart.

## Larangan
- (Tidak ada.)

## Ketentuan
- (Tidak ada.)
