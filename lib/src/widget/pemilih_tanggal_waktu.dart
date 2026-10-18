// Path: lib/shared/widget/pemilih_tanggal_waktu.dart

import 'package:flutter/material.dart';
import 'package:share_global_saya/src/utils/format_utils.dart';

class PemilihTanggalWaktuWidget extends StatelessWidget {
  final DateTime? tanggalTerpilih;
  final TimeOfDay? waktuTerpilih;
  final VoidCallback? onPilihTanggal;
  final VoidCallback? onPilihWaktu;
  final VoidCallback? onResetKeSekarang;
  final String teksLabel;

  const PemilihTanggalWaktuWidget({
    super.key,
    this.tanggalTerpilih,
    this.waktuTerpilih,
    this.onPilihTanggal,
    this.onPilihWaktu,
    this.onResetKeSekarang,
    this.teksLabel = 'Pilih Tanggal & Waktu',
  });

  @override
  Widget build(BuildContext context) {
    final sekarang = DateTime.now();
    bool sudahSekarang = false;
    if (waktuTerpilih != null && tanggalTerpilih != null) {
      sudahSekarang = DateUtils.isSameDay(tanggalTerpilih!, sekarang) &&
          waktuTerpilih!.hour == sekarang.hour &&
          waktuTerpilih!.minute == sekarang.minute;
    } else if (tanggalTerpilih != null) {
      sudahSekarang = DateUtils.isSameDay(tanggalTerpilih!, sekarang);
    }
    return Column(
      spacing: 8,
      children: [
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              teksLabel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (onResetKeSekarang != null && !sudahSekarang)
              TextButton.icon(
                onPressed: onResetKeSekarang,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Sekarang'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: onPilihTanggal,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                tanggalTerpilih == null
                    ? 'Pilih Tanggal'
                    : FormatTanggal.formatDasar(tanggalTerpilih!),
              ),
            ),
            if (onPilihWaktu != null)
              TextButton.icon(
                onPressed: onPilihWaktu,
                icon: const Icon(Icons.lock_clock),
                label: Text(
                  waktuTerpilih == null
                      ? 'Pilih Jam'
                      : '${waktuTerpilih!.hour.toString().padLeft(2, '0')}:'
                          '${waktuTerpilih!.minute.toString().padLeft(2, '0')}',
                ),
              ),
          ],
        ),
      ],
    );
  }
}
