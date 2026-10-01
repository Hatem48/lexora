import 'dart:convert';

/// Portable backup format. Increment [schemaVersion] when fields change.
class LexoraBackup {
  const LexoraBackup({
    required this.schemaVersion,
    required this.exportedAt,
    required this.payload,
  });

  final int schemaVersion;
  final DateTime exportedAt;
  final Map<String, dynamic> payload;

  static const currentSchemaVersion = 3;

  Map<String, dynamic> toJson() => {
        'schemaVersion': schemaVersion,
        'exportedAt': exportedAt.toIso8601String(),
        'payload': payload,
      };

  factory LexoraBackup.fromJson(Map<String, dynamic> json) {
    return LexoraBackup(
      schemaVersion: json['schemaVersion'] as int? ?? 1,
      exportedAt: DateTime.tryParse(json['exportedAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      payload: Map<String, dynamic>.from(json['payload'] as Map? ?? {}),
    );
  }

  String encode() => const JsonEncoder.withIndent('  ').convert(toJson());

  static LexoraBackup decode(String raw) {
    return LexoraBackup.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }
}
