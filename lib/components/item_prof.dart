import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/database/pemesanan/sql_helper.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';
import 'package:ugd2_c_kelompok6/screens/editProfile.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ugd2_c_kelompok6/screens/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

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

  int? idUser;
  Key imageKey = UniqueKey();
  Uint8List? imageFile;
  final imagePicker = ImagePicker();

  void loadData() async {
    setState(() {
      isLoading = true;

     
    });

    

    Future<void> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('id')!;
    });
  }

    try {
      User res = await AuthClient.find(widget.id);
      setState(() {
        isLoading = false;
        usernameController.value = TextEditingValue(text: res.username);
        emailController.value = TextEditingValue(text: res.email);
        tanggalLahirController.value = TextEditingValue(text: res.tgl_lahir);
        nomorTeleponController.value = TextEditingValue(text: res.no_telp);
        
        ambilData();
        getIdUser();
        

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
        : Scaffold(
          appBar: AppBar(
          title: const Text('Profile User'), // Judul AppBar
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    id: idUser!,
                  ),
                ),
              );
            },
          ),
        ),


        body: Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [

                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Action on CircleAvatar Tap'),
                                  content: Text('You tapped the avatar!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        getFromGallery();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ambil Dari galery'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        getFromCamera();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ambil Dari kamera'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      Text(
                        usernameController.text,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(emailController.text),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    id: widget.id,
                                  ),
                                ),
                              );
                            },
                            heroTag: 'Edit',
                            elevation: 0,
                            label: const Text("Edit"),
                            icon: const Icon(Icons.edit_outlined),
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
                                Text(tanggalLahirController.text),
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
                                Text(nomorTeleponController.text),
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
          ),
        );
  }

   Future<void> ambilData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      usernameController.text = pref.getString('username') ?? '';
    });

    final isiData = await _getData();
    if (isiData != null) {
      usernameController.text = isiData['username'] ?? '';
      emailController.text = isiData['email'] ?? '';
      tanggalLahirController.text = isiData['tgl_lahir']??'';
      nomorTeleponController.text = isiData['no_telp']??'';
      imageFile = isiData['gambar'] ?? Uint8List(0);
    }
   }

   Future<Map<String, dynamic>?> _getData() async {
   
  }

   getFromCamera() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
  }

  getFromGallery() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
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
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
