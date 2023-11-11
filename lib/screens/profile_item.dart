import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/screens/profile_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem({super.key, required this.orang});

  final Orang orang;

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
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return FutureBuilder<Orang>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 150),
                        child: coverImage(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 150),
                        child: profileImage(),
                      ),
                      Positioned(
                        top: 280,
                        child: Container(
                          child: ElevatedCard(
                            content: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 219, 233, 255),
                                            child: Icon(
                                              Icons.school_outlined,
                                              color:
                                                  Color.fromARGB(255, 42, 124, 255),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                usernameController.text,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                'Username',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          const CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 219, 233, 255),
                                            child: Icon(
                                              Icons.computer_outlined,
                                              color:
                                                  Color.fromARGB(255, 42, 124, 255),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                emailController.text,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                'Email',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 219, 233, 255),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              color:
                                                  Color.fromARGB(255, 42, 124, 255),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${notelpController.text}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                'No Telpon',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          const CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 219, 233, 255),
                                            child: Icon(
                                              Icons.numbers_outlined,
                                              color:
                                                  Color.fromARGB(255, 42, 124, 255),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${dateController.text}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                'Tanggal Lahir',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Akses',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              orang: snapshot.data!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Text('No Data');
            }
          },
        );
      }
    );
  }

  Widget coverImage() => Container(
      color: Colors.grey,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 42, 122, 255),
              Color.fromARGB(255, 64, 224, 238),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));

  Uint8List generateRandomImage() {
    final random = Random();
    final imageSize = 100; // Adjust the size as needed
    final pixels = List<int>.generate(
        imageSize * imageSize, (index) => random.nextInt(256));

    final imageBytes = Uint8List.fromList(pixels);
    return imageBytes;
  }

  Widget profileImage() => Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(71, 255, 255, 255),
            radius: 70,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                backgroundImage:
                    MemoryImage(widget.orang.gambar), // Use random image
                radius: double.infinity,
              ),
            ),
          ),
        ],
      );
  Future<void> ambilData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final id = pref.getInt('id');

    final isiData = await _getData(id!);

    if (isiData != null) {
      setState(() {
        usernameController.text = isiData['username'] ?? '';
        emailController.text = isiData['email'] ?? '';
        passwordController.text = isiData['password'] ?? '';
        notelpController.text = isiData['notelp'] ?? '';
        dateController.text = isiData['date'] ?? '';
      });
    }
  }

  Future<Map<String, dynamic>?> _getData(int id) async {
    return await SQLHelper.getUserById(id);
  }

  Future<Orang> _fetchUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('id');

    if (userId != null) {
      final user = await SQLHelper.getUserById(userId);
      final userFix = await SQLHelper.convertToOrang(user);

      return userFix;
    }

    return Orang(
        id: 1,
        username: '',
        email: '',
        password: '',
        noTelp: '',
        date: '',
        gambar: Uint8List(0));
  }
}
