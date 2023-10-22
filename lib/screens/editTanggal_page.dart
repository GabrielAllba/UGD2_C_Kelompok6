import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:intl/intl.dart';

class InputPage extends StatefulWidget {
  const InputPage({
    super.key,
    required this.title,
    required this.id,
    required this.tanggal_checkin,
    required this.tanggal_checkout,
  });

  final String? title, tanggal_checkin, tanggal_checkout;
  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController controllerTanggalCheckin = TextEditingController();
  TextEditingController controllerTanggalCheckout = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
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
                setState(() {
                  controllerTanggalCheckin.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                });
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
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> editTanggal(int id) async {
    String formattedTanggalCheckin = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(controllerTanggalCheckin.text));
    String formattedTanggalCheckout = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(controllerTanggalCheckout.text));
    await SQLHelper.editPemesananWithId(
        id, formattedTanggalCheckin, formattedTanggalCheckout);
  }
}