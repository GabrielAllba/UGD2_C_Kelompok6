import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/components/item_prof.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:ugd2_c_kelompok6/screens/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.id});

  final int id;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User(
    username: '',
    password: '',
    email: '',
    no_telp: '',
    tgl_lahir: '',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
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
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: ItemProfile(
              id: widget.id,
            ),
          ),
        );
      },
    );
  }
}
