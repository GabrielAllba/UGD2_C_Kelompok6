import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatelessWidget {
  const GenerateQRPage({super.key, required this.qrData});
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('QR Generate'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: 6,
          padding: const EdgeInsets.all(50),
        ),
      ),
    );
  }
}
