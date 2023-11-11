import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd2_c_kelompok6/constant/app_constant.dart';
import 'package:ugd2_c_kelompok6/database/search_history/sql_helper.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart'
    as pemesananSqlHelper;
import 'package:ugd2_c_kelompok6/screens/qr_scan/scanner_error_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({super.key});

  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;
  bool isDefine = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [cameraView(), Container()],
      ),
    );
  }

  Widget cameraView() {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){

        return Builder(builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                startDelay: true,
                controller: MobileScannerController(torchEnabled: false),
                fit: BoxFit.contain,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                onDetect: (capture) => setBarcodeCapture(capture),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 50,
                          child: FittedBox(
                            child: GestureDetector(
                                onTap: () => getURLResult(),
                                child: barcodeCaptureTextResult(context)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      }
    );
  }

  Text barcodeCaptureTextResult(BuildContext context) {
    return Text(
      barcodeCapture?.barcodes.first.rawValue ??
          LabelTextConstant.scanQrPlaceHolderLabel,
      overflow: TextOverflow.fade,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) async {
    bool isExist = await pemesananSqlHelper.SQLHelper.isQRCodeExistsForUser(
        capture.barcodes.first.rawValue!);
    if (isExist) {
      setState(() {
        barcodeCapture = capture;
      });
    } else {
      copyToClipboard('invalidddd', false);
    }
  }

  void getURLResult() {
    final qrCode = barcodeCapture?.barcodes.first.rawValue;
    if (qrCode != null) {
      copyToClipboard(qrCode, true);
    }
  }

  void copyToClipboard(String text, bool value) {
    if (value) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(LabelTextConstant.txtonCopyingClipBoard),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid QR Code'),
        ),
      );
    }
  }
}
