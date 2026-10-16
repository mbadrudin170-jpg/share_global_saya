// lib/shared/utils/l.dart
// ============================================================
// 🚀 FILE INI ADALAH PENGGANTI `log.dart` + `print_util.dart`
//    Cukup panggil `L.i()`, `L.s()`, `L.e()`, dll.
// ============================================================

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:uuid/uuid.dart';
import 'package:share_global_saya/db/model/log_debug_model.dart';
import 'package:share_global_saya/log_debug/log_debug_notifier.dart';

/// ============================================================
/// KELAS L - SINGLE ENTRY POINT UNTUK LOGGING
/// ============================================================
class L {
  static bool showLocation = true;
  static bool useTerse = true;
  static final bool _aktifkanLog = true;

  static final Uuid _uuid = const Uuid();

  /// ProviderContainer untuk kirim log ke LogDebugNotifier (overlay debug)
  static ProviderContainer? _container;

  // -------------------- INISIALISASI --------------------
  static void init(ProviderContainer container) {
    _container = container;
  }

  /// Matikan output console dari Logger agar tidak double print.
  static void disableConsole() {}

  // -------------------- METHOD PUBLIC --------------------
  static void i(String message) {
    _print('ℹ️ $message', TipeLog.info);
  }

  static void s(String message) {
    _print('✅ $message', TipeLog.sukses);
  }

  static void w(String message) {
    _print('⚠️ $message', TipeLog.warning);
  }

  static void e(String message) {
    _print('❌ $message', TipeLog.error);
  }

  static void json(Map<String, dynamic> data) {
    _print('📦 $data', TipeLog.info);
  }

  static void list(List<dynamic> items, {String label = '📋'}) {
    _print('$label $items', TipeLog.info);
  }

  static void api(
    String path,
    Map<String, dynamic> data, {
    required String method,
  }) {
    final id = _uuid.v4();
    final message = '[$method][$id] $path Data: $data';
    _print('🌐 $message', TipeLog.api);
  }

  // -------------------- METHOD INTERNAL (PRINT) --------------------
  static void _print(String message, TipeLog tipeLog) {
    if (!_aktifkanLog) return;
    var location = '';
    if (showLocation) {
      final fromStack = _getLocationFromStackTrace();
      if (fromStack != null) {
        location = ' [$fromStack]';
      } else {
        final manual = _getCallerInfoManual();
        if (manual != null) {
          location = ' [$manual]';
        }
      }
    }
    final output = '$message$location';
    if (kDebugMode) {
      debugPrint(output);
    }

    // Kirim ke LogDebugNotifier untuk overlay debug log
    _kirimKeOverlayDebug(message, tipeLog);
  }

  static void _kirimKeOverlayDebug(String message, TipeLog tipeLog) {
    if (_container == null) return;
    try {
      _container!.read(logDebugProvider.notifier).tambah(
            LogDebugModel(
              id: _uuid.v4(),
              tipeLog: tipeLog,
              pesan: message,
              tanggal: DateTime.now().toIso8601String(),
            ),
          );
    } catch (_) {
      // Abaikan error (misal provider belum siap)
    }
  }

  static String? _getLocationFromStackTrace() {
    try {
      final trace = Trace.current();
      final frames = useTerse ? trace.terse.frames : trace.frames;
      final skipPatterns = [
        'l.dart',
        '.g.dart',
        '.freezed.dart',
        'riverpod',
        'logger',
        'async_patch.dart',
        'dart-sdk',
        'package:flutter',
      ];
      Frame? caller;
      for (final frame in frames) {
        final uri = frame.uri.toString();
        if (skipPatterns.any(uri.contains)) {
          continue;
        }
        if (frame.uri.pathSegments.any((seg) => seg.contains('l.dart'))) {
          continue;
        }
        caller = frame;
        break;
      }
      caller ??= frames.isNotEmpty ? frames.first : null;
      if (caller != null) {
        final file = caller.uri.pathSegments.last;
        final line = caller.line;
        if (file.contains('.js')) {
          return null;
        }
        return '$file:${line ?? '?'}';
      }
    } catch (_) {}
    return null;
  }

  static String? _getCallerInfoManual() {
    final stack = StackTrace.current.toString();
    final skipPatterns = [
      'l.dart',
      '.g.dart',
      '.freezed.dart',
      'riverpod',
      'async_patch.dart',
      'dart-sdk',
      'package:flutter',
      'dart:async',
      'dart:isolate',
    ];
    for (final line in stack.split('\n')) {
      if (line.contains('.dart') && !line.contains('l.dart')) {
        if (skipPatterns.any(line.contains)) {
          continue;
        }
        final match = RegExp(r'([^/]+\.dart):(\d+)').firstMatch(line);
        if (match != null) {
          return '${match.group(1)}:${match.group(2)}';
        }
      }
    }
    return null;
  }
}
