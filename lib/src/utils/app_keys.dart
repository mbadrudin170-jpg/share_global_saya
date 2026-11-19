import 'package:material_ui/material_ui.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Kunci navigator root, dipakai untuk navigasi dari widget overlay global
// (misalnya ikon melayang room) yang berada di luar pohon halaman aktif.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
