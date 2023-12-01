import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/component/form_component.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/screens/editProfile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.id});

  final int id;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  User user = User(
    id: 0,
    email: '',
    no_telp: '',
    tgl_lahir: '',
    username: '',
  );
  String _tanggal = '';

  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User res = await AuthClient.find(widget.id);
      setState(() {
        isLoading = false;
        usernameController.value = TextEditingValue(text: res.username);
        emailController.value = TextEditingValue(text: res.email);
        notelpController.value = TextEditingValue(text: res.no_telp);
        dateController.value = TextEditingValue(text: res.tgl_lahir);
      });
    } catch (err) {
      Navigator.pop(context);
    }
  }

  Future<void> update() async {
    try {
      await AuthClient.update(user);
      print('berhasil lewat');
    } catch (err) {
      Navigator.pop(context);
      print(err);
    }
  }

  void setUser() {
    setState(() {
      user = User(
        id: widget.id,
        email: emailController.text,
        no_telp: notelpController.text,
        tgl_lahir: dateController.text,
        username: usernameController.text,
      );
    });

    print(user.id);
    print(user.username);
    print(user.email);
    print(user.no_telp);
    print(user.tgl_lahir);
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
                          setUser();
                          await update();

                          Fluttertoast.showToast(
                            msg: "Berhasil Update",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: const Text('Simpan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
