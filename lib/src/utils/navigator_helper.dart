//lib/shared/utils/navigator_helper.dart

import 'package:flutter/material.dart';

/// Kelas helper untuk menyederhanakan navigasi.
///
/// 🚀 **Aturan pakai Nav helper:**
/// - ✅ WAJIB pakai `Nav.to()`, `Nav.toReplacement()`, `Nav.pop()`.
/// - ❌ DILARANG panggil `Navigator.push()`, `pushReplacement()`, `pop()` langsung.
/// - Semua navigasi lewat `Nav` biar konsisten dan gampang di-maintain.
/// - Terapkan di code review – jika ketahuan panggil `Navigator` langsung, tolak.
class Nav {
  Nav._();

  /// Mendorong halaman baru ke tumpukan navigator.
  static Future<T?> to<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => page), // ← tambahkan <T>
    );
  }

  /// Mengganti halaman saat ini dengan yang baru.
  static Future<T?> toReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute<T>(builder: (context) => page), // ← tambahkan <T>
    );
  }

  /// Kembali ke halaman sebelumnya.
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// Mendorong halaman baru dan menghapus seluruh route sebelumnya.
  ///
  /// Digunakan misalnya saat membuka halaman dari notifikasi agar tumpukan
  /// navigasi tidak menyisakan route awal di bawahnya.
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => page),
      predicate ?? (route) => false,
    );
  }
}
