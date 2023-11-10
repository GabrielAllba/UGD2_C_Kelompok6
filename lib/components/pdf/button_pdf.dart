import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/components/pdf/pdf_view.dart';

class ButtonPdf extends StatefulWidget {
  final String tipe;
  final String checkin;
  final String checkout;
  final int harga_dasar;
  final int harga;

  final String username;
  final String email;
  final String no_telpon;

  const ButtonPdf({
    Key? key,
    required this.tipe,
    required this.checkin,
    required this.checkout,
    required this.harga_dasar,
    required this.harga,
    required this.username,
    required this.email,
    required this.no_telpon,
  }) : super(key: key);

  @override
  State<ButtonPdf> createState() => _ButtonPdfState();
}

class _ButtonPdfState extends State<ButtonPdf> {
  String id = const Uuid().v1();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 2.h),
      child: ElevatedButton(
        onPressed: () {
          createPdf(
            widget.tipe,
            widget.checkin,
            widget.checkout,
            widget.harga_dasar.toString(),
            widget.harga.toString(),
            widget.username,
            widget.email,
            widget.no_telpon,
            context,
          );
          setState(() {
            const uuid = Uuid();
            id = uuid.v1();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            // fontSize: 15.sp,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }
}
