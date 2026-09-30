import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../topics/presentation/topic_icons.dart';
import '../../topics/presentation/topic_providers.dart';
import '../../vocabulary/presentation/discovery_summary_dialog.dart';
import '../data/blog_repository.dart';

class BlogListScreen extends ConsumerWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final blogs = ref.watch(blogsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.blog)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/blog/write'),
        child: const Icon(Icons.edit_outlined),
      ),
      body: blogs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.article_outlined,
              title: l10n.blogsEmpty,
              message: l10n.writeBlogDescription,
              actionLabel: l10n.writeBlog,
              onAction: () => context.push('/blog/write'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final blog = items[index];
              return LexoraCard(
                onTap: () => context.push('/blog/write?id=${blog.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.blogStatsLine(
                        blog.wordCount,
                        blog.uniqueClassified,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Distribution(json: blog.cefrDistributionJson),
                    _BlogTopics(blogId: blog.id),
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

class _BlogTopics extends ConsumerWidget {
  const _BlogTopics({required this.blogId});

  final String blogId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(blogTopicsProvider).asData?.value[blogId];
    if (topics == null || topics.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final topic in topics)
            ActionChip(
              label: Text(localizedPair(context, topic.nameEn, topic.nameAr)),
              onPressed: () => context.push('/topics/${topic.topicId}'),
            ),
        ],
      ),
    );
  }
}

class _Distribution extends StatelessWidget {
  const _Distribution({required this.json});

  final String json;

  @override
  Widget build(BuildContext context) {
    final decoded = jsonDecode(json);
    if (decoded is! Map || decoded.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final entry in decoded.entries)
          CefrBadge(level: '${entry.key}', compact: true),
      ],
    );
  }
}

class BlogEditorScreen extends ConsumerStatefulWidget {
  const BlogEditorScreen({super.key, this.blogId});

  final String? blogId;

  @override
  ConsumerState<BlogEditorScreen> createState() => _BlogEditorScreenState();
}

class _BlogEditorScreenState extends ConsumerState<BlogEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  var _loading = true;
  var _saving = false;
  BlogEntryRow? _existing;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = widget.blogId;
    if (id != null) {
      _existing = await ref.read(blogRepositoryProvider).find(id);
      _title.text = _existing?.title ?? '';
      _content.text = _existing?.content ?? '';
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final summary = await ref.read(blogRepositoryProvider).save(
          id: _existing?.id,
          title: _title.text.trim(),
          content: _content.text.trim(),
        );
    if (!mounted) return;
    setState(() => _saving = false);
    await showDiscoverySummary(context, summary);
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final id = _existing?.id;
    if (id == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmDeleteBlog),
        content: Text(l10n.confirmDeleteBlogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(blogRepositoryProvider).delete(id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_existing == null ? l10n.writeBlog : l10n.editBlog),
        actions: [
          if (_existing != null)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    controller: _title,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(labelText: l10n.blogTitle),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? l10n.requiredField
                            : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _content,
                    textDirection: TextDirection.ltr,
                    minLines: 8,
                    maxLines: 16,
                    decoration: InputDecoration(labelText: l10n.blogContent),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? l10n.requiredField
                            : null,
                  ),
                  const SizedBox(height: 24),
                  LexoraPrimaryButton(
                    label: l10n.save,
                    isLoading: _saving,
                    onPressed: _saving ? null : _save,
                  ),
                ],
              ),
            ),
    );
  }
}
