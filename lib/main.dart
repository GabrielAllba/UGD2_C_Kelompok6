import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd2_c_kelompok6/login.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 42, 122, 255),
      primary: const Color.fromARGB(255, 42, 122, 255),
      secondary: const Color.fromARGB(255, 255, 74, 24),
    ),
    textTheme: GoogleFonts.latoTextTheme());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        Device.orientation == Orientation.portrait
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );

        Device.screenType == ScreenType.tablet
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
        return MaterialApp(
          theme: theme,
          home: const LoginView(),
        );
      },
    );
  }
}
