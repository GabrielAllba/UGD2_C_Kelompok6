import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/screens/search_kamar.dart';

void main() {
  testWidgets('CreateView Widget Test', (WidgetTester tester) async {
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
      return MaterialApp(
          home: SearchKamar(
        checkin: '1998-05-08',
        checkout: '2000-05-08',
      ));
    }));

    await tester.tap(find.text('Premium'));

    await tester.pumpAndSettle();
    expect(find.text('Premium'), findsOneWidget);

    expect(find.text('Pesan Sekarang'), findsOneWidget);

    await tester.tap(find.text('Pesan Sekarang'));

    await tester.pumpAndSettle();
  });
}
