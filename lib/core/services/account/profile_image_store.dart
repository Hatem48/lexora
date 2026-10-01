import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Profile photos live under the app documents directory.
/// The account stores a relative path so an iOS container change
/// after an update still resolves the same file.
class ProfileImageStore {
  static const folderName = 'user_images';

  /// Test hook. Production leaves this null and uses the documents directory.
  static Directory? documentsDirectoryOverride;

  static Future<Directory> folder() async {
    final root = documentsDirectoryOverride ??
        await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(root.path, folderName));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  static String relativeFor(String fileName) => '$folderName/$fileName';

  static Future<String> saveBytes(List<int> bytes) async {
    final dir = await folder();
    final name = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File(p.join(dir.path, name));
    await file.writeAsBytes(bytes, flush: true);
    return relativeFor(name);
  }

  static Future<void> deleteStored(String? stored) async {
    final file = await resolve(stored);
    if (file != null && file.existsSync()) {
      await file.delete();
    }
  }

  /// Copies an old absolute path into [folderName] when the file is still
  /// there. Returns an empty string when the old file is already gone.
  static Future<String> migrate(String? stored) async {
    if (stored == null || stored.isEmpty) return '';
    if (!p.isAbsolute(stored)) return stored;
    final old = File(stored);
    if (!old.existsSync()) return '';
    final relative = await saveBytes(await old.readAsBytes());
    return relative;
  }

  static Future<File?> resolve(String? stored) async {
    if (stored == null || stored.isEmpty) return null;
    if (p.isAbsolute(stored)) {
      final file = File(stored);
      return file.existsSync() ? file : null;
    }
    final root = documentsDirectoryOverride ??
        await getApplicationDocumentsDirectory();
    final file = File(p.join(root.path, stored));
    return file.existsSync() ? file : null;
  }
}
