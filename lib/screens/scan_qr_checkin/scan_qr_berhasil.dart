import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isCameraPermissionGranted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-in Hotel'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQRView(context),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk menyimpan data check-in ke database atau operasi lainnya.
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Check-in Berhasil'),
                        content: Text('Anda telah berhasil melakukan check-in hotel.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Simpan Check-in'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkCameraPermission(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            return QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            );
          } else {
            return Center(
              child: Text(
                'Izin kamera diperlukan untuk menggunakan pemindai QR code.',
                textAlign: TextAlign.center,
              ),
            );
          }
        }
      },
    );
  }

  Future<bool> _checkCameraPermission() async {
    //PermissionStatus status = await Permission.camera.status;
    setState(() {
     // isCameraPermissionGranted = status.isGranted;
    });
    return isCameraPermissionGranted;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Logika ketika QR code berhasil dipindai
      print('QR Code data: ${scanData.code}');
      // Di sini Anda dapat menambahkan logika lebih lanjut sesuai kebutuhan aplikasi Anda.
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isQRCodeValid(String? qrCodeData) {
    String expectedURL =
        'https://en.m.wikipedia.org/'; // Sesuaikan dengan URL yang diharapkan
    return qrCodeData == expectedURL;
  }
}
