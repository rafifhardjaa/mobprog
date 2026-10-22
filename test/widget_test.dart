import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mob_prog/main.dart';

void main() {
  testWidgets('shows the profile card', (tester) async {
    await tester.pumpWidget(const ProfileCardApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.byKey(const Key('profile-card')), findsOneWidget);
    expect(find.text('Rahman\nAr Rafif'), findsOneWidget);
    expect(find.text('2210512037'), findsOneWidget);
    expect(find.text('Juni 2027'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('fits on a small phone', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProfileCardApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Rahman\nAr Rafif'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
