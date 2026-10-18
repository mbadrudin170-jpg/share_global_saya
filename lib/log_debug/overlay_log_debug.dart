// lib/shared/log_debug/overlay_log_debug.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:share_global_saya/db/model/log_debug_model.dart';

// ============================================================================
// Provider tampil / sembunyi ikon
// ============================================================================

class OverlayLogDebugTampilNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void tampilkan() => state = true;
  void sembunyikan() => state = false;
}

final overlayLogDebugTampilProvider =
    NotifierProvider<OverlayLogDebugTampilNotifier, bool>(
  OverlayLogDebugTampilNotifier.new,
);

// ============================================================================
// Pengelola overlay (ikon + panel log)
// ============================================================================

class PengelolaOverlayLogDebug extends ConsumerStatefulWidget {
  final Widget child;

  const PengelolaOverlayLogDebug({super.key, required this.child});

  @override
  ConsumerState<PengelolaOverlayLogDebug> createState() =>
      _PengelolaOverlayLogDebugState();
}

class _PengelolaOverlayLogDebugState
    extends ConsumerState<PengelolaOverlayLogDebug> {
  OverlayEntry? _entryIkon;
  OverlayEntry? _entryLog;
  bool? _terakhirTampilIkon;

  void _tampilkanIkon() {
    p('_tampilkanIkon: menampilkan ikon overlay log debug');
    _sembunyikanIkon();
    final overlay = Overlay.maybeOf(context);
    p('_tampilkanIkon: overlay null? ${overlay == null}');
    if (overlay == null) return;
    final entry = OverlayEntry(
      builder: (_) {
        p('_tampilkanIkon: builder _IkonMelayangLogDebug dipanggil');
        return _IkonMelayangLogDebug(onTap: _tampilkanLog);
      },
    );
    _entryIkon = entry;
    overlay.insert(entry);
    p('_tampilkanIkon: ikon di-insert ke overlay');
  }

  void _sembunyikanIkon() {
    p('_sembunyikanIkon: menyembunyikan ikon overlay log debug');
    _entryIkon?.remove();
    _entryIkon = null;
  }

  void _tampilkanLog() {
    p('_tampilkanLog: menampilkan panel log debug');
    _sembunyikanLog();
    final overlay = Overlay.maybeOf(context);
    p('_tampilkanLog: overlay null? ${overlay == null}');
    if (overlay == null) return;

    // Cek container yang dipakai consumer ini
    final container = ProviderScope.containerOf(context);
    p('_tampilkanLog: container.hashCode=${container.hashCode}');

    final entry = OverlayEntry(
      builder: (_) {
        p('_tampilkanLog: builder OverlayLogDebug dipanggil');
        return OverlayLogDebug(onClose: _sembunyikanLog);
      },
    );
    _entryLog = entry;
    overlay.insert(entry);
    p('_tampilkanLog: panel log di-insert ke overlay');
  }

  void _sembunyikanLog() {
    p('_sembunyikanLog: menyembunyikan panel log debug');
    _entryLog?.remove();
    _entryLog = null;
  }

  @override
  void dispose() {
    p('_PengelolaOverlayLogDebugState.dispose: membersihkan overlay');
    _sembunyikanIkon();
    _sembunyikanLog();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tampilIkon = ref.watch<bool>(overlayLogDebugTampilProvider);
    p(
      '_PengelolaOverlayLogDebugState.build: tampilIkon=$tampilIkon, terakhir=$_terakhirTampilIkon',
    );
    if (_terakhirTampilIkon != tampilIkon) {
      _terakhirTampilIkon = tampilIkon;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (tampilIkon) {
          _tampilkanIkon();
        } else {
          _sembunyikanIkon();
          _sembunyikanLog();
        }
      });
    }
    return widget.child;
  }
}

// ============================================================================
// Ikon melayang
// ============================================================================

class _IkonMelayangLogDebug extends ConsumerStatefulWidget {
  final VoidCallback? onTap;

  const _IkonMelayangLogDebug({this.onTap});

  @override
  ConsumerState<_IkonMelayangLogDebug> createState() =>
      _IkonMelayangLogDebugState();
}

