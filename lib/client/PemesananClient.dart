import 'package:ugd2_c_kelompok6/entity/Pemesanan.dart';

import 'dart:convert';
import 'package:http/http.dart';

class PemesananClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/pemesanan';

  static Future<List<Pemesanan>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Pemesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Pemesanan>> fetchAll_T() async {
    Iterable list = json.decode(
        '[{"id": 2,            "id_user": 3,  "tipe_kamar": "Super Deluxe",    "harga_dasar": 650000,   "harga": 1300000,      "tanggal_checkin": "2023-12-26",    "tanggal_checkout": "2023-12-28",      "qr_code": "1300000"     }]');

    print(list);
    return list.map((e) => Pemesanan.fromJson(e)).toList();
  }

  static Future<Pemesanan> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Pemesanan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Pemesanan>> findByUser(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/user/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print(response.body);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Pemesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Pemesanan pemesanan) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: pemesanan.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Pemesanan pemesanan) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${pemesanan.id}'),
          headers: {"Content-Type": "application/json"},
          body: pemesanan.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> isQRCodeExistsForUser(String harga) async {
    List<Pemesanan> pemesananData = await fetchAll();
    for (Pemesanan data in pemesananData) {
      final qrCode = data.qr_code;
      if (qrCode == harga) {
        return true;
      }
    }
    return false;
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      print(response.body);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
