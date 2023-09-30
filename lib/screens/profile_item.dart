import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/models/kelompok.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.orang});

  final Orang orang;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: coverImage(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: profileImage(),
            ),
            Positioned(
              top: 280,
              child: Container(
                child: ElevatedCard(
                  content: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Icons.school_outlined,
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orang.universitas,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Universitas',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Icons.computer_outlined,
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orang.programStudi,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Program Studi',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${orang.tahunMasuk}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Angkatan',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Icons.numbers_outlined,
                                    color: Color.fromARGB(255, 42, 124, 255),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${orang.npm}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'NPM',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Halo, berikut adalah hobi saya!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridTile(
                      child: Material(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        shadowColor: Colors.black.withOpacity(0.4),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                orang.hobi[index].icon,
                                color: Theme.of(context).colorScheme.primary,
                                size: 48,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                orang.hobi[index].nama,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: orang.hobi.length,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget coverImage() => Container(
      color: Colors.grey,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 42, 122, 255),
              Color.fromARGB(255, 64, 224, 238),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));

  Widget profileImage() => Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(71, 255, 255, 255),
            radius: 70,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(orang.profile),
                radius: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            orang.nama,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${orang.panggilan}, ${orang.umur}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            orang.email,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      );
}
