import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../core/database/app_database.dart';
import '../core/providers/settings_provider.dart';
import '../core/services/progress/achievement_catalog.dart';
import '../core/services/progress/activity_policy.dart';
import '../core/services/progress/learning_activity_store.dart';
import '../core/services/notifications/reminder_scheduler.dart';
import '../features/home/presentation/whats_new_dialog.dart';
import '../features/notifications/domain/in_app_notice.dart';
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
      builder: (context, child) => LearningSessionHost(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

class LearningSessionHost extends ConsumerStatefulWidget {
  const LearningSessionHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<LearningSessionHost> createState() => _LearningSessionHostState();
}

class _LearningSessionHostState extends ConsumerState<LearningSessionHost>
    with WidgetsBindingObserver {
  static const _learningPrefixes = [
    '/words',
    '/vocabulary',
    '/review',
    '/grammar',
    '/topics',
    '/blog',
    '/sentences',
  ];

  DateTime? _segmentStart;
  DateTime _lastPulse = DateTime.now();
  bool _foreground = true;
  Timer? _flushTimer;
  bool _showingCelebration = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ReminderScheduler.instance.bind((payload) {
      ref.read(appRouterProvider).push(notificationRoute(payload));
    });
    _flushTimer = Timer.periodic(const Duration(seconds: 30), (_) => _flush());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showWhatsNewIfNeeded(context);
      if (mounted) _celebrate();
    });
  }

  @override
  void dispose() {
    _flushTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _foreground = true;
      _pulse();
    } else {
      _foreground = false;
      _flush();
    }
  }

  bool _isLearningRoute() {
    final location = GoRouter.of(context).routeInformationProvider.value.uri.path;
    return _learningPrefixes.any(location.startsWith);
  }

  void _pulse() {
    if (!_isLearningRoute()) return;
    final now = DateTime.now();
    _segmentStart ??= now;
    _lastPulse = now;
  }

  Future<void> _flush() async {
    final elapsed = const LearningTimePolicy().elapsed(
      foreground: _foreground && _isLearningRoute(),
      segmentStart: _segmentStart,
      lastPulse: _lastPulse,
      now: DateTime.now(),
    );
    _segmentStart = _foreground && _isLearningRoute() ? DateTime.now() : null;
    if (elapsed.inSeconds <= 0) return;
    await LearningActivityStore(ref.read(appDatabaseProvider)).add(
      seconds: elapsed.inSeconds,
    );
    if (mounted) _celebrate();
  }

  Future<void> _celebrate() async {
    if (_showingCelebration || !mounted) return;
    final pending = await AchievementService(ref.read(appDatabaseProvider)).uncelebrated();
    if (pending.isEmpty || !mounted) return;
    _showingCelebration = true;
    final item = pending.first;
    final definition = AchievementCatalog.byId(item.id);
    final arabic = Localizations.localeOf(context).languageCode == 'ar';
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.emoji_events_outlined, size: 36),
                const SizedBox(height: 12),
                Text(l10n.congratulations, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(arabic ? definition?.titleAr ?? item.id : definition?.titleEn ?? item.id),
                const SizedBox(height: 8),
                Text(l10n.achievementUnlocked),
              ],
            ),
          ),
        );
      },
    );
    await AchievementService(ref.read(appDatabaseProvider)).markCelebrated(item.id);
    _showingCelebration = false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pulse(),
      child: widget.child,
    );
  }
}
