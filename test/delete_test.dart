import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  testWidgets('Delete Pemesanan Widget Test', (WidgetTester tester) async {
    const int id_user = 3;
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
      return MaterialApp(home: Pemesanan(id_user: id_user));
    }));

    await tester.pumpAndSettle();

    await tester.drag(find.text('Super Deluxe'), const Offset(-1000, 0));

    await tester.pumpAndSettle();

    await tester.tap(find.text('Batalkan'));

    await tester.pumpAndSettle();
  });
}
