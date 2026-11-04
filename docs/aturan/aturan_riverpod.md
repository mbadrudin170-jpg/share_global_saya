# Aturan

1. Riverpod generator: setiap provider maupun notifier harus pakai `riverpod_generator`.
2. State:
   - `@Riverpod(keepAlive: true)` untuk state yang perlu dipertahankan.
   - `@riverpod` untuk state yang tidak perlu dipertahankan agar auto dispose.
3. `ref.watch`: hanya boleh digunakan di dalam `build`, notifier, dan provider saja.
   - Untuk `build`: tangani `.isLoading`, `.hasError`, dan `.requireValue` nya. Harus cek `.isLoading` dulu, baru `.hasError`, baru `.requireValue`.
   - Untuk notifier dan provider: harus pakai `ref.watch(provider.future)` jika sumber datanya async.
4. `ref.read`:
   - Jika notifier dan provider nya bersifat future, gunakan `.future`. Contoh: `final state = await ref.read(provider.future);`
   - Untuk menggunakan fungsi dari notifier, pakai `await` jika future. Contoh: `await ref.read(provider).hapus();`
5. `ref.listen`: gunakan hanya di dalam `build` saja dan lihat cara penggunaannya di source SDK.
6. `ref.listenManual`: gunakan hanya untuk di luar `build` saja dan baca cara penggunaannya di source SDK.
7. `ProviderScope`/`UncontrolledProviderScope`: jika proyek pakai riverpod, wajib tambahkan `ProviderScope`/`UncontrolledProviderScope` (untuk manual) di `main.dart`.
8. `ref.refresh`: gunakan `ref.refresh` untuk langsung mengevaluasi ulang data.
   - Build error: ketika UI sedang menampilkan error, panggil `ref.refresh`, jangan `invalidate`.
   - Aturan penggunaan: `final _ = ref.refresh(provider);`
9. Optimistic update di notifier wajib pola update state → DB → rollback pada Exception. Contoh: `state = AsyncValue.data(listBaru); try { await ref.read(baseOpSqfliteProvider).tambah(...); } on Exception catch (e, s) { state = AsyncValue.data(dataLama); rethrow; }`.
