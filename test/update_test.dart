import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';
import 'package:ugd2_c_kelompok6/screens/editTanggal_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  testWidgets('Update Widget Test', (WidgetTester tester) async {
    const String title = 'YourTitle';
    const int id = 1;
    const int id_user = 2;
    const String tanggal_checkin = '2023-10-10';
    const String tanggal_checkout = '2023-10-15';
    const String tipe_kamar = 'RoomType';
    const int harga = 100;
    const int harga_dasar = 90;
    const String qr_code = 'YourQRCode';

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
          home: InputPage(
        title: title,
        id: id,
        id_user: id_user,
        tanggal_checkin: tanggal_checkin,
        tanggal_checkout: tanggal_checkout,
        tipe_kamar: tipe_kamar,
        harga: harga,
        harga_dasar: harga_dasar,
        qr_code: qr_code,
      ));
    }));

    expect(find.text('Tanggal Checkin'), findsOneWidget);
    expect(find.text('Tanggal Checkout'), findsOneWidget);

    final updateButtonFinder = find.widgetWithText(ElevatedButton, 'Save');

    final dateTextFinder = find.text('Tanggal Checkin');
    await tester.pump(const Duration(seconds: 3));
    await tester.tap(dateTextFinder);
    await tester.pumpAndSettle();    
    final okButtonFinder = find.text('OK');

    final dateTextFinder2 = find.text('Tanggal Checkout');
    await tester.pump(const Duration(seconds: 3));
    await tester.tap(dateTextFinder2);
    await tester.pumpAndSettle();    
    final okButtonFinder2 = find.text('OK');

    await tester.tap(okButtonFinder);
    await tester.tap(okButtonFinder2);
    await tester.pumpAndSettle();

    await tester.tap(updateButtonFinder);
    await tester
        .pumpAndSettle(); // Wait for animations and async tasks to complete

    

  });
}
