import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/screens/editProfile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                //controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              TextFormField(
                  //   controller: passwordController,
                  decoration: const InputDecoration(
                labelText: "Password",
              )),
              TextFormField(
                  //  controller: emailController,
                  decoration: const InputDecoration(
                labelText: "Email",
              )),
              TextFormField(
                //    controller: notelpController,
                decoration: const InputDecoration(
                  labelText: "Nomor Telepon",
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
