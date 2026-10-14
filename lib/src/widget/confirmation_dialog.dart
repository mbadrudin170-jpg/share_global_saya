//~/warkop/lib/shared/widget/confirmation_dialog.dart

import 'package:core_shared/src/utils/navigator_helper.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<bool?> show({
    required BuildContext context,
    String title = 'Konfirmasi',
    String message = 'Apakah Anda yakin?',
    String confirmText = 'Ya',
    String cancelText = 'Batal',
    Color? confirmColor,
    Color? cancelColor,
    bool barrierDismissible = true,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _ConfirmationDialogContent(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        isDestructive: isDestructive,
      ),
    );
  }

  static Future<bool?> showDelete({
    required BuildContext context,
    required String itemName,
    String title = 'Hapus Data',
    String message = 'Apakah Anda yakin ingin menghapus data ini?',
    String confirmText = 'Hapus',
    String cancelText = 'Batal',
  }) {
    return show(
      context: context,
      title: title,
      message: '$message\n\n"$itemName"',
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: true,
    );
  }

  /// Menampilkan dialog konfirmasi untuk menghapus semua data.
  ///
  /// [itemName] opsional: nama item yang akan dihapus (misal 'transaksi', 'pelanggan').
  /// [itemCount] opsional: jumlah item yang akan dihapus.
  static Future<bool?> showDeleteAll({
    required BuildContext context,
    String? itemName,
    int? itemCount,
    String? message,
    String title = 'Hapus Semua Data',
    String confirmText = 'Hapus Semua',
    String cancelText = 'Batal',
  }) {
    String finalMessage;
    if (message != null) {
      finalMessage = message;
    } else {
      if (itemCount != null && itemName != null) {
        finalMessage =
            'Yakin ingin menghapus semua $itemName ($itemCount item)?';
      } else if (itemName != null) {
        finalMessage = 'Yakin ingin menghapus semua $itemName?';
      } else {
        finalMessage = 'Yakin ingin menghapus semua data?';
      }
      finalMessage += '\n\nTindakan ini tidak dapat dibatalkan!';
    }

    return show(
      context: context,
      title: title,
      message: finalMessage,
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: true,
      confirmColor: Colors.red.shade700,
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    String title = 'Informasi',
    String message = '',
    String buttonText = 'OK',
    Color? buttonColor,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Nav.pop(context),
            child: Text(
              buttonText,
              style: TextStyle(
                color: buttonColor ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmationDialogContent extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color? confirmColor;
  final Color? cancelColor;
  final bool isDestructive;

  const _ConfirmationDialogContent({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.confirmColor,
    this.cancelColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          if (isDestructive)
            Icon(
              Icons.warning_amber_rounded,
              color: colorScheme.error,
              size: 28,
            ),
          if (isDestructive) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Text(message, style: theme.textTheme.bodyMedium),
      actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Nav.pop(context, false),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cancelColor ?? colorScheme.onSurface,
                  side: BorderSide(
                    color:
                        cancelColor ??
                        colorScheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(cancelText),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Nav.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      confirmColor ??
                      (isDestructive ? colorScheme.error : colorScheme.primary),
                  foregroundColor: confirmColor != null
                      ? colorScheme.onPrimary
                      : (isDestructive
                            ? colorScheme.onError
                            : colorScheme.onPrimary),
                ),
                child: Text(confirmText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
