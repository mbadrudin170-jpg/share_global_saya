// lib/shared/widget/snackbar_widget.dart

import 'package:core_shared/src/app_keys.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void sukses(String message) {
    _show(
      message,
      backgroundColor: Colors.green.shade700,
      icon: Icons.check_circle_outline,
      textColor: Colors.white,
    );
  }

  static void gagal(String message) {
    final context = AppKeys.scaffoldMessengerKey.currentState?.context;
    if (context == null) {
      return;
    }
    _show(
      message,
      backgroundColor: Theme.of(context).colorScheme.error,
      icon: Icons.highlight_off,
      textColor: Theme.of(context).colorScheme.onError,
      duration: const Duration(milliseconds: 3000),
    );
  }

  static void info(String message) {
    _show(
      message,
      backgroundColor: Colors.blue.shade700,
      icon: Icons.info_outline,
      textColor: Colors.white,
    );
  }

  static void warning(String message) {
    _show(
      message,
      backgroundColor: Colors.orange.shade700,
      icon: Icons.warning_amber_rounded,
      textColor: Colors.white,
    );
  }

  /// Metode privat internal untuk membangun dan menampilkan SnackBar.
  static void _show(
    String message, {
    required Color backgroundColor,
    required IconData icon,
    required Color textColor,
    Duration? duration,
  }) {
    final messengerState = AppKeys.scaffoldMessengerKey.currentState;
    if (messengerState == null) {
      return;
    }
    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 15, color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 50, left: 16, right: 16, top: 16),
        duration: duration ?? const Duration(milliseconds: 2000),
      ),
    );
  }
}
