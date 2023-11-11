import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailImage extends StatelessWidget {
  const DetailImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text('Detail Foto'),
          ),
          backgroundColor: Colors.black,
          body: GestureDetector(
            child: Center(
              child: Hero(
                tag: 'imageHero',
                child: Image.asset(image),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        );
     }
    );
  }
}
