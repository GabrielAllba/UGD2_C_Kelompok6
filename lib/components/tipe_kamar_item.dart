import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';

class TipeKamarItem extends StatelessWidget {
  const TipeKamarItem({
    super.key,
    required this.tipeKamar,
    required this.onSelectTipeKamar,
  });

  final TipeKamar tipeKamar;

  final void Function() onSelectTipeKamar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectTipeKamar,
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: FractionallySizedBox(
          heightFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                tipeKamar.thumbnail,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tipeKamar.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp. ${tipeKamar.harga} / malam',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 113, 113, 113),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