class _IkonMelayangLogDebugState extends ConsumerState<_IkonMelayangLogDebug>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotasiController;
  Offset _posisi = Offset.zero;
  bool _sedangDigeser = false;
  final double _ukuran = 56;

  @override
  void initState() {
    super.initState();
    p('_IkonMelayangLogDebugState.initState: inisialisasi ikon melayang');
    _rotasiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ukuranLayar = MediaQuery.of(context).size;
      setState(() {
        _posisi = Offset(
          ukuranLayar.width - _ukuran - 16.0,
          ukuranLayar.height - _ukuran - 90.0,
        );
      });
      p('_IkonMelayangLogDebugState: posisi awal diset ke $_posisi');
    });
  }

  @override
  void dispose() {
    p('_IkonMelayangLogDebugState.dispose: membuang controller rotasi');
    _rotasiController.dispose();
    super.dispose();
  }

  void _batasiPosisiDiLayar(Offset delta) {
    final ukuranLayar = MediaQuery.of(context).size;
    final x = (_posisi.dx + delta.dx).clamp(0.0, ukuranLayar.width - _ukuran);
    final y = (_posisi.dy + delta.dy).clamp(0.0, ukuranLayar.height - _ukuran);
    _posisi = Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ukuranLayar = MediaQuery.of(context).size;
    final posisiAman = _posisi == Offset.zero
        ? Offset(
            ukuranLayar.width - _ukuran - 16.0,
            ukuranLayar.height - _ukuran - 90.0,
          )
        : _posisi;
    return Positioned(
      left: posisiAman.dx,
      top: posisiAman.dy,
      child: GestureDetector(
        onPanStart: (_) {
          setState(() => _sedangDigeser = true);
        },
        onPanUpdate: (details) {
          setState(() {
            _batasiPosisiDiLayar(details.delta);
          });
        },
        onPanEnd: (_) {
          setState(() => _sedangDigeser = false);
        },
        onTap: () {
          p('_IkonMelayangLogDebug: onTap dipanggil');
          widget.onTap?.call();
        },
        child: AnimatedScale(
          scale: _sedangDigeser ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: RotationTransition(
            turns: _rotasiController,
            child: Container(
              width: _ukuran,
              height: _ukuran,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorScheme.primary, colorScheme.secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                width: _ukuran,
                height: _ukuran,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.bug_report,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Panel log
// ============================================================================

enum ModeTampilanLog { semua, error, info, warning }

extension _ModeTampilanLogX on ModeTampilanLog {
  TipeLog get tipe {
    switch (this) {
      case ModeTampilanLog.error:
        return TipeLog.error;
      case ModeTampilanLog.info:
        return TipeLog.info;
      case ModeTampilanLog.warning:
        return TipeLog.warning;
      case ModeTampilanLog.semua:
        // Mode 'semua' tidak memfilter berdasarkan tipe,
        // filter khusus ditangani di _filterByMode.
        return TipeLog.info;
    }
  }
}

class OverlayLogDebug extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const OverlayLogDebug({super.key, required this.onClose});

  @override
  ConsumerState<OverlayLogDebug> createState() => _OverlayLogDebugState();
}

class _OverlayLogDebugState extends ConsumerState<OverlayLogDebug> {
  final ScrollController _scrollController = ScrollController();
  ModeTampilanLog _modeTampilanLog = ModeTampilanLog.semua;
  bool _terlihatSemua = false;
  @override
  void initState() {
    super.initState();
    p('_OverlayLogDebugState.initState: panel log diinisialisasi');
  }

  @override
  void dispose() {
    p('_OverlayLogDebugState.dispose: membersihkan controller scroll');
    _scrollController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Copy helpers
  // --------------------------------------------------------------------------

  Future<void> _copyAllLogs(List<LogDebugModel> logs) async {
    p('_copyAllLogs: menyalin ${logs.length} log ke clipboard');
    if (logs.isEmpty) return;
    final buffer = StringBuffer();
    for (final log in logs) {
      DateTime? waktu;
      try {
        waktu = DateTime.parse(log.tanggal);
      } catch (_) {}
      final formattedTime =
          waktu != null ? FormatWaktuLengkap.formatSingkat(waktu) : log.tanggal;
      buffer.writeln('[$formattedTime] [${log.tipeLog.name}] ${log.pesan}');
    }
    final text = buffer.toString().trim();
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    await ref.read(logDebugProvider.notifier).hapusSemua();
    if (mounted) {
      AppToast.sukses(context, 'Log debug disalin ke clipboard');
    }
    widget.onClose();
  }

  /// Bottom sheet disalin dibuat sebagai `OverlayEntry` yang di-insert
  /// SETELAH `_entryLog` di root overlay. Dengan begini dia muncul di
  /// atas Material milik [OverlayLogDebug], bukan di bawahnya.
  void _showModelSalin() {
    p('_showModelSalin: menampilkan bottom sheet pilihan tipe log');
    final logState = ref.read(logDebugProvider).value;
    final semuaList = logState?.listLogDebug ?? [];
    p('_showModelSalin: semuaList.length=${semuaList.length}');

    final overlay = Overlay.of(context, rootOverlay: true);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _SheetSalinLog(
        tipeAktif: _modeTampilanLog.tipe,
        onPilih: (tipe) {
          p('_showModelSalin.onPilih: tipe=$tipe');
          entry.remove();
          final filtered =
              semuaList.where((log) => log.tipeLog == tipe).toList();
          p('_showModelSalin.onPilih: filtered.length=${filtered.length}');
          unawaited(_copyAllLogs(filtered));
        },
        onClose: () {
          p('_showModelSalin.onClose: menutup sheet');
          entry.remove();
        },
      ),
    );
    overlay.insert(entry);
  }

  // --------------------------------------------------------------------------
  // Build
  // --------------------------------------------------------------------------

  List<LogDebugModel> _filterByMode(List<LogDebugModel> semuaList) {
    if (_modeTampilanLog == ModeTampilanLog.semua) {
      return semuaList;
    }
    final tipe = _modeTampilanLog.tipe;
    final hasil = semuaList.where((log) => log.tipeLog == tipe).toList();
    p(
      '_filterByMode: mode=$_modeTampilanLog, tipe=$tipe, input=${semuaList.length}, hasil=${hasil.length}',
    );
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    // Cek provider instance & status
    final logAsync = ref.watch(logDebugProvider);
    final logState = logAsync.value;
    final semuaList = logState?.listLogDebug ?? [];

    p('=== OverlayLogDebug.build MULAI ===');
    p('logAsync.isLoading=${logAsync.isLoading}');
    p('logAsync.hasError=${logAsync.hasError}');
    p('logAsync.hasValue=${logAsync.hasValue}');
    if (logAsync.hasError) {
      p('logAsync.error=${logAsync.error}');
      p('logAsync.stackTrace=${logAsync.stackTrace}');
    }
    p('logState null? ${logState == null}');
    p('semuaList.length=${semuaList.length}');

    final totalError = logState?.getListError().length ?? 0;
    final totalInfo = logState?.getListInfo().length ?? 0;
    final totalWarning = logState?.getListWarning().length ?? 0;
    p(
      'totalError=$totalError, totalInfo=$totalInfo, totalWarning=$totalWarning',
    );

    final logsTampil = _filterByMode(semuaList);
    p(
      '_modeTampilanLog=$_modeTampilanLog, logsTampil.length=${logsTampil.length}',
    );
    p('=== OverlayLogDebug.build SELESAI ===');

    return Material(
      color: Colors.black.withValues(alpha: 0.85),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _showModelSalin,
                    icon: const Icon(
                      Icons.copy_all_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      p(
                        'Tombol Salin: diklik, semuaList.length=${semuaList.length}',
                      );
                      unawaited(_copyAllLogs(semuaList));
                    },
                    icon: const Icon(Icons.copy, color: Colors.white, size: 18),
                    label: const Text(
                      'Salin',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      p('Tombol Hapus: diklik, memanggil hapusSemua()');
                      await ref.read(logDebugProvider.notifier).hapusSemua();
                      p('Tombol Hapus: hapusSemua() selesai');
                      widget.onClose();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'Hapus',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      p('Tombol Close: diklik');
                      widget.onClose();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildInformasiCustom(
                  ModeTampilanLog.semua,
                  'semua',
                  semuaList.length.toString(),
                ),
                _buildInformasiCustom(
                  ModeTampilanLog.error,
                  'error',
                  totalError.toString(),
                ),
                _buildInformasiCustom(
                  ModeTampilanLog.warning,
                  'warning',
                  totalWarning.toString(),
                ),
                _buildInformasiCustom(
                  ModeTampilanLog.info,
                  'info',
                  totalInfo.toString(),
                ),
              ],
            ),
            Expanded(
              child: logsTampil.isEmpty
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onClose,
                      child: const Center(
                        child: Text(
                          'Tidak ada log debug.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: logsTampil.length,
                      itemBuilder: (context, index) {
                        final log = logsTampil[index];
                        DateTime? waktu;
                        try {
                          waktu = DateTime.parse(log.tanggal);
                        } catch (_) {}
                        final formattedTime = waktu != null
                            ? FormatWaktuLengkap.formatSingkat(waktu)
                            : log.tanggal;

                        final badgeColor = switch (log.tipeLog) {
                          TipeLog.error => Colors.red,
                          TipeLog.warning => Colors.orange,
                          TipeLog.info => Colors.blue,
                          TipeLog.sukses => Colors.green,
                          TipeLog.api => Colors.purple,
                        };

                        return GestureDetector(
                          onTap: () => setState(() {
                            _terlihatSemua = !_terlihatSemua;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade300,
                                      fontFeatures: const [
                                        FontFeature.tabularFigures(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    log.tipeLog.name,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: badgeColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ItemLogDebug(
                                    log: log,
                                    terlihatSemua: _terlihatSemua,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformasiCustom(
    ModeTampilanLog tipeLog,
    String title,
    String value,
  ) {
    p('_buildInformasiCustom: tipe=$tipeLog, title=$title, value=$value');
    return GestureDetector(
      onTap: () {
        p('_buildInformasiCustom.onTap: pindah mode ke $tipeLog');
        setState(() {
          _modeTampilanLog = tipeLog;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color:
                    _modeTampilanLog == tipeLog ? Colors.green : Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                color:
                    _modeTampilanLog == tipeLog ? Colors.green : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemLogDebug extends StatefulWidget {
  final LogDebugModel log;
  final bool terlihatSemua;

  const _ItemLogDebug({required this.log, required this.terlihatSemua});

  @override
  State<_ItemLogDebug> createState() => _ItemLogDebugState();
}

class _ItemLogDebugState extends State<_ItemLogDebug> {
  late bool _terlihatSemua;
  @override
  void initState() {
    _terlihatSemua = widget.terlihatSemua;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: dispose resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _terlihatSemua = !_terlihatSemua;
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: SelectionArea(
          child: Text(
            widget.log.pesan,
            maxLines: _terlihatSemua ? null : 1,
            overflow:
                _terlihatSemua ? TextOverflow.clip : TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Sheet "Salin log" (pengganti showModalBottomSheet)
// ============================================================================

class _SheetSalinLog extends StatelessWidget {
  final TipeLog tipeAktif;
  final void Function(TipeLog tipe) onPilih;
  final VoidCallback onClose;

  const _SheetSalinLog({
    required this.tipeAktif,
    required this.onPilih,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    p('_SheetSalinLog.build: tipeAktif=$tipeAktif');
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Area gelap di belakang → tap untuk menutup
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onClose,
              child: Container(color: Colors.black54),
            ),
          ),
          // Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: colorScheme.surface,
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _item(context, TipeLog.error, 'Salin error'),
                    _item(context, TipeLog.info, 'Salin info'),
                    _item(context, TipeLog.warning, 'Salin warning'),
                    _item(context, TipeLog.sukses, 'Salin sukses'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, TipeLog tipe, String label) {
    final aktif = tipe == tipeAktif;
    p('_SheetSalinLog._item: tipe=$tipe, label=$label, aktif=$aktif');
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: () {
        p('_SheetSalinLog._item.onPressed: tipe=$tipe dipilih');
        onPilih(tipe);
      },
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: aktif ? colorScheme.primary : null,
        foregroundColor: aktif ? colorScheme.onPrimary : null,
      ),
      child: Text(label),
    );
  }
}
