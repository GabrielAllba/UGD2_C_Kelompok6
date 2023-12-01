import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';
import 'package:ugd2_c_kelompok6/components/pdf/button_pdf.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:ugd2_c_kelompok6/database/user/sql_helper.dart' as usersql;
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/editTanggal_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd2_c_kelompok6/screens/generate_qr/generate_qr_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd2_c_kelompok6/tabs.dart';
import 'package:uuid/uuid.dart';
import 'package:ugd2_c_kelompok6/entity/Pemesanan.dart' as PemesananModel;

class Pemesanan extends StatefulWidget {
  const Pemesanan({super.key, required this.id_user});

  final int id_user;

  @override
  State<Pemesanan> createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  List<PemesananModel.Pemesanan> pemesananData = [];
  String id_pemesanan = const Uuid().v1();
  bool isLoading = false;

  void refresh() async {
    loadData();
  }

  void filterSearch(String query, int id_user) async {
    List<PemesananModel.Pemesanan> res =
        await PemesananClient.findByUser(id_user);
    setState(
      () {
        pemesananData = res;
      },
    );
    print(pemesananData);
  }

  @override
  void initState() {
    super.initState();
    setIdUserFromSP();
    loadData();
    print('adsfsdafadsfdf');
    print(widget.id_user);
  }

  void setIdUserFromSP() async {
    setState(() {
      const uuid = Uuid();
      id_pemesanan = uuid.v1();
    });
  }

  String username = '';
  String notelp = '';
  String email = '';
  String id = '';

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<PemesananModel.Pemesanan> res =
          await PemesananClient.findByUser(widget.id_user);
      setState(
        () {
          isLoading = false;
          pemesananData = res;
        },
      );
    } catch (err) {
      print(err);
    }
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
                          widget.id_user,
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
                  PemesananModel.Pemesanan pemesanan = pemesananData[index];

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
                                title: 'Ubah Tanggal',
                                id: pemesanan.id,
                                id_user: widget.id_user,
                                tanggal_checkin: pemesanan.tanggal_checkin,
                                tanggal_checkout: pemesanan.tanggal_checkout,
                                tipe_kamar: pemesanan.tipe_kamar,
                                harga: pemesanan.harga,
                                harga_dasar: pemesanan.harga_dasar,
                                qr_code: pemesanan.qr_code,
                              ),
                            ),
                          );
                        },
                      ),
                      IconSlideAction(
                        caption: 'Batalkan',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          setState(
                            () {
                              isLoading = true;
                            },
                          );
                          await deletePemesanan(pemesananData[index].id!);
                          setState(
                            () {
                              isLoading = false;
                            },
                          );
                          loadData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabsScreen(),
                            ),
                          );
                        },
                      )
                    ],
                    child: ListTile(
                      title: Text(
                        pemesanan.tipe_kamar,
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
                                      pemesanan.tanggal_checkin,
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
                                      pemesanan.tanggal_checkout,
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
                                      'Rp. ' + pemesanan.harga.toString(),
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
                                          qrData: pemesanan.qr_code),
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
                                tipe: pemesanan.tipe_kamar,
                                checkin: pemesanan.tanggal_checkin,
                                checkout: pemesanan.tanggal_checkout,
                                harga_dasar: pemesanan.harga_dasar,
                                harga: pemesanan.harga,
                                username: username,
                                email: email,
                                no_telpon: notelp,
                                id_pemesanan: pemesanan.id.toString(),
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

  Future<void> deletePemesanan(int id) async {
    try {
      await PemesananClient.destroy(id);
    } catch (err) {
      print(err);
    }
    refresh();
  }
}
