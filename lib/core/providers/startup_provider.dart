import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bumps after startup work finishes so screens reload catalog data
/// that arrived after the first frame.
class StartupTick extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final startupTickProvider = NotifierProvider<StartupTick, int>(StartupTick.new);
