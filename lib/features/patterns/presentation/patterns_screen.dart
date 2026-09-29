import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/lexora_widgets.dart';

class PatternsScreen extends ConsumerWidget {
  const PatternsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final db = ref.watch(appDatabaseProvider);
    final stream = (db.select(db.sentencePatterns)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.patterns),
        actions: [
          IconButton(
            onPressed: () => context.push('/patterns/add'),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting &&
              items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (items.isEmpty) {
            return EmptyState(
              title: l10n.sentencePatterns,
              message: l10n.addMorePatterns,
              actionLabel: l10n.addPattern,
              onAction: () => context.push('/patterns/add'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final p = items[index];
              return LexoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LtrText(
                      p.pattern,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    RtlText(p.arabicExplanation),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CefrBadge(level: p.cefrLevel),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.push('/review'),
                          child: Text(l10n.practicePattern),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddPatternScreen extends ConsumerStatefulWidget {
  const AddPatternScreen({super.key});

  @override
  ConsumerState<AddPatternScreen> createState() => _AddPatternScreenState();
}

class _AddPatternScreenState extends ConsumerState<AddPatternScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patternCtrl = TextEditingController();
  final _arCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  CefrLevel _cefr = CefrLevel.b1;
  bool _saving = false;

  @override
  void dispose() {
    _patternCtrl.dispose();
    _arCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();
    await db.into(db.sentencePatterns).insert(
          SentencePatternsCompanion.insert(
            id: const Uuid().v4(),
            pattern: _patternCtrl.text.trim(),
            arabicExplanation: _arCtrl.text.trim(),
            cefrLevel: _cefr.code,
            grammarNotes: Value(
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
            ),
            createdAt: now,
            updatedAt: now,
          ),
        );
    if (mounted) {
      setState(() => _saving = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addPattern)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _patternCtrl,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(labelText: l10n.sentencePatterns),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _arCtrl,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(labelText: l10n.arabicMeaning),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: CefrLevel.values
                  .map(
                    (level) => ChoiceChip(
                      label: Text(level.code),
                      selected: _cefr == level,
                      onSelected: (_) => setState(() => _cefr = level),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration: InputDecoration(labelText: l10n.notes),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            LexoraPrimaryButton(
              label: l10n.save,
              isLoading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
