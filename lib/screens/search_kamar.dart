import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/data/tipe_kamar.dart';
import 'package:ugd2_c_kelompok6/screens/detail_tipe_kamar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchKamar extends StatelessWidget {
  SearchKamar({Key? key, required this.checkin, required this.checkout})
      : super(key: key);

  String checkin;
  String checkout;

  @override
  Widget build(BuildContext context) {
    DateTime checkinDate = DateTime.parse(checkin);
    DateTime checkoutDate = DateTime.parse(checkout);

    Duration difference = checkoutDate.difference(checkinDate);
    int numberOfDays = difference.inDays;

    return ResponsiveSizer(builder: (context, orientation, screenType) {
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
          title: const Text(
            'Pilihan Kamar',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: tipeKamar.length, // Use the tipeKamar variable here
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTipeKamar(
                      tipeKamar: tipeKamar[index],
                      checkin: checkin,
                      checkout: checkout,
                      harga_dasar: tipeKamar[index].harga,
                      harga: tipeKamar[index].harga * numberOfDays,
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
                      tipeKamar[index].thumbnail,
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
                            tipeKamar[index].nama,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp. ${tipeKamar[index].harga} / malam',
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
    });
  }
}
