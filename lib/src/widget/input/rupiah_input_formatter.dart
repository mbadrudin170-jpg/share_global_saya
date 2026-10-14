// Path: lib/shared/widget/input/rupiah_input_formatter.dart

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Custom Formatter for Rupiah - Mendukung Double
class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Ambil teks baru, biarkan hanya digit dan KOMA (pemisah desimal)
    final newText = newValue.text.replaceAll(RegExp(r'[^\d,]'), '');

    // Jika hanya ada koma tanpa angka, kembalikan "Rp 0,"
    if (newText == ',') {
      return const TextEditingValue(
        text: 'Rp 0,',
        selection: TextSelection.collapsed(offset: 5),
      );
    }

    // Pisahkan bagian integer dan desimal berdasarkan koma
    final parts = newText.split(',');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    // Parse bagian integer
    final number = int.tryParse(integerPart) ?? 0;

    // Format bagian integer dengan pemisah ribuan
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formattedInteger = formatter.format(number);

    // Gabungkan dengan bagian desimal jika ada
    var newString = formattedInteger;
    if (parts.length > 1) {
      newString = '$formattedInteger,$decimalPart';
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
