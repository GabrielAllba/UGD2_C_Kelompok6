import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';

class ItemProfile extends StatefulWidget {
  const ItemProfile({super.key, required this.id});

  final int id;

  @override
  State<ItemProfile> createState() => _ItemProfileState();
}

class _ItemProfileState extends State<ItemProfile> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final nomorTeleponController = TextEditingController();

  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User res = await AuthClient.find(widget.id);
      setState(() {
        isLoading = false;
        usernameController.value = TextEditingValue(text: res.username);
        emailController.value = TextEditingValue(text: res.email);
        tanggalLahirController.value = TextEditingValue(text: res.tgl_lahir);
        nomorTeleponController.value = TextEditingValue(text: res.no_telp);
      });
    } catch (err) {
      // showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        usernameController.text,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('riel@gmail.com'),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'Edit',
                            elevation: 0,
                            label: const Text("Edit"),
                            icon: const Icon(Icons.edit_outlined),
                          ),
                          const SizedBox(width: 16.0),
                          FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'Logout',
                            elevation: 0,
                            backgroundColor: Colors.red,
                            label: const Text("Logout"),
                            icon: const Icon(Icons.logout_outlined),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tanggal Lahir : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('18 April 2023'),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Nomor Telepon : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('08773657978'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Container(
                //   decoration: const BoxDecoration(
                //     color: Colors.black,
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //         fit: BoxFit.cover,
                //         image: NetworkImage(
                //             'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                //   ),
                // ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: CircleAvatar(
                //     radius: 20,
                //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //     child: Container(
                //       margin: const EdgeInsets.all(8.0),
                //       decoration: const BoxDecoration(
                //           color: Colors.green, shape: BoxShape.circle),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
