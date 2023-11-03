import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Orang {
  const Orang({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.noTelp,
    required this.date,
    required this.gambar,
  });
  final int id;
  final String username;
  final String email;
  final String password;
  final String noTelp;
  final String date;
  final Uint8List gambar;
}
