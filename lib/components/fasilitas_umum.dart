import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/data/fasilitas_umum.dart';

class Fasilitas extends StatefulWidget {
  const Fasilitas({super.key});

  @override
  State<Fasilitas> createState() => FasilitasState();
}

class FasilitasState extends State<Fasilitas> {
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
                crossAxisCount: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                fasilitasUmum[index].icon,
                                size: 24,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                fasilitasUmum[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: fasilitasUmum.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
