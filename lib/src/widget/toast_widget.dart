import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_global_saya/core_shared.dart';

class AppToast {
  AppToast._();

  static void sukses(BuildContext context, String message) {
    L.s(message);
    FToast().init(context);
    FToast().showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void gagal(BuildContext context, String message) {
    L.e(message);
    FToast().init(context);
    FToast().showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void info(BuildContext context, String message) {
    L.i(message);
    FToast().init(context);
    FToast().showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void warning(BuildContext context, String message) {
    L.w(message);
    FToast().init(context);
    FToast().showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.orange.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
