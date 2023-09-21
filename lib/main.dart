import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd2_c_kelompok6/login.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';

void main() {
  runApp(const MainApp());
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
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
