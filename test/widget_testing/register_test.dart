import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/register.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  testWidgets('RegisterView Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        ResponsiveSizer(builder: (context, orientation, deviceType) {
      Device.orientation == Orientation.portrait
          ? SizedBox(
              width: 100.w,
              height: 20.5.h,
            )
          : SizedBox(
              width: 100.w,
              height: 12.5.h,
            );
      Device.screenType == ScreenType.tablet
          ? SizedBox(
              width: 100.w,
              height: 20.5.h,
            )
          : SizedBox(
              width: 100.w,
              height: 12.5.h,
            );
      return MaterialApp(home: RegisterView());
    }));

    expect(find.text('Gabriel Alba'), findsOneWidget);
    expect(find.text('gabriel@gmail.com'), findsOneWidget);
    expect(find.text('xxxxxxx'), findsOneWidget);
    expect(find.text('082123456789'), findsOneWidget);
    expect(find.text('2004-12-12'), findsOneWidget);

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.enterText(find.byKey(ValueKey('username')), 'rafael');
    await tester.enterText(find.byKey(ValueKey('email')), 'r@gmail.com');
    await tester.enterText(find.byKey(ValueKey('password')), '12345678');
    await tester.enterText(find.byKey(ValueKey('noTelp')), '087736577867');

    await tester.tap(registerButtonFinder);
    await tester.pump(const Duration(seconds: 8));
    await tester.pumpAndSettle();
  });
}
