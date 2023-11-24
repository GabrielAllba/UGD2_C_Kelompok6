import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';
import 'package:ugd2_c_kelompok6/entity/Pemesanan.dart' as PemesananModel;
import 'package:ugd2_c_kelompok6/tabs.dart';

class InputPage extends StatefulWidget {
  const InputPage({
    super.key,
    required this.title,
    required this.id,
    required this.id_user,
    required this.tanggal_checkin,
    required this.tanggal_checkout,
    required this.tipe_kamar,
    required this.harga,
    required this.harga_dasar,
    required this.qr_code,
  });

  final String title, tanggal_checkin, tanggal_checkout, tipe_kamar, qr_code;
  final int harga, harga_dasar, id_user;

  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool updated = false;
  TextEditingController controllerTanggalCheckin = TextEditingController();
  TextEditingController controllerTanggalCheckout = TextEditingController();

  PemesananModel.Pemesanan pemesanan = PemesananModel.Pemesanan(
    tipe_kamar: '',
    harga_dasar: 0,
    harga: 0,
    tanggal_checkin: '2023-10-10',
    tanggal_checkout: '2023-10-12',
    qr_code: '',
  );

  @override
  void initState() {
    super.initState();
    pemesanan = PemesananModel.Pemesanan(
      tipe_kamar: widget.tipe_kamar,
      harga_dasar: widget.harga_dasar,
      harga: widget.harga,
      tanggal_checkin: widget.tanggal_checkin,
      tanggal_checkout: widget.tanggal_checkout,
      qr_code: widget.qr_code,
    );

    print(pemesanan.tanggal_checkin);
    print(pemesanan.tanggal_checkout);
  }

  @override
  Widget build(BuildContext context) {
    void setPemesanan() {
      DateTime checkinDate = DateTime.parse(controllerTanggalCheckin.text);
      DateTime checkoutDate = DateTime.parse(controllerTanggalCheckout.text);

      Duration difference = checkoutDate.difference(checkinDate);
      int numberOfDays = difference.inDays;

      setState(() {
        pemesanan = PemesananModel.Pemesanan(
          id: widget.id,
          id_user: widget.id_user,
          harga_dasar: widget.harga_dasar,
          tipe_kamar: widget.tipe_kamar,
          harga: widget.harga_dasar * numberOfDays,
          qr_code: generateQRData(widget.harga_dasar * numberOfDays),
          tanggal_checkin: controllerTanggalCheckin.text,
          tanggal_checkout: controllerTanggalCheckout.text,
        );
      });

      print(pemesanan.id);
      print(pemesanan.id_user);
      print(pemesanan.harga_dasar);
      print(pemesanan.tipe_kamar);
      print(pemesanan.harga);
      print(pemesanan.qr_code);
      print(pemesanan.tanggal_checkin);
      print(pemesanan.tanggal_checkout);
      print('====================');
    }

    Future<void> updatePemesanan() async {
      try {
        await PemesananClient.update(pemesanan);
        print('berhasil lewat');
      } catch (err) {
        Navigator.pop(context);
        print(err);
      }
    }

    return ResponsiveSizer(builder: (context, orientation, screenType) {
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

      if (widget.id != null && !updated) {
        controllerTanggalCheckin.text = widget.tanggal_checkin!;
        controllerTanggalCheckout.text = widget.tanggal_checkout!;
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Ubah Tanggal"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Tipe Kamar : ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.tipe_kamar)
              ],
            ),
            Row(
              children: [
                Text(
                  'Harga : ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Rp. ' + widget.harga.toString())
              ],
            ),
            Row(
              children: [
                Text(
                  'Harga Dasar : ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Rp. ' + widget.harga_dasar.toString())
              ],
            ),
            TextFormField(
              controller: controllerTanggalCheckin,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Tanggal Checkin",
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(
                    () {
                      updated = true;
                      controllerTanggalCheckin.text = formattedDate;
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: controllerTanggalCheckout,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Tanggal Checkout",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(controllerTanggalCheckin.text)
                      .add(Duration(days: 1)),
                  firstDate: DateTime.parse(controllerTanggalCheckin.text)
                      .add(Duration(days: 1)),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  setState(() {
                    updated = true;
                    controllerTanggalCheckout.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                setPemesanan();
                await updatePemesanan();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabsScreen(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  String generateQRData(int harga) {
    String reservationCode = harga.toString();
    return reservationCode;
  }
}
