import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/edit_account_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/categories/presentation/categories_screen.dart';
import '../../features/grammar/presentation/grammar_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/patterns/presentation/patterns_screen.dart';
import '../../features/notifications/presentation/notification_center_screen.dart';
import '../../features/progress/presentation/cefr_level_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/review/presentation/review_session_screen.dart';
import '../../features/sentences/presentation/sentences_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/speaking/presentation/speaking_screen.dart';
import '../../features/blog/presentation/blog_screens.dart';
import '../../features/topics/presentation/topic_detail_screen.dart';
import '../../features/topics/presentation/topics_screen.dart';
import '../../features/vocabulary/presentation/catalog_word_screen.dart';
import '../../features/shell/presentation/main_shell.dart';
import '../../features/words/presentation/words_screen.dart';
import '../../core/providers/settings_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Long-lived router. Auth/settings changes refresh redirects via
/// [refreshListenable] — they must NOT recreate this GoRouter instance.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final settings = ref.read(settingsProvider);

      final loggingIn = state.matchedLocation == '/sign-in' ||
          state.matchedLocation == '/register';
      final onboarding = state.matchedLocation == '/onboarding';
      final isAuth = auth.status == AuthStatus.authenticated;
      final unknown = auth.status == AuthStatus.unknown;

      if (unknown) return null;

      if (!isAuth) {
        return loggingIn ? null : '/sign-in';
      }

      if (!settings.onboardingCompleted && !onboarding) {
        return '/onboarding';
      }

      if ((loggingIn || onboarding) && settings.onboardingCompleted) {
        return '/home';
      }

      if (loggingIn && !settings.onboardingCompleted) {
        return '/onboarding';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/words',
                builder: (context, state) => const WordsScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'add',
                    builder: (context, state) => const AddWordScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: ':id',
                    builder: (context, state) => WordDetailsScreen(
                      wordId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sentences',
                builder: (context, state) => const SentencesScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'add',
                    builder: (context, state) => const AddSentenceScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: ':id',
                    builder: (context, state) => SentenceDetailsScreen(
                      sentenceId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/progress',
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/notifications',
        builder: (context, state) => const NotificationCenterScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/review',
        builder: (context, state) => const ReviewSessionScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/account',
        builder: (context, state) => const EditAccountScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/speaking',
        builder: (context, state) => SpeakingScreen(
          sentenceId: state.uri.queryParameters['id'],
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/patterns',
        builder: (context, state) => const PatternsScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'add',
            builder: (context, state) => const AddPatternScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/blog',
        builder: (context, state) => const BlogListScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'write',
            builder: (context, state) => BlogEditorScreen(
              blogId: state.uri.queryParameters['id'],
            ),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/topics',
        builder: (context, state) => const TopicsScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'path/:pathId',
            builder: (context, state) => TopicsScreen(
              pathId: state.pathParameters['pathId'],
            ),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: ':id',
            builder: (context, state) => TopicDetailScreen(
              topicId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/grammar',
        builder: (context, state) => const GrammarListScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) => GrammarLessonScreen(
              topicId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/progress/level/:level',
        builder: (context, state) => CefrLevelScreen(
          level: state.pathParameters['level']!,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/vocabulary/:id',
        builder: (context, state) => CatalogWordScreen(
          entryId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(this._ref) {
    _ref.listen(authProvider, (_, _) => notifyListeners());
    _ref.listen(settingsProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}
