// path: lib/src/services/cek_koneksi_internet.dart
// File ini menyediakan layanan terpusat untuk memeriksa status koneksi internet.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:share_global_saya/src/utils/l.dart';

class KoneksiInternetService {
  // Fungsi untuk memeriksa apakah perangkat terhubung ke internet (WiFi atau Mobile).
  // Mengembalikan Future<bool> yang bernilai true jika online, dan false jika offline.
  // diubah: dihapus keyword static agar bisa di-mock untuk testing
  Future<bool> cekKoneksi() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      L.i('Hasil mentah konektivitas diterima: Data: $connectivityResult');

      // Memeriksa apakah hasil konektivitas mengandung koneksi seluler atau WiFi.
      final isOnline = connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi);

      return isOnline;
    } catch (e, s) {
      L.e('Terjadi kesalahan fatal saat memeriksa koneksi: $e $s');
      // Mengembalikan false sebagai fallback aman jika terjadi error pada plugin
      return false;
    }
  }
}
