import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';

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
          ],
        ),
      ),
    );
  }
}
