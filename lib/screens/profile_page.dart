import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugd2_c_kelompok6/screens/profile.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.orang});
  final Orang orang;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController notelpController;
  late TextEditingController dateController;

  void setData() {
    setState(() {
      usernameController.text = widget.orang.username;
      emailController.text = widget.orang.email;
      passwordController.text = widget.orang.password;
      notelpController.text = widget.orang.noTelp;
    });
  }

  int? idUser;
  Key imageKey = UniqueKey();
  Uint8List? imageFile;
  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    notelpController = TextEditingController();
    dateController = TextEditingController();
    ambilData();
    getIdUser();
    setData();
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
      body: FutureBuilder(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Action on CircleAvatar Tap'),
                                content: Text('You tapped the avatar!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      getFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ambil Dari galery'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      getFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ambil Dari kamera'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: imageFile == null
                                ? MemoryImage(snapshot.data!.gambar)
                                : MemoryImage(imageFile!),
                            child: const Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            )
                            // Hide edit icon when not editing
                            ),
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
                          )),
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
            );
          } else {
            return const Text('No Data');
          }
        },
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
      imageFile = isiData['gambar'] ?? '';
    }
  }

  Future<void> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('id');
    });
  }

  Future<Map<String, dynamic>?> _getData() async {
    return await SQLHelper.getUserById(idUser!);
  }

  Future<void> updateData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final id = pref.getInt('id');

    Uint8List? gambar = imageFile ?? widget.orang.gambar;

    print(notelpController.text);
    await SQLHelper.editUser(
        id!,
        usernameController.text,
        passwordController.text,
        emailController.text,
        notelpController.text,
        widget.orang.date,
        gambar);
  }

  getFromCamera() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
  }

  getFromGallery() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
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
}
