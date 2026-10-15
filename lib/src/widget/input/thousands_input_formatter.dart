// path: lib/widget/thousands_input_formatter.dart
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formatter untuk [TextField] agar angka ditampilkan dengan pemisah
/// ribuan secara otomatis, serta mendukung input angka negatif.
class ThousandsAndNegativeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Teks kosong → biarkan kosong.
    if (newValue.text.trim().isEmpty) {
      return newValue.copyWith(text: '');
    }

    // User baru mengetik '-' → izinkan, tunggu digit berikutnya.
    if (newValue.text == '-') {
      return newValue;
    }

    // Deteksi tanda negatif di awal teks.
    final isNegative = newValue.text.startsWith('-');

    // Ambil hanya digit dari teks (buang semua karakter lain).
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Tidak ada digit sama sekali.
    if (digitsOnly.isEmpty) {
      // Kalau teks dimulai dengan '-', pertahankan tanda minusnya.
      if (isNegative) {
        return const TextEditingValue(
          text: '-',
          selection: TextSelection.collapsed(offset: 1),
        );
      }
      // Selain itu, input tidak valid → kembalikan nilai lama.
      return oldValue;
    }

    // Konversi string digit menjadi angka.
    final number = int.tryParse(digitsOnly);
    // Parsing gagal → kembalikan nilai lama sebagai fallback yang aman.
    if (number == null) {
      return oldValue;
    }

    // Format angka dengan pemisah ribuan gaya Indonesia.
    final formatter = NumberFormat('#,###', 'id_ID');
    final formattedNumber = formatter.format(number);

    // Gabungkan kembali tanda negatif kalau ada.
    final newText = isNegative ? '-$formattedNumber' : formattedNumber;

    // Kembalikan teks yang sudah diformat, kursor di akhir.
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
