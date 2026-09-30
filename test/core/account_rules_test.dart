import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/features/auth/data/auth_repository.dart';

void main() {
  test('account fields reject demo-style blanks and accept a real profile', () {
    expect(validateUsername('ab'), 'username_invalid');
    expect(validateUsername('Learner'), isNull);
    expect(normalizeUsername('Learner'), 'learner');
    expect(validatePassword('12345'), 'password_short');
    expect(validatePassword('secret1'), isNull);
    expect(validateDisplayName('  '), 'name_required');
    expect(validateDisplayName('Learner Name'), isNull);
    expect(validateEmail(''), isNull);
    expect(validateEmail('not-an-email'), 'email_invalid');
    expect(validateEmail('learner@example.com'), isNull);
  });
}
