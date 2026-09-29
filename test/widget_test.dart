import 'package:flutter_test/flutter_test.dart';
import 'package:lexora/core/constants/app_info.dart';

void main() {
  test('app info constants', () {
    expect(AppInfo.version, isNotEmpty);
    expect(AppInfo.developer, 'Hatem Husam');
  });
}
