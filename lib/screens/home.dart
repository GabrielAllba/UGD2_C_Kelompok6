import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/components/fasilitas_umum.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/screens/hasilCariNamaKamar.dart';
import 'package:ugd2_c_kelompok6/screens/search_kamar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _checkin = '';
  String _checkout = '';

  TextEditingController checkinInput = TextEditingController();
  TextEditingController checkoutInput = TextEditingController();

  @override
  void initState() {
    checkinInput.text = "";
    checkoutInput.text = "";
    super.initState();
  }

  void reset() {
    checkinInput.text = "";
    checkoutInput.text = "";
    setState(() {
      _checkin = '';
      _checkout = '';
    });
  }

  void onTapCheckin() async {
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _checkin = formattedDate;
        checkinInput.text = formattedDate;
        print('checkin');
        print(_checkin);
        print(checkinInput.text);
      });
    }
  }

  void onTapCheckout() async {
    DateTime dateTime = DateTime.parse(_checkin);

    DateTime tomorrow = dateTime.add(Duration(days: 1));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _checkout = formattedDate;
        checkoutInput.text = formattedDate;
        print('checkout');
        print(_checkout);
        print(checkoutInput.text);
      });
    }
  }

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Image.asset(
                  'images/background.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(235, 42, 124, 255),
                        Color.fromARGB(235, 64, 223, 238),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hotel Sahid Raya Yogyakarta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Top 1 Hotel di Indonesia!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lihat kamar!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Nama Kamar",
                      prefixIcon: Icon(Icons.bed_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HasilCariNamaKamar(
                                query: searchController.text,
                              ),
                            ), // Navigasi ke SearchKamar
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: const Text(
                          "Cari",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yuk Check In!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: ElevatedCard(
              content: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: checkinInput,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Tanggal Checkin",
                      ),
                      readOnly: true,
                      onTap: onTapCheckin,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      enabled:
                          _checkin.isEmpty || _checkin == '' ? false : true,
                      controller: checkoutInput,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Tanggal Checkout",
                      ),
                      readOnly: true,
                      onTap: onTapCheckout,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: reset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: _checkin == '' && _checkout == ''
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchKamar(
                                        checkin: checkinInput.text,
                                        checkout: checkoutInput.text,
                                      ),
                                    ), // Navigasi ke SearchKamar
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: const Text(
                            'Cari',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fasilitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Fasilitas(),
        ],
      ),
    );
  }
}
