import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minni_birthday/main.dart';

void main() {
  testWidgets('Birthday surprise flow smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MinniBirthdayApp());
    expect(find.textContaining('Pathan Munni'), findsWidgets);

    // Tap to unlock surprise
    final unlockButton = find.textContaining('Unwrap The Grand Surprise');
    expect(unlockButton, findsOneWidget);
    await tester.tap(unlockButton);
    await tester.pump(const Duration(milliseconds: 500));

    // Verify inside chapter 1
    expect(find.textContaining('Pathan Munni'), findsWidgets);
  });
}
