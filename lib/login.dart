import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/screens/register.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data, this.authClient});

  final AuthClient? authClient;

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

  Future<Response> login() async {
    try {
      Response res = await widget.authClient!.loginTesting(
        emailController.text,
        passwordController.text,
      );
      return res;
    } catch (err) {
      return Response(err.toString(), 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        Device.orientation == Orientation.portrait
            ? Container(
                width: 100.0.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.0.w,
                height: 12.5.h,
              );

        Device.screenType == ScreenType.tablet
            ? Container(
                width: 100.0.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.0.w,
                height: 12.5.h,
              );
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        key: const ValueKey('email'),
                        controller: emailController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "password kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Email",
                          labelText: "email",
                          helperText: "Inputkan Email",
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  //* Password
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        key: const ValueKey('password'),
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
                          labelText: "password",
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
                        onPressed: () async {
                          Response res = await login();

                          if (res.statusCode == 200) {
                            // var responseData = json.decode(res.body);
                            // Map<String, dynamic> user = responseData['user'];
                            // print(user['id']);

                            // saveIdUser(user['id']);

                            Fluttertoast.showToast(
                              msg: "Login Success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
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
                                builder: (_) => const TabsScreen(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "Login failed. Please check your credentials.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
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
