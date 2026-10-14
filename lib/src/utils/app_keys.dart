// lib/shared/utils/app_keys.dart
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Kunci navigator root, dipakai untuk navigasi dari widget overlay global
// (misalnya ikon melayang room) yang berada di luar pohon halaman aktif.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
