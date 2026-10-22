// lib/shared/log_debug/log_debug_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:share_global_saya/db/model/log_debug_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ModeTampilanDebug { logDebug, dummyData }

class LogDebugPage extends ConsumerStatefulWidget {
  const LogDebugPage({super.key});

  @override
  ConsumerState<LogDebugPage> createState() => _LogDebugPageState();
}

class _LogDebugPageState extends ConsumerState<LogDebugPage> {
  Map<String, Object?> _values = const {};
  bool _isLoading = true;
  String? _error;
  ModeTampilanDebug _modeTampilanDebug = ModeTampilanDebug.logDebug;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    await _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final preferences = SharedPreferencesAsync();
      final map = await preferences.getAll();
      final values = Map<String, Object?>.fromEntries(
        map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
      );

      if (!mounted) return;
      setState(() {
        _values = values;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  String _formatValue(Object? value) {
    if (value is List<String>) return '[${value.join(', ')}]';
    return value?.toString() ?? 'null';
  }

  Widget _buildLogDebugItem(LogDebugModel log) {
    DateTime? waktu;
    try {
      waktu = DateTime.parse(log.tanggal);
    } catch (_) {}

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              waktu == null ? '-' : FormatWaktuLengkap.formatSingkat(waktu),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: SelectableText(log.pesan)),
        ],
      ),
    );
  }

  Future<void> _copyAllLogs() async {
    // TODO : optimasi ekstrak duplikasi _copyAllLogs antara log_debug_page.dart dan overlay_log_debug.dart ke helper bersama
    final logs = ref.read(logDebugProvider).value?.listLogDebug ?? [];
    if (logs.isEmpty) return;

    final buffer = StringBuffer();
    for (final log in logs) {
      DateTime? waktu;
      try {
        waktu = DateTime.parse(log.tanggal);
      } catch (_) {}
      final formattedTime =
          waktu != null ? FormatWaktuLengkap.formatSingkat(waktu) : log.tanggal;
      buffer.writeln('[$formattedTime] ${log.pesan}');
    }

    final text = buffer.toString().trim();
    if (text.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: text));

    if (mounted) {
      AppToast.sukses(context, 'Log debug disalin ke clipboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final logState = ref.watch(logDebugProvider);
    final logs = logState.value?.listLogDebug ?? [];
    final isLoadingLogs = logState.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  _modeTampilanDebug == ModeTampilanDebug.logDebug
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
              onPressed: () {
                setState(() {
                  _modeTampilanDebug = ModeTampilanDebug.logDebug;
                });
              },
              // TODO : kapital ubah 'log debug' menjadi 'Log debug'
              child: const Text('log debug'),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  _modeTampilanDebug == ModeTampilanDebug.dummyData
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
              onPressed: () {
                setState(() {
                  _modeTampilanDebug = ModeTampilanDebug.dummyData;
                });
              },
              // TODO : kapital ubah 'dummy data' menjadi 'Dummy data'
              child: const Text('dummy data'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: isLoadingLogs
                ? null
                : () async {
                    await ref.read(logDebugProvider.notifier).hapusSemua();
                  },
            tooltip: 'Hapus semua log debug',
          ),
          IconButton(
            onPressed: _isLoading ? null : _loadData,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: isLoadingLogs ? null : _copyAllLogs,
            tooltip: 'Salin log debug',
          ),
        ],
      ),
      body: _modeTampilanDebug == ModeTampilanDebug.logDebug
          ? (_isLoading && isLoadingLogs
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? _ErrorView(message: _error!, onRetry: _loadData)
                  // TODO : bug pertimbangkan menghilangkan force-unwrap _error! karena sudah di-guard
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: logs.length + _values.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        if (index < logs.length) {
                          final log = logs[index];
                          return Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: _buildLogDebugItem(log),
                              ),
                            ),
                          );
                        }
                        final prefIndex = index - logs.length;
                        final entry = _values.entries.elementAt(prefIndex);
                        return Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(
                              entry.key,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SelectableText(_formatValue(entry.value)),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                final valueText = _formatValue(entry.value);
                                Clipboard.setData(
                                    ClipboardData(text: valueText));
                                AppToast.sukses(context,
                                    'Nilai "${entry.key}" disalin ke clipboard');
                              },
                            ),
                          ),
                        );
                      },
                    ))
          : const Center(child: Text('kosong')),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            const Text('Gagal membaca data.'),
            const SizedBox(height: 8),
            SelectableText(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Coba lagi')),
          ],
        ),
      ),
    );
  }
}
