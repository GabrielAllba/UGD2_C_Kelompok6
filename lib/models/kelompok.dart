import 'package:flutter/material.dart';

class Orang {
  const Orang({
    required this.id,
    required this.profile,
    required this.nama,
    required this.panggilan,
    required this.gender,
    required this.email,
    required this.umur,
    required this.universitas,
    required this.programStudi,
    required this.npm,
    required this.tahunMasuk,
    required this.hobi,
  });
  final String id;
  final String profile;
  final String nama;
  final String panggilan;
  final String gender;
  final String email;
  final int umur;

  final String universitas;
  final String programStudi;
  final int npm;
  final int tahunMasuk;

  final List<Hobi> hobi;
}

class Hobi {
  const Hobi({
    required this.id,
    required this.nama,
    this.icon = Icons.star_border_outlined,
  });
  final String id;
  final String nama;
  final IconData icon;
}
