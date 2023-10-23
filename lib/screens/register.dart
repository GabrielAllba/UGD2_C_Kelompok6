import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/component/form_component.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/login.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String _tanggal = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
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
                        if (_formKey.currentState!.validate() &&
                            _tanggal.isNotEmpty) {
                          if (await SQLHelper.isUsernameExists(
                                  usernameController.text) ==
                              true) {
                            Fluttertoast.showToast(
                              msg: "Username sudah digunakan orang lain!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else if (await SQLHelper.isEmailExists(
                                  emailController.text) ==
                              true) {
                            Fluttertoast.showToast(
                              msg: "Email sudah digunakan oleh orang lain!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            Map<String, dynamic> formData = {};
                            formData['username'] = usernameController.text;
                            formData['password'] = passwordController.text;

                            await addUser();

                            Fluttertoast.showToast(
                              msg: "Berhasil Register",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                            await Future.delayed(
                              Duration(seconds: 2),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginView(
                                  data: formData,
                                ),
                              ),
                            );
                          }

                          if (_tanggal.isEmpty) {
                            _showMyDialog();
                          }
                        }
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
  }

  Future<void> addUser() async {
    await SQLHelper.addUser(usernameController.text, passwordController.text,
        emailController.text, notelpController.text, dateController.text);
  }
}
