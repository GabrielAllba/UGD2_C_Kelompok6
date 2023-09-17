import 'package:flutter/material.dart';

Padding inputForm(
  Function(String?) validasi, {
  required TextEditingController controller,
  required String hintTxt,
  required String helperTxt,
  required IconData iconData,
  bool password = false,
  bool isDate = false,
  Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: isDate == false
        ? SizedBox(
            width: 350,
            child: TextFormField(
              onTap: onTap,
              validator: (value) => validasi(value),
              autofocus: true,
              controller: controller,
              obscureText: password,
              decoration: InputDecoration(
                hintText: hintTxt,
                labelText: hintTxt,
                border: const OutlineInputBorder(),
                helperText: helperTxt,
                prefixIcon: Icon(iconData),
              ),
            ),
          )
        : SizedBox(
            width: 350,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintTxt,
                border: const OutlineInputBorder(),
                helperText: helperTxt,
                prefixIcon: Icon(iconData),
              ),
              readOnly: true,
              onTap: onTap,
            ),
          ),
  );
}
