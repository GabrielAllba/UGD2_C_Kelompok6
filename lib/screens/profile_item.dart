import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/screens/profile_page.dart';

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
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
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
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
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
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
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
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
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
                  builder: (context) => ProfilePage(),
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

        // CustomScrollView(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   slivers: <Widget>[
        //     SliverGrid(
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //       ),
        //       delegate: SliverChildBuilderDelegate(
        //         (BuildContext context, int index) {
        //           return Padding(
        //             padding: const EdgeInsets.all(8),
        //             child: GridTile(
        //               child: Material(
        //                 elevation: 5,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(8.0),
        //                 ),
        //                 shadowColor: Colors.black.withOpacity(0.4),
        //                 child: Container(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Icon(
        //                         widget.orang.hobi[index].icon,
        //                         color: Theme.of(context).colorScheme.primary,
        //                         size: 48,
        //                       ),
        //                       const SizedBox(
        //                         height: 4,
        //                       ),
        //                       Text(
        //                         widget.orang.hobi[index].nama,
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //         childCount: widget.orang.hobi.length,
        //       ),
        //     ),
        //   ],
        // ),
      ],
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

  Widget profileImage() => Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(71, 255, 255, 255),
            radius: 70,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(widget.orang.profile),
                radius: double.infinity,
              ),
            ),
          ),
        ],
      );

  Future<void> ambilData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      usernameController.text = pref.getString('username') ?? '';
    });

    final isiData = await _getData();
    if (isiData != null) {
      usernameController.text = isiData['username'] ?? '';
      emailController.text = isiData['email'] ?? '';
      passwordController.text = isiData['password'] ?? '';
      notelpController.text = isiData['notelp'] ?? '';
      dateController.text = isiData['date'] ?? '';
    }
  }

  Future<Map<String, dynamic>?> _getData() async {
    return await SQLHelper.getUserByUsername(usernameController.text);
  }
}
