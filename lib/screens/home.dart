import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_c_kelompok6/components/elevated_card.dart';
import 'package:ugd2_c_kelompok6/components/fasilitas_umum.dart';
import 'package:intl/intl.dart';
import 'package:ugd2_c_kelompok6/screens/hasilCariNamaKamar.dart';
import 'package:ugd2_c_kelompok6/screens/qr_scan/scan_qr_page.dart';
import 'package:ugd2_c_kelompok6/screens/search_kamar.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ugd2_c_kelompok6/database/search_history/sql_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _checkin = '';
  String _checkout = '';
  List<Map<String, dynamic>> searchHistory = [];
  bool showDropdown = false;
  String search = '';
  int? id_user;
  String strLatLong = '';
  String strAlamat = '';
  bool loading = false;

  // speech to text
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  TextEditingController checkinInput = TextEditingController();
  TextEditingController checkoutInput = TextEditingController();

  @override
  void initState() {
    checkinInput.text = "";
    checkoutInput.text = "";
    super.initState();
    _initSpeech();
    setIdUserFromSP();
    loadData('');
    _loadLocationFromSharedPreferences();
  }

  void reset() {
    checkinInput.text = "";
    checkoutInput.text = "";
    setState(() {
      _checkin = '';
      _checkout = '';
    });
  }

  //getLatLong
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }

    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        strAlamat = '${place.street}';
      });

      // Simpan data ke SharedPreferences saat data alamat diperbarui
      _saveLocationToSharedPreferences(
        '${position.latitude}, ${position.longitude}',
        strAlamat,
      );
    } else {
      setState(() {
        strAlamat = 'Tidak dapat menemukan alamat';
      });
    }
  }

  // Fungsi untuk menyimpan strLatLong dan strAlamat ke dalam SharedPreferences
  void _saveLocationToSharedPreferences(String latLong, String alamat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('latLong', latLong);
    await prefs.setString('alamat', alamat);
  }

// Fungsi untuk memuat strLatLong dan strAlamat dari SharedPreferences
  void _loadLocationFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? latLong = prefs.getString('latLong');
    String? alamat = prefs.getString('alamat');

    setState(() {
      strLatLong = latLong ?? '';
      strAlamat = alamat ?? '';
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

  // speech to text

  void _initSpeech() async {
    print('adfasdfasdf');
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      setState(() {
        _lastWords = result.recognizedWords;
        searchController.text = _lastWords;
        search = _lastWords;
      });
    }
  }

  void setIdUserFromSP() async {
    int id = await getUserIdFromSharedPreferences();

    setState(() {
      id_user = id;
    });
  }

  Future<void> loadData(String query) async {
    int idUser = await getUserIdFromSharedPreferences();
    List<Map<String, dynamic>> s =
        await SQLHelper.getSearchHistoryByUser(idUser, query);
    setState(() {
      searchHistory = s;
    });
  }

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
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  _speechToText.isListening
                      ? '$_lastWords'
                      : _speechEnabled
                          ? 'Kamu bisa search pakai microphone'
                          : 'Tidak bisa akses microphone',
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: searchController,
                            onTap: () => setState(() {
                              showDropdown = !showDropdown;
                              print(showDropdown);
                            }),
                            onChanged: (query) {
                              search = query;
                              loadData(search);
                            },
                            decoration: InputDecoration(
                              labelText: "Nama Kamar",
                              prefixIcon: Icon(Icons.bed_outlined),
                              suffixIcon: GestureDetector(
                                onTap: _speechToText.isNotListening
                                    ? _startListening
                                    : _stopListening,
                                child: Icon(_speechToText.isNotListening
                                    ? Icons.mic_off
                                    : Icons.mic),
                              ),
                            ),
                          ),
                          if (searchHistory.isNotEmpty && showDropdown)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: searchHistory
                                    .map(
                                      (item) => ListTile(
                                        title: Text(item['query']),
                                        onTap: () {
                                          setState(() {
                                            searchController.text = item['query'];
                                            showDropdown = false;
                                          });
                                        },
                                        trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              SQLHelper.deleteSearchHistory(
                                                  item['id']);
                                            });
                                            loadData('');
                                          },
                                          child: Icon(Icons.close), // Close icon
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                        ],
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
                            onPressed: () async {
                              if (search.isNotEmpty) {
                                if (await SQLHelper.isSame(id_user!, search) ==
                                    false) {
                                  SQLHelper.addSearchHistory(id_user!, search);
                                  setState(() {
                                    loadData('');
                                  });
                                  print(searchHistory);
                                }
                              }
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Yuk Check In!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 24,
                          ),
                          if (strLatLong.isNotEmpty) Text(strAlamat),
                          if (loading) Text('Mencari lokasi...'),
                        ],
                      ),
                      onTap: () async {
                        setState(() {
                          loading = true;
                          strAlamat = '';
                        });

                        Position position = await _getGeoLocationPosition();
                        getAddressFromLongLat(position);

                        setState(() {
                          loading = false;
                          strLatLong =
                              '${position.latitude}, ${position.longitude}';
                        });

                        getAddressFromLongLat(position);
                      },
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Scan Your Check-in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BarcodeScannerPageView(),
                    ),
                  );
                },
                child: Text(
                  "Scan Me",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const Fasilitas(),
            ],
          ),
        );
      }
    );
  }
}

Future<int> getUserIdFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('id');
  return userId!;
}

void showSnackBar(BuildContext context, String msg, Color bg){
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
        label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
