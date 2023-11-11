import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:ugd2_c_kelompok6/screens/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? idUser;

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text('Profile'),
            ),
            body: FutureBuilder<Orang>(
              future: _fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ProfileItem(orang: snapshot.data!);
                } else {
                  return const Text('No Data');
                }
              },
            ),
          ),
       );
      }
    );
  }

  Future<Orang> _fetchUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('id');

    if (userId != null) {
      final user = await SQLHelper.getUserById(userId);
      final userFix = await SQLHelper.convertToOrang(user);
      return userFix;
    }

    // Return a default Orang if the user data is not available.
    return Orang(
        id: 1,
        username: '',
        email: '',
        password: '',
        noTelp: '',
        date: '',
        gambar: Uint8List(0));
  }

  Future<void> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('id');
    });
  }
}
