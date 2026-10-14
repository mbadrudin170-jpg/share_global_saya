// lib/db/model/log_debug_model.dart

/// Enum yang merepresentasikan tipe log debug.
enum TipeLog {
  error,
  warning,
  info,
  sukses,
  api,
}

/// Model untuk menyimpan log debug.
///
/// Field [tanggal] disimpan sebagai string ISO 8601.
/// Field [tipeLog] menentukan kategori log (error, warning, info, sukses, api).
class LogDebugModel {
  final String id;
  final TipeLog tipeLog;
  final String pesan;
  final String tanggal;

  LogDebugModel({
    required this.id,
    required this.tipeLog,
    required this.pesan,
    required this.tanggal,
  });

  factory LogDebugModel.fromJson(Map<String, dynamic> json) {
    return LogDebugModel(
      id: json['id'] as String,
      tipeLog: TipeLog.values.firstWhere(
        (e) => e.name == json['tipe_log'] as String,
        orElse: () => TipeLog.info,
      ),
      pesan: json['pesan'] as String,
      tanggal: json['tanggal'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipe_log': tipeLog.name,
      'pesan': pesan,
      'tanggal': tanggal,
    };
  }

  LogDebugModel copyWith({
    String? id,
    TipeLog? tipeLog,
    String? pesan,
    String? tanggal,
  }) {
    return LogDebugModel(
      id: id ?? this.id,
      tipeLog: tipeLog ?? this.tipeLog,
      pesan: pesan ?? this.pesan,
      tanggal: tanggal ?? this.tanggal,
    );
  }

  @override
  String toString() {
    return 'LogDebugModel(id: $id, tipeLog: $tipeLog, pesan: $pesan, tanggal: $tanggal)';
  }
}
