import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/register.dart';

void main() {
  testWidgets('RegisterView Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterView(),
      ),
    );

    expect(find.text('Gabriel Alba'), findsOneWidget);
    expect(find.text('gabriel@gmail.com'), findsOneWidget);
    expect(find.text('xxxxxxx'), findsOneWidget);
    expect(find.text('082123456789'), findsOneWidget);
    expect(find.text('2004-12-12'), findsOneWidget);

    // Find the specific ElevatedButton you want to tap
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.enterText(find.byKey(ValueKey('username')), 'rafael');
    await tester.enterText(find.byKey(ValueKey('email')), 'r@gmail.com');
    await tester.enterText(find.byKey(ValueKey('password')), 'password');
    await tester.enterText(find.byKey(ValueKey('noTelp')), '087736577867');

    // Tap the specific ElevatedButton
    await tester.tap(registerButtonFinder);

    // Wait for the animation to complete
    await tester.pumpAndSettle();

    // Await the completion of the register function
    await tester.runAsync(() async {
      // Wait for a short duration to allow for the completion of the register function
      await Future.delayed(Duration(milliseconds: 500));
    });
  });
}
