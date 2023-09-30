import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';

class ListDetail extends StatelessWidget {
  const ListDetail({super.key, required this.title, required this.fasilitas});

  final List<Fasilitas> fasilitas;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (final item in fasilitas)
                Column(
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
                                  item.icon,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (item.nama),
                                  ),
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
            ],
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
