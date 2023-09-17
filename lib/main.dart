import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/View/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterView(),
    );
  }
}
