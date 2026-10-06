import 'dart:convert';

const topicQuestionPayloadMark = 'lexoraQuestion';

class TopicQuestionOption {
  const TopicQuestionOption({
    required this.id,
    required this.en,
    required this.ar,
  });

  final String id;
  final String en;
  final String ar;
}

/// Stored in the existing suggested-answer column so older plain answers still display.
class TopicQuestionPayload {
  const TopicQuestionPayload({
    required this.type,
    required this.answerEn,
    required this.answerAr,
    required this.options,
    required this.correctOptionId,
  });

  final String type;
  final String answerEn;
  final String answerAr;
  final List<TopicQuestionOption> options;
  final String? correctOptionId;

  factory TopicQuestionPayload.plain(String answer) {
    return TopicQuestionPayload(
      type: 'conversation',
      answerEn: answer,
      answerAr: '',
      options: const [],
      correctOptionId: null,
    );
  }

  factory TopicQuestionPayload.parse(String raw) {
    final trimmed = raw.trim();
    if (!trimmed.startsWith('{')) return TopicQuestionPayload.plain(raw);
    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is! Map<String, dynamic> || decoded[topicQuestionPayloadMark] != 1) {
        return TopicQuestionPayload.plain(raw);
      }
      final options = <TopicQuestionOption>[];
      final rawOptions = decoded['options'];
      if (rawOptions is List) {
        for (final item in rawOptions) {
          if (item is! Map) continue;
          options.add(
            TopicQuestionOption(
              id: '${item['id'] ?? ''}',
              en: '${item['en'] ?? ''}',
              ar: '${item['ar'] ?? ''}',
            ),
          );
        }
      }
      return TopicQuestionPayload(
        type: decoded['type'] as String? ?? 'conversation',
        answerEn: decoded['answerEn'] as String? ?? '',
        answerAr: decoded['answerAr'] as String? ?? '',
        options: options,
        correctOptionId: decoded['correctOptionId'] as String?,
      );
    } catch (_) {
      return TopicQuestionPayload.plain(raw);
    }
  }

  String encode() {
    return jsonEncode({
      topicQuestionPayloadMark: 1,
      'type': type,
      'answerEn': answerEn,
      'answerAr': answerAr,
      'options': [
        for (final option in options)
          {'id': option.id, 'en': option.en, 'ar': option.ar},
      ],
      'correctOptionId': correctOptionId,
    });
  }

  String answerFor({required bool arabic}) {
    final answers = suggestedAnswers;
    if (arabic && answers.ar.isNotEmpty) return answers.ar;
    return answers.en;
  }

  bool get hasSuggestedAnswer {
    final answers = suggestedAnswers;
    return answers.en.isNotEmpty || answers.ar.isNotEmpty;
  }

  /// English and Arabic suggested answers. Multiple choice falls back to the correct option.
  ({String en, String ar}) get suggestedAnswers {
    if (answerEn.trim().isNotEmpty || answerAr.trim().isNotEmpty) {
      return (en: answerEn.trim(), ar: answerAr.trim());
    }
    for (final option in options) {
      if (option.id == correctOptionId) {
        return (en: option.en.trim(), ar: option.ar.trim());
      }
    }
    return (en: '', ar: '');
  }
}
