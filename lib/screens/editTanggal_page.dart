import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';

class InputPage extends StatefulWidget {
  const InputPage(
      {super.key,
      required this.title,
      required this.id,
      required this.tanggal_checkin,
      required this.tanggal_checkout,
      required this.tipe_kamar,
      required this.harga,
      required this.harga_dasar});

  final String title, tanggal_checkin, tanggal_checkout, tipe_kamar;
  final int harga, harga_dasar;

  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool updated = false;
  TextEditingController controllerTanggalCheckin = TextEditingController();
  TextEditingController controllerTanggalCheckout = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      if (widget.id != null && !updated) {
        controllerTanggalCheckin.text = widget.tanggal_checkin!;
        controllerTanggalCheckout.text = widget.tanggal_checkout!;
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Tanggal"),
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
                await editTanggal(widget.id!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pemesanan(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  Future<void> editTanggal(int id) async {
    String formattedTanggalCheckin = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(controllerTanggalCheckin.text));
    String formattedTanggalCheckout = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(controllerTanggalCheckout.text));
    final harga = SQLHelper.getPemesananById(id);
    await SQLHelper.editPemesanan(
      id,
      widget.tipe_kamar,
      widget.harga,
      widget.harga_dasar,
      formattedTanggalCheckin,
      formattedTanggalCheckout,
      generateQRData(widget.harga),
    );
  }

  String generateQRData(int harga) {
    String reservationCode = harga.toString();
    return reservationCode;
  }
}
