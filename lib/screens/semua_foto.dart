import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/screens/detail_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SemuaFoto extends StatelessWidget {
  const SemuaFoto({super.key, required this.foto});

  final List<String> foto;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: const Text('Semua Foto'),
            ),
            backgroundColor: Colors.black,
            body: GridView.count(
              crossAxisCount: 2,
              children: List.generate(foto.length, (index) {
                return InkWell(
                  child: Center(
                    child: Image.asset(foto[index]),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailImage(
                        image: foto[index],
                      );
                    }));
                  },
                );
              }),
            ));
      }
    );
  }
}
