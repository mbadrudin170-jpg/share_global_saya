aturan_riverpod.md

# Aturan

riverpod*generator : setiap provider maupun notifier harus pakai riverpod generator
state :
@Riverpod(keepAlive : true) untuk state yang perlu dipertahankan.
@riverpod : untuk state yang tidak perlu dipertahankan agar auto dispose.
ref.watch : hanya boleh di gunakan di dalam build, notifier dan provider saja
untuk build tangani `.isLoading`, `.hasError` dan `.requireValue` nya, harus cek .isLoading dulu baru .hasError baru .requireValue.
untuk notifier dan provider : harus pakai ref.watch(provider.future); jika sumber datanya async
ref.read : jika notifier dan provider nya bersifat future menggunakan .`future` contoh : `final state = await ref.read(provider.future);`
untuk menggunakan fungsi dari notifier harus pakai await jika future contoh await ref.read(provider).hapus();
ref.listen : gunakan hanya di dalam build saja dan lihat cara penggunaanya di di source sdk.
ref.listenManual : gunakan hanya untuk di luar build saja dan baca cara penggunaanya di source sdk.
ProviderScope/UncontrolledProviderScope : jika projek pakai riverpod wajib tambahkan providerscrop/UncontrolledProviderScope(untuk manual) di main.dart
ref.refresh : gunakan ref.refresh untuk langsung mengevaluasi ulang data
builderror : ketika ui sedang menampilkan error panggil ref.refresh jangan invalidate.
aturan penggunaan : final * = ref.refresh(provider);
Optimistic update di notifier wajib pola update state → DB → rollback pada Exception, `Contoh: state = AsyncValue.data(listBaru); try { await ref.read(baseOpSqfliteProvider).tambah(...); } on Exception catch (e, s) { state = AsyncValue.data(dataLama); rethrow; }`.
