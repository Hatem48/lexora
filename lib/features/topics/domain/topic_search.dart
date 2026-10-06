import '../../../core/services/topics/topic_repository.dart';

class TopicSearchSection {
  const TopicSearchSection({required this.group, required this.cards});

  final TopicGroupDataView group;
  final List<TopicCardData> cards;
}

/// Local filter over the topics already loaded for the screen.
///
/// An empty query keeps every topic, plus a newly imported category that has
/// no topics yet so its badge can be seen. A category whose own name matches
/// shows all of its topics. Any other category is limited to topics whose
/// name or description matches, and is hidden when that list is empty.
List<TopicSearchSection> topicSearchSections({
  required List<TopicGroupDataView> groups,
  required List<TopicCardData> cards,
  required String query,
  Set<String> newCategoryIds = const {},
  Set<String>? limitToTopicIds,
}) {
  final pool = limitToTopicIds == null
      ? cards
      : [
          for (final card in cards)
            if (limitToTopicIds.contains(card.id)) card,
        ];
  final normalized = query.trim().toLowerCase();
  final sections = <TopicSearchSection>[];
  for (final group in groups) {
    final inGroup = [
      for (final card in pool)
        if (card.groupId == group.id) card,
    ];
    if (normalized.isEmpty) {
      if (inGroup.isNotEmpty || newCategoryIds.contains(group.id)) {
        sections.add(TopicSearchSection(group: group, cards: inGroup));
      }
      continue;
    }
    final categoryHit = group.nameEn.toLowerCase().contains(normalized) ||
        group.nameAr.toLowerCase().contains(normalized);
    final matched = categoryHit
        ? inGroup
        : [
            for (final card in inGroup)
              if (topicMatchesQuery(card, normalized)) card,
          ];
    if (matched.isNotEmpty) {
      sections.add(TopicSearchSection(group: group, cards: matched));
    }
  }
  return sections;
}

bool topicMatchesQuery(TopicCardData card, String normalizedQuery) {
  return card.nameEn.toLowerCase().contains(normalizedQuery) ||
      card.nameAr.toLowerCase().contains(normalizedQuery) ||
      card.descriptionEn.toLowerCase().contains(normalizedQuery) ||
      card.descriptionAr.toLowerCase().contains(normalizedQuery);
}
