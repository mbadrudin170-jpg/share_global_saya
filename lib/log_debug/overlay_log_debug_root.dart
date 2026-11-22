// path: lib/log_debug/overlay_log_debug_root.dart

import 'package:material_ui/material_ui.dart';

import 'package:share_global_saya/log_debug/overlay_log_debug.dart';

/// Pembungkus root aplikasi yang menyediakan `Localizations` + `Directionality`
/// + `Overlay` root manual + `PengelolaOverlayLogDebug`, sehingga ikon/panel
/// log debug dapat muncul di atas seluruh layar (lihat skill overlay-log-debug).
///
/// Gunakan sebagai anak `UncontrolledProviderScope` di `main()`:
/// ```dart
/// runApp(
///   UncontrolledProviderScope(
///     container: container,
///     child: PengelolaOverlayLogDebugRoot(child: AppMaterial()),
///   ),
/// );
/// ```
class PengelolaOverlayLogDebugRoot extends StatelessWidget {
  const PengelolaOverlayLogDebugRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en'),
      delegates: const [
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => PengelolaOverlayLogDebug(child: child),
            ),
          ],
        ),
      ),
    );
  }
}
