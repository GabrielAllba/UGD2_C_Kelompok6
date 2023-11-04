import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/components/list_detail.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:ugd2_c_kelompok6/screens/detail_image.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';
import 'package:ugd2_c_kelompok6/screens/semua_foto.dart';

class DetailTipeKamar extends StatefulWidget {
  DetailTipeKamar({
    Key? key,
    required this.tipeKamar,
    this.checkin,
    this.checkout,
    this.harga_dasar,
  }) : super(key: key);

  final TipeKamar tipeKamar;
  final String? checkin;
  final String? checkout;
  final int? harga_dasar;

  @override
  State<DetailTipeKamar> createState() => _DetailTipeKamarState();
}

class _DetailTipeKamarState extends State<DetailTipeKamar> {
  int? idUser;
  String? username;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Tipe Kamar',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Image.asset(
                    widget.tipeKamar.thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.6),
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hotel Sahid Raya Yogyakarta',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Top 1 Hotel di Indonesia!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.tipeKamar.foto.isNotEmpty)
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index != widget.tipeKamar.foto.length - 1) {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailImage(
                                    image: widget.tipeKamar.foto[index],
                                  );
                                }));
                              },
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                widget.tipeKamar.foto[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        } else {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) {
                                    return SemuaFoto(
                                        foto: widget.tipeKamar.foto);
                                  }),
                                );
                              },
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    widget.tipeKamar.foto[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(.7),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'See More',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      childCount: widget.tipeKamar.foto.length,
                    ),
                  ),
                ],
              )
            else
              Container(),
            const SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tipeKamar.nama,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  if (widget.checkin != null && widget.checkout != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Checkin: ${widget.checkin!}'),
                        Text('Checkout: ${widget.checkout!}'),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: 1,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 217,
                        217), // You can change the color to your desired color
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ('Guests'),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.tipeKamar.ruangTamu} guest room')
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.room_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ('Room Size'),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.tipeKamar.luasRuangan} sqm')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.bed_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ('Bed Type'),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(widget.tipeKamar.tipeBed)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                  ],
                ),
              ],
            ),
            ListDetail(
                title: 'Fasilitas Utama',
                fasilitas: widget.tipeKamar.fasilitasUtamaKamar),
            ListDetail(
              title: 'Fasilitas Tambahan',
              fasilitas: widget.tipeKamar.fasilitasKamar,
            ),
            ListDetail(
              title: 'Fitur Lain',
              fasilitas: widget.tipeKamar.fiturTambahan,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Deskripsi',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: 1,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 217, 217),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.tipeKamar.deskripsi,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.checkin != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Harga: Rp. ${widget.tipeKamar.harga}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          print('asdfasdfdsfadsf');
                          await addPemesanan();
                          Fluttertoast.showToast(
                            msg: "Berhasil Pesan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );

                          await Future.delayed(
                            Duration(seconds: 2),
                          );
                        },
                        child: const Text(
                          'Pesan Sekarang',
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Future<void> saveIdPemesanan(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id_pemesanan', id);
  }

  Future<void> addPemesanan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username');
      idUser = pref.getInt('id');
    });

    Duration difference = DateTime.parse(widget.checkout!)
        .difference(DateTime.parse(widget.checkin!));
    int selisih = difference.inDays;
    int price = selisih * widget.tipeKamar.harga;

    await SQLHelper.addPemesanan(
      idUser!,
      widget.tipeKamar.nama,
      price,
      widget.harga_dasar!,
      widget.checkin!,
      widget.checkout!,
      generateQRData(price),
    );
  }

  String generateQRData(int harga) {
    String reservationCode = harga.toString();
    return reservationCode;
  }
}
