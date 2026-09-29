# Lexora

Premium bilingual (English / Arabic) English-learning app — **local-first**, offline vocabulary, sentences, patterns, spaced repetition, and progress tracking.

**Developed by Hatem Husam**

## Stack

- Flutter 3.47+ / Dart 3.13+
- Material 3 + Riverpod + go_router
- Drift + SQLite (`drift_flutter`)
- flutter_localizations / intl (EN + AR, RTL)
- Local TTS via `PronunciationService` abstraction
- Firebase Auth / Google / Apple ready (session currently uses secure local auth until Firebase project files are added)

## Run

```bash
# Ensure Flutter is on PATH (SDK installed at ~/development/flutter on this machine)
flutter pub get
dart run build_runner build
flutter run
```

First launch seeds **demo data** (toggle off via `seedDemoData` in settings before production).

## Architecture

```
lib/
  app/          # theme, router, root MaterialApp
  core/         # database, services, shared widgets
  features/     # auth, home, words, sentences, patterns, review, progress, settings…
  l10n/         # ARB localization
```

Learning data never leaves the device unless the user exports a backup (`schemaVersion` included).

## Phase status

**Phase 1 complete:** project scaffold, design system, EN/AR l10n, routing shell, Drift schema, demo seed, auth/onboarding UI, Home / Words / Sentences / Patterns / Review / Progress / Settings.

**Phase 2 complete:** Categories CRUD, richer Words/Sentences filters & sort, local reminder scheduling (quiet hours + reminders/day).

**Phase 3 complete:** backup export/import, speaking practice (listen, record, playback — no fabricated scores), clearest installed English voice with audio cache.

**Phase 4 complete:** dashboard and progress use SQL counts (no full-table loads), real review streaks, localized part of speech, safe word deletion, store display name Lexora.

Release signing still uses the debug keystore until a production keystore is added.
