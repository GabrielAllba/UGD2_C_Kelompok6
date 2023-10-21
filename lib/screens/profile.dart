import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/screens/profile_item.dart';
import 'package:ugd2_c_kelompok6/data/kelompok.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('Profile'),
          ),
          body: ProfileItem(orang: kelompok[0])),
    );
  }
}
