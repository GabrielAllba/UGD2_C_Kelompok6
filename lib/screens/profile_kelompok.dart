import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/screens/profile_item.dart';
import 'package:ugd2_c_kelompok6/data/kelompok.dart';

class ProfileKelompok extends StatelessWidget {
  const ProfileKelompok({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: kelompok.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            bottom: TabBar(
              tabs: kelompok.map((person) {
                return Tab(
                  icon: Icon(
                    person.gender == 'L'
                        ? Icons.man_2_outlined
                        : Icons.woman_2_outlined,
                  ),
                  text: person.panggilan,
                );
              }).toList(),
            ),
            title: const Text('Profile Kelompok'),
          ),
          body: TabBarView(
            children: kelompok.map((person) {
              return ProfileItem(orang: person);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
