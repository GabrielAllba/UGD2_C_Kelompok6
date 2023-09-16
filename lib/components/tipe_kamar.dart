import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/tipe_kamar_item.dart';
import 'package:ugd2_c_kelompok6/data/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart' as roomType;
import 'package:ugd2_c_kelompok6/screens/detail_tipe_kamar.dart';

class TipeKamar extends StatelessWidget {
  const TipeKamar({super.key});

  void selectTipeKamar(BuildContext context, roomType.TipeKamar tipeKamar) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailTipeKamar(tipeKamar: tipeKamar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GridTile(
                    child: Material(
                      elevation: 4,
                      child: TipeKamarItem(
                        tipeKamar: tipeKamar[index],
                        onSelectTipeKamar: () {
                          selectTipeKamar(context, tipeKamar[index]);
                        },
                      ),
                    ),
                  );
                },
                childCount: tipeKamar.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
