import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/editTanggal_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Pemesanan extends StatefulWidget {
  const Pemesanan({Key? key});

  @override
  State<Pemesanan> createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  List<Map<String, dynamic>> pemesananData = [];

  void refresh() async{
    final data = await SQLHelper.getPemesanan();
    setState(() {
      pemesananData = data;
    });
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    int idUser = await getUserIdFromSharedPreferences();
    List<Map<String, dynamic>> pemesanan =
        await SQLHelper.getPemesananViaUser(idUser);
    setState(() {
      pemesananData = pemesanan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Pemesanan',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: pemesananData.isEmpty
          ? Center(child: Text('No pemesanan found'))
          : ListView.builder(
              itemCount: pemesananData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> pemesanan = pemesananData[index];

                return Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Ubah Tanggal',
                      color: Colors.blue,
                      icon: Icons.update,
                      onTap: () async {
                         Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputPage(
                        title: 'Edit Tanggal',
                        id: pemesanan['id'], 
                        tanggal_checkin: pemesanan['tanggal_checkin'],
                        tanggal_checkout: pemesanan['tanggal_checkout'], 
                        ),
                    )
                         ).then((_) => refresh());
                      },
                    ),
                    IconSlideAction(
                      caption: 'Batalkan',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        await deleteKamar(pemesananData[index]['id']);
                      },
                    )
                  ],
                  child: ListTile(
                    title: Text(
                      pemesanan['tipe_kamar'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'checkin',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 198, 76, 127),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pemesanan['tanggal_checkin'],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'checkout',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 77, 198, 135),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pemesanan['tanggal_checkout'],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'harga',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 82, 158, 224),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rp. ' + pemesanan['harga'].toString(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<int> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    return userId!;
  }

  Future<void> deleteKamar(int id) async {
    await SQLHelper.deletePemesanan(id);
    refresh();
  }
}