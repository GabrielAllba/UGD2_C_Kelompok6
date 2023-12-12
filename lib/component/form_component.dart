import 'package:flutter/material.dart';

class MyInputForm extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final bool password;
  final bool isDate;
  final bool isPassword;
  final Function()? onTap;

  MyInputForm({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
    this.password = false,
    this.isDate = false,
    this.isPassword = false,
    this.onTap,
  });

  @override
  _MyInputFormState createState() => _MyInputFormState();
}

class _MyInputFormState extends State<MyInputForm> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    Widget childWidget;
    if (widget.isDate == false && widget.isPassword == false) {
      childWidget = SizedBox(
        width: double.infinity,
        child: TextFormField(
          onTap: widget.onTap,
          validator: (value) => widget.validasi(value),
          autofocus: true,
          controller: widget.controller,
          obscureText: widget.password,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            labelText: widget.hintTxt,
            border: const OutlineInputBorder(),
            helperText: widget.helperTxt,
            prefixIcon: Icon(widget.iconData),
          ),
        ),
      );
    } else if (widget.isPassword == true) {
      childWidget = SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controller,
          obscureText: !isPasswordVisible,
          validator: (value) => widget.validasi(value),
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
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            prefixIcon: const Icon(Icons.password),
          ),
        ),
      );
    } else {
      childWidget = SizedBox(
        width: double.infinity,
        child: TextFormField(
          validator: (value) => widget.validasi(value),
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            border: const OutlineInputBorder(),
            helperText: widget.helperTxt,
            prefixIcon: Icon(widget.iconData),
          ),
          readOnly: true,
          onTap: widget.onTap,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: childWidget,
    );
  }
}
