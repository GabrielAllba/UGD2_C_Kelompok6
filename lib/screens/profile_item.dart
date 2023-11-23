import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/components/item_prof.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/screens/profile_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem({super.key, required this.user});

  final User user;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController notelpController;
  late TextEditingController dateController;
  late Orang orang;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    notelpController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          // child: ItemProfile(),
        )
      ],
    );
  }
}
