import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugd2_c_kelompok6/screens/profile.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile User'), // Judul AppBar
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Profile(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircleAvatar(
                  radius: 60, // Ubah sesuai kebutuhan
                  backgroundImage: AssetImage(
                      'images/robby.jpg'), // Ganti dengan sumber foto profil yang sesuai
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: usernameController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                    )
                    // Untuk mengaburkan teks
                    ),
                TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    )),
                TextFormField(
                  controller: notelpController,
                  decoration: const InputDecoration(
                    labelText: "Nomor Telepon",
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateData();
                        Fluttertoast.showToast(
                          msg: "Berhasil Update Data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Future<void> updateData() async {
    String updateUser = usernameController.text;
    String updatePass = passwordController.text;
    String updateEmail = emailController.text;
    String updateNoTelp = notelpController.text;

    await SQLHelper.editUserByUserName(
        updateUser, updatePass, updateEmail, updateNoTelp);
  }
}
