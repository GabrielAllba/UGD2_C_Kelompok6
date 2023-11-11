import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/data/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/detail_tipe_kamar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HasilCariNamaKamar extends StatelessWidget {
  HasilCariNamaKamar({Key? key, required this.query}) : super(key: key);

  final query;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
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
      
      List<TipeKamar> filteredTipeKamar = tipeKamar
          .where((tipe) => tipe.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pilihan Kamar',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: filteredTipeKamar.isEmpty
            ? Center(
                child: Text('No data to display'),
              )
            : ListView.builder(
                itemCount:
                    filteredTipeKamar.length, // Use the tipeKamar variable here
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTipeKamar(
                            tipeKamar: filteredTipeKamar[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: Row(
                        children: [
                          Image.asset(
                            filteredTipeKamar[index].thumbnail,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredTipeKamar[index].nama,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp. ${filteredTipeKamar[index].harga} / malam',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
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
    );
  }
}
