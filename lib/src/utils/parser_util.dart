// lib/shared/utils/parser_util.dart

import 'package:collection/collection.dart';
import 'package:share_global_saya/src/utils/l.dart';

class ParserUtil {
  // Mencegah class ini diinstansiasi.
  ParserUtil._();

  static DateTime? parseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return value;
    }
    if (value is int) {
      // Heuristik sederhana: jika timestamp < 1.000.000.000.000,
      // kemungkinan besar dalam detik, bukan milidetik.
      // Angka ini setara dengan tanggal pada tahun 2001.
      return value < 1000000000000
          ? DateTime.fromMillisecondsSinceEpoch(
              value * 1000,
            ) // Konversi detik ke milidetik
          : DateTime.fromMillisecondsSinceEpoch(
              value,
            ); // Anggap sudah milidetik
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }

    // Jika format tidak dikenali, catat sebagai peringatan.
    L.w('Format DateTime tidak dikenali: $value');
    return null;
  }

  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) {
      return defaultValue;
    }
    if (value is bool) {
      return value;
    }
    if (value is int) {
      return value == 1;
    }
    if (value is String) {
      final lowered = value.toLowerCase();
      return lowered == 'true' || lowered == '1';
    }
    L.w('Format bool tidak dikenali: $value, dianggap $defaultValue.');
    return defaultValue;
  }

  static int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) {
      return defaultValue;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    L.w('Format integer tidak dikenali: $value, dianggap $defaultValue.');
    return defaultValue;
  }

  static double parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) {
      return defaultValue;
    }
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    L.w('Format angka tidak dikenali: $value, dianggap $defaultValue.');
    return defaultValue;
  }

  /// Mengurai string menjadi nilai enum secara case-insensitive.
  /// Mengembalikan `null` jika tidak ada nilai yang cocok.
  static T? safeParseEnum<T extends Enum>(List<T> values, String? value) {
    if (value == null) {
      return null;
    }
    final result = values.firstWhereOrNull(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
    );
    if (result == null) {
      L.w('Gagal mengurai enum untuk tipe $T\nData: $value');
    }
    return result;
  }

  static int? parseIntOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    L.w('Format integer tidak dikenali untuk nullable: $value');
    return null;
  }

  /// Mengurai double, mengembalikan null jika nilai tidak valid atau null.
  static double? parseDoubleOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    L.w('Format angka tidak dikenali untuk nullable: $value');
    return null;
  }

  /// Mengurai nilai menjadi String.
  ///
  /// Mengembalikan [defaultValue] jika nilai null atau tidak dapat diurai
  /// menjadi String.
  static String parseString(dynamic value, {String defaultValue = ''}) {
    if (value == null) {
      return defaultValue;
    }
    if (value is String) {
      return value;
    }
    return value.toString();
  }

  /// Mengurai nilai menjadi String nullable.
  ///
  /// Mengembalikan `null` jika nilai null.
  static String? parseStringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is String) {
      return value;
    }
    return value.toString();
  }
}
