import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
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
      return MaterialApp(home: HomeScreen());
    }));

    expect(find.text('Nama Kamar'), findsOneWidget);
    expect(find.text('Tanggal Checkin'), findsOneWidget);
    expect(find.text('Tanggal Checkout'), findsOneWidget);

    final createButtonFinder = find.widgetWithText(ElevatedButton, 'Cari');

    await tester.enterText(find.byKey(ValueKey('namaKamar')), 'Deluxe');
    await tester.enterText(find.byKey(ValueKey('tglCheckin')), '2023-11-25');
    await tester.enterText(find.byKey(ValueKey('tglCheckin')), '2023-11-29');

    await tester.tap(createButtonFinder);

    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await Future.delayed(Duration(milliseconds: 500));
    });
  });
}
