import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/component/form_component.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:ugd2_c_kelompok6/screens/register.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }

  Future<void> saveUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<void> saveIdUser(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
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
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyInputForm(
                    validasi: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "username tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "Inputkan Email yang telah didaftar",
                    iconData: Icons.person,
                  ),
                  //* Password
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "password kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Password",
                          labelText: "Password",
                          helperText: "Inputkan Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.password),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {},
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text('Belum punya akun?'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
