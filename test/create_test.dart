import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      return MaterialApp(home: HomeScreen(
      ));
    }));
    // Use a unique key for the TextField
  final namaKamarTextFieldFinder = find.byKey(const ValueKey('namaKamar'));

  // Verify that the TextField exists
  expect(namaKamarTextFieldFinder, findsOneWidget);
  
    expect(find.text('Nama Kamar'), findsOneWidget);
    expect(find.text('Tanggal Checkin'), findsOneWidget);
    expect(find.text('Tanggal Checkout'), findsOneWidget);

    final createButtonFinder = find.widgetWithText(ElevatedButton, 'Cari');

    await tester.enterText(find.byKey(ValueKey('namaKamar')), 'Deluxe');
    final dateTextFinder = find.text('2004-12-12');
    await tester.tap(dateTextFinder);
    await tester.pumpAndSettle();
    final okButtonFinder = find.text('OK');
    await tester.tap(okButtonFinder);
    await tester.pumpAndSettle();

    await tester.tap(createButtonFinder);

    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await Future.delayed(Duration(milliseconds: 500));
    });
  });
}
