import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

import 'test.mocks.dart';

@GenerateMocks([http.Client, AuthClient])
void main() {
  testWidgets('LoginView Widget Test', (WidgetTester tester) async {
    final client = MockClient();

    when(client.post(Uri.parse('http://10.0.0.2:8000/api/login'), body: {
      'email': 'r@gmail.com',
      'password': '12345678'
    }, headers: {
      'Accept': 'application/json',
    })).thenAnswer((_) async => http.Response(
        '{"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"}', 200));

    final authClient = MockAuthClient();
    when(authClient.loginTesting('r@gmail.com', '12345678'))
        .thenAnswer((_) async {
      return await client.post(Uri.parse('http://10.0.0.2:8000/api/login'),
          body: {'email': 'r@gmail.com', 'password': '12345678'},
          headers: {'Accept': 'application/json'});
    });

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
          home: LoginView(
        authClient: authClient,
      ));
    }));

    expect(find.byKey(const ValueKey('email')), findsOneWidget);
    expect(find.byKey(const ValueKey('password')), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('email')), 'r@gmail.com');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.enterText(find.byKey(const ValueKey('password')), '12345678');
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
