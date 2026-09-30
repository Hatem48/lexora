import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/database/demo_data_cleanup.dart';
import 'core/providers/settings_provider.dart';
import 'core/providers/startup_provider.dart';
import 'core/services/notifications/reminder_scheduler.dart';
import 'core/services/topics/topic_catalog_importer.dart';
import 'core/services/vocabulary/vocabulary_catalog_importer.dart';

const _splashLimit = Duration(seconds: 5);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final container = ProviderContainer();
  final startup = _startLexora(container);

  try {
    await startup.timeout(_splashLimit);
  } on TimeoutException {
    // The native splash stays up until the first frame. Open the app
    // and let catalog import finish behind it.
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const LexoraApp(),
    ),
  );
}

Future<void> _startLexora(ProviderContainer container) async {
  try {
    await ReminderScheduler.instance.initialize();

    final db = container.read(appDatabaseProvider);
    // SharedPreferences loads just after the settings notifier starts.
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await DemoDataCleanup(db).clearIfPresent();
    await VocabularyCatalogImporter(db).importAssetIfNeeded();
    await TopicCatalogImporter(db).importAssetIfNeeded();
    await ReminderScheduler.instance.sync(container.read(settingsProvider));
  } catch (error, stack) {
    debugPrint('Lexora startup failed: $error\n$stack');
  } finally {
    container.read(startupTickProvider.notifier).bump();
  }
}
