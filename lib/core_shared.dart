/// Kode bersama yang bisa dipakai di banyak projek Flutter.
///
/// Cara pakai di projek:
/// ```dart
/// import 'package:share_global_saya/core_shared.dart';
/// ```
library;

// Log & debug
export 'package:share_global_saya/log_debug/log_debug_notifier.dart';
export 'package:share_global_saya/log_debug/log_debug_page.dart';
export 'package:share_global_saya/log_debug/overlay_log_debug.dart';
export 'package:share_global_saya/log_debug/print_custom.dart';

// Utils
export 'package:share_global_saya/src/utils/app_keys.dart';
export 'package:share_global_saya/src/utils/format_utils.dart';
export 'package:share_global_saya/src/utils/l.dart';
export 'package:share_global_saya/src/utils/navigator_helper.dart';
export 'package:share_global_saya/src/utils/parser_util.dart';
export 'package:share_global_saya/src/utils/shared_pref_service.dart';

// Widget input
export 'package:share_global_saya/src/widget/input/input_angka.dart';
export 'package:share_global_saya/src/widget/input/input_autocomplete.dart';
export 'package:share_global_saya/src/widget/input/input_dropdown.dart';
export 'package:share_global_saya/src/widget/input/input_password.dart';
export 'package:share_global_saya/src/widget/input/input_rupiah.dart';
export 'package:share_global_saya/src/widget/input/input_teks.dart';
export 'package:share_global_saya/src/widget/input/input_telepon.dart';
export 'package:share_global_saya/src/widget/input/rupiah_input_formatter.dart';
export 'package:share_global_saya/src/widget/input/thousands_input_formatter.dart';

// Widget lainnya
export 'package:share_global_saya/src/widget/confirmation_dialog.dart';
export 'package:share_global_saya/src/widget/pemilih_tanggal_waktu.dart';
export 'package:share_global_saya/src/widget/toast_widget.dart';
