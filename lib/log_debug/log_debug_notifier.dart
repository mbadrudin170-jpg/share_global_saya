// lib/shared/log_debug/log_debug_notifier.dart

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/db/model/log_debug_model.dart';
import 'package:share_global_saya/log_debug/print_custom.dart';

part 'log_debug_notifier.freezed.dart';
part 'log_debug_notifier.g.dart'

@freezed
abstract class LogDebugState with _$LogDebugState {
  const LogDebugState._();

  const factory LogDebugState({@Default([]) List<LogDebugModel> listLogDebug}) =
      _LogDebugState;

  List<LogDebugModel> getListError() {
    return listLogDebug.where((log) => log.tipeLog == TipeLog.error).toList();
  }

  List<LogDebugModel> getListWarning() {
    return listLogDebug.where((log) => log.tipeLog == TipeLog.warning).toList();
  }

  List<LogDebugModel> getListInfo() {
    return listLogDebug.where((log) => log.tipeLog == TipeLog.info).toList();
  }

  List<LogDebugModel> getListSukses() {
    return listLogDebug.where((log) => log.tipeLog == TipeLog.sukses).toList();
  }

  List<LogDebugModel> sortirTerbaru(List<LogDebugModel>? listLogDebugCustom) {
    final list = listLogDebugCustom ?? listLogDebug;
    return list.toList()..sort((a, b) => b.tanggal.compareTo(a.tanggal));
  }
}

@Riverpod(keepAlive: true)
class LogDebugNotifier extends _$LogDebugNotifier {
  Future<void> _queue = Future.value();

  @override
  Future<LogDebugState> build() async {
    if (kIsWeb) {
      return const LogDebugState();
    } else {
      return ambilData();
    }
  }

  Future<void> tambah(LogDebugModel logDebug) {
    p('=== tambah() MULAI ===');
    p('tambah: notifier.hashCode=$hashCode');
    p('tambah: logDebug = [${logDebug.tipeLog.name}] ${logDebug.pesan}');

    final next = _queue.then((_) async {
      p('tambah: [queue] masuk blok then');
      p('tambah: [queue] menunggu future build');
      final stateSekarang = await future;
      p(
        'tambah: [queue] stateSekarang.listLogDebug.length=${stateSekarang.listLogDebug.length}',
      );
      p('tambah: [queue] stateSekarang.listLogDebug (5 pertama):');
      for (final l in stateSekarang.listLogDebug.take(5)) {
        p('tambah: [queue]   - [${l.tipeLog.name}] ${l.pesan}');
      }

      final stateBaru = LogDebugState(
        listLogDebug: [...stateSekarang.listLogDebug, logDebug],
      );
      state = AsyncValue.data(stateBaru);
      p(
        'tambah: [queue] state di-update, listLogDebug.length=${stateBaru.listLogDebug.length}',
      );

      p(
        'tambah: [queue] memanggil ref.read(dbRepositoryProvider).tambahLogDebug()',
      );
      if (!kIsWeb) {
        await ref.read(dbRepositoryProvider).tambahLogDebug(logDebug);
      }
      p('tambah: [queue] DB insert selesai');
    });

    // ignore: discarded_futures
    p('tambah: next future=$next');
    _queue = next.catchError((Object e, StackTrace s) {
      p('tambah: [queue] ERROR: $e\n$s');
    });
    p('=== tambah() SELESAI ===');
    return next;
  }

  Future<void> hapusSemua() async {
    p('=== hapusSemua() MULAI ===');
    p('hapusSemua: notifier.hashCode=$hashCode');
    p('hapusSemua: state sebelum=${state.value?.listLogDebug.length} log');
    state = const AsyncValue.data(LogDebugState());
    p(
      'hapusSemua: state setelah di-set kosong, listLogDebug.length=${state.value?.listLogDebug.length}',
    );
    p('hapusSemua: memanggil DB hapusSemuaLogDebug()');
    if (kIsWeb) {
      return;
    }
    await ref.read(dbRepositoryProvider).hapusSemuaLogDebug();
    p('hapusSemua: DB hapus selesai');
    p('=== hapusSemua() SELESAI ===');
  }

  Future<LogDebugState> ambilData() async {
    p('=== LogDebugNotifier.build MULAI ===');
    p('build: notifier.hashCode=$hashCode');
    p('build: ref.hashCode=${ref.hashCode}');
    try {
      final logs = await ref.read(dbRepositoryProvider).ambilSemuaLogDebug();
      p('build: dapat ${logs.length} log dari DB');
      for (final l in logs.take(5)) {
        p('build: sample log = [${l.tipeLog.name}] ${l.pesan}');
      }
      final stateBaru = LogDebugState(listLogDebug: logs);
      p(
        'build: state dibuat, listLogDebug.length=${stateBaru.listLogDebug.length}',
      );
      p('=== LogDebugNotifier.build SELESAI ===');
      return stateBaru;
    } catch (e, s) {
      p('build: ERROR: $e\n$s');
      p('=== LogDebugNotifier.build GAGAL ===');
      rethrow;
    }
  }

  Future<void> tesTambah(LogDebugModel logDebug) async {
    final stateSekarang = await future;
    final stateBaru = LogDebugState(
      listLogDebug: [...stateSekarang.listLogDebug, logDebug],
    );
    state = AsyncValue.data(stateBaru);
  }
}
