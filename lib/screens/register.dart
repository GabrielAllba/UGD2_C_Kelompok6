import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/component/form_component.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/login.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String _tanggal = '';
  User user = User(
    username: '',
    password: '',
    email: '',
    no_telp: '',
    tgl_lahir: '',
  );

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    loadImageFromAssets();
  }

  Future<void> loadImageFromAssets() async {
    try {
      final ByteData data = await rootBundle.load('images/robby.jpg');
      imageBytes = data.buffer.asUint8List();
      setState(() {});
    } catch (e) {
      print('Error loading image from assets: $e');
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: const Text(
            'Error ngab',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Pastikan Semua Data Sudah Lengkap',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Paham',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2023),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _tanggal = formattedDate;
        dateController.text = formattedDate;
        print('checkin');
      });
    }
  }

  void updateUserModel() {
    setState(() {
      user = User(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
        no_telp: notelpController.text,
        tgl_lahir: dateController.text,
      );
    });
  }

  Future<void> register() async {
    try {
      await AuthClient.register(user);
      print('berhasil lewat');
    } catch (err) {
      Navigator.pop(context);
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
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
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 96,
                  ),
                  MyInputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Username Tidak Boleh Kosong';
                      }
                      if (p0.toLowerCase() == 'anjing') {
                        return 'Tidak boleh menggunakan kata kasar';
                      }
                      return null;
                    },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Gabriel Alba",
                    iconData: Icons.person,
                  ),
                  MyInputForm(
                    validasi: ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!p0.contains('@')) {
                        return 'Email harus menggunakan @';
                      }

                      return null;
                    }),
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "gabriel@gmail.com",
                    iconData: Icons.email,
                  ),
                  MyInputForm(
                    validasi: ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (p0.length < 5) {
                        return 'Password minimal 5 digit';
                      }
                      return null;
                    }),
                    controller: passwordController,
                    hintTxt: "Password",
                    helperTxt: "xxxxxxx",
                    iconData: Icons.password,
                    password: true,
                    isPassword: true,
                  ),
                  MyInputForm(
                    validasi: ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Nomor Telepon tidak boleh kosong';
                      }
                      return null;
                    }),
                    controller: notelpController,
                    hintTxt: "No Telp",
                    helperTxt: "082123456789",
                    iconData: Icons.phone_android,
                  ),
                  MyInputForm(
                    validasi: ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Tanggal Lahir';
                      }
                      return null;
                    }),
                    controller: dateController,
                    hintTxt: "Tanggal Lahir",
                    helperTxt: "2004-12-12",
                    onTap: _showDatePicker,
                    isDate: true,
                    iconData: Icons.date_range_outlined,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          updateUserModel();
                          await register();
                          print('asdfasdfasdfasdfadsfasdf');
                        },
                        child: const Text('Register'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginView(
                                data: formData,
                              ),
                            ),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
