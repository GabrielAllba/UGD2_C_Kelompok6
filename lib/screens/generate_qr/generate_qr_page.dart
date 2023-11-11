import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenerateQRPage extends StatelessWidget {
  const GenerateQRPage({super.key, required this.qrData});
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
         Device.orientation == Orientation.portrait
        ? Container(
        width: 100.w,
        height: 20.5.h,
      )

      : Container(
        width: 100.w,
        height: 12.5.h,
      );

      Device.screenType == ScreenType.tablet
        ? Container(
      width: 100.w,
      height: 20.5.h,
      )

      : Container(
        width: 100.w,
        height: 12.5.h,
      );
      
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
    );
  }
}
