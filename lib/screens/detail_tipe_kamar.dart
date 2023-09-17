import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/list_detail.dart';
import 'package:ugd2_c_kelompok6/screens/detail_image.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/semua_foto.dart';

class DetailTipeKamar extends StatelessWidget {
  const DetailTipeKamar({super.key, required this.tipeKamar});

  final TipeKamar tipeKamar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Tipe Kamar ',
          style: const TextStyle(fontSize: 16),
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
                    tipeKamar.thumbnail,
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
            if (tipeKamar.foto.isNotEmpty) // Check if foto is not empty
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
                        if (index != 2) {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return DetailImage(
                                    image: tipeKamar.foto[index],
                                  );
                                }));
                              },
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                tipeKamar.foto[index],
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
                                    return SemuaFoto(foto: tipeKamar.foto);
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
                                    tipeKamar.foto[index],
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
                      childCount: 3,
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
                    tipeKamar.nama,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Rp. ${tipeKamar.harga} / malam',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
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
                              Text('${tipeKamar.ruangTamu} guest room')
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
                              Text('${tipeKamar.luasRuangan} sqm')
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
                              Text(tipeKamar.tipeBed)
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
                fasilitas: tipeKamar.fasilitasUtamaKamar),
            ListDetail(
              title: 'Fasilitas Tambahan',
              fasilitas: tipeKamar.fasilitasKamar,
            ),
            ListDetail(
              title: 'Fitur Lain',
              fasilitas: tipeKamar.fiturTambahan,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Deskripsi',
                textAlign: TextAlign.start,
                style: const TextStyle(
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
                    color: const Color.fromARGB(255, 217, 217,
                        217), // You can change the color to your desired color
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
                tipeKamar.deskripsi,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
