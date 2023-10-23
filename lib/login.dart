import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/component/form_component.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart';
import 'package:ugd2_c_kelompok6/screens/register.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "username tidak boleh kosong";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Inputkan User yang telah didaftar",
                  iconData: Icons.person),
              //* Password
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 450,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String username = usernameController.text;
                        String password = passwordController.text;

                        List<Map<String, dynamic>> user =
                            await SQLHelper.getViaUser(username);
                        if (user.isNotEmpty &&
                            user[0]['password'] == password) {
                          Fluttertoast.showToast(
                            msg: "Berhasil Login",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          await saveUserName(username);
                          await saveIdUser(user[0]['id']);

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
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              title: const Text('Password Salah'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
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
}
