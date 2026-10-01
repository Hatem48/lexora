class GrammarAnswer {
  const GrammarAnswer({required this.prompt, required this.given, required this.expected});

  final String prompt;
  final String given;
  final String expected;

  bool get correct =>
      given.trim().toLowerCase() == expected.trim().toLowerCase();
}

class GrammarScore {
  const GrammarScore({required this.correct, required this.total});

  final int correct;
  final int total;

  bool get passed => total > 0 && correct == total;
}

GrammarScore scoreGrammar(Iterable<GrammarAnswer> answers) {
  final list = answers.toList();
  return GrammarScore(
    correct: list.where((answer) => answer.correct).length,
    total: list.length,
  );
}
