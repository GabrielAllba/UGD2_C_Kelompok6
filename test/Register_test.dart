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

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.enterText(find.byKey(ValueKey('username')), 'rafael');
    await tester.enterText(find.byKey(ValueKey('email')), 'r@gmail.com');
    await tester.enterText(find.byKey(ValueKey('password')), 'password');
    await tester.enterText(find.byKey(ValueKey('noTelp')), '087736577867');
    // await tester.enterText(find.byKey(ValueKey('tglLahir')), '2023-11-11');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await Future.delayed(Duration(milliseconds: 500));
    });
  });
}
