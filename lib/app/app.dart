import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../core/providers/settings_provider.dart';
import '../core/services/pronunciation/pronunciation_service.dart';
import '../core/services/pronunciation/quality_tts_service.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

final pronunciationServiceProvider = Provider<PronunciationService>((ref) {
  final service = QualityTtsService();
  ref.onDispose(service.dispose);
  return service;
});

class LexoraApp extends ConsumerWidget {
  const LexoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Lexora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.flutterThemeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
