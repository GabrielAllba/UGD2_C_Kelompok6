import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';
import 'package:ugd2_c_kelompok6/entity/Pemesanan.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';

void main() {
  test('Create pemesanan successful', () async {
    Response resp =
        await AuthClient().loginTesting('billy666@aol.fr', 'billy666');
    expect(resp.statusCode, 200);

    final user = User.fromJson(json.decode(resp.body)['user']);
    final pemesanan = Pemesanan(
        id_user: user.id,
        tipe_kamar: 'Super Deluxe',
        harga_dasar: 650000,
        harga: 1300000,
        tanggal_checkin: '2023-12-26',
        tanggal_checkout: '2023-12-28',
        qr_code: '1300000');

    resp = await PemesananClient.createPemesananTesting(pemesanan);
    expect(resp.statusCode, 200);
  });

  test('Fetch all pemesanan successful', () async {
    final resp = await PemesananClient.fetchAllTesting();
    expect(resp.length, 1);
  });
}
