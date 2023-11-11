import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/components/pdf/button_pdf.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart' as usersql;
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/editTanggal_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd2_c_kelompok6/screens/generate_qr/generate_qr_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Pemesanan extends StatefulWidget {
  const Pemesanan({Key? key});

  @override
  State<Pemesanan> createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  List<Map<String, dynamic>> pemesananData = [];
  int? id_user;

  void refresh() async {
    final data = await SQLHelper.getPemesanan();
    setState(() {
      pemesananData = data;
    });
  }

  void filterSearch(String query, int id_user) async {
    final data = await SQLHelper.getPemesananByQuery(query, id_user);
    setState(() {
      pemesananData = data;
    });
    print(pemesananData);
  }

  @override
  void initState() {
    super.initState();
    setIdUserFromSP();
    loadData();
  }

  void setIdUserFromSP() async {
    int id = await getUserIdFromSharedPreferences();

    setState(() {
      id_user = id;
    });
  }

  String username = '';
  String notelp = '';
  String email = '';
  String id = '';

  Future<void> loadData() async {
    Map<String, dynamic> userDetails =
        await getUserDetailsFromSharedPreferences();

    int idUser = await getUserIdFromSharedPreferences();
    List<Map<String, dynamic>> pemesanan =
        await SQLHelper.getPemesananViaUser(idUser);

    setState(() {
      pemesananData = pemesanan;
      username = userDetails['username'] ?? '';
      notelp = userDetails['notelp'] ?? '';
      email = userDetails['email'] ?? '';
    });
  }

  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
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
          automaticallyImplyLeading: false,
          title: Center(
            child: const Text(
              'Daftar Pemesanan',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: "Nama Hotel yang di pesan",
                        prefixIcon: Icon(Icons.bed_outlined),
                      ),
                      onChanged: (e) => {
                        filterSearch(
                          searchController.text,
                          id_user!,
                        ),
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
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
                                  tanggal_checkout:
                                      pemesanan['tanggal_checkout'],
                                  tipe_kamar: pemesanan['tipe_kamar'],
                                  harga: pemesanan['harga'],
                                  harga_dasar: pemesanan['harga_dasar'],
                                ),
                              )).then((_) => refresh());
                        },
                      ),
                      IconSlideAction(
                        caption: 'Batalkan',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          await deleteKamar(pemesananData[index]['id']);
                          loadData();
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
                                        color:
                                            Color.fromARGB(255, 198, 76, 127),
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
                                        color:
                                            Color.fromARGB(255, 77, 198, 135),
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
                                        color:
                                            Color.fromARGB(255, 82, 158, 224),
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
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GenerateQRPage(
                                          qrData: pemesanan['qr_code']),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                child: const Text(
                                  "Tunjukan QR",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              ButtonPdf(
                                tipe: pemesanan['tipe_kamar'],
                                checkin: pemesanan['tanggal_checkin'],
                                checkout: pemesanan['tanggal_checkout'],
                                harga_dasar: pemesanan['harga_dasar'],
                                harga: pemesanan['harga'],
                                username: username,
                                email: email,
                                no_telpon: notelp,
                                id: pemesanan['id'].toString(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<int> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    return userId!;
  }

  Future<String> getUsernameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username!;
  }

  Future<void> deleteKamar(int id) async {
    await SQLHelper.deletePemesanan(id);
    refresh();
  }

  Future<Map<String, dynamic>> getUserDetailsFromSharedPreferences() async {
    int userId = await getUserIdFromSharedPreferences();
    Map<String, dynamic> user = await usersql.SQLHelper.getUserById(userId);

    String username = user['username'] ?? '';
    String notelp = user['notelp'] ?? '';
    String email = user['email'] ?? '';

    return {
      'username': username,
      'notelp': notelp,
      'email': email,
    };
  }
}
