import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';

void main() {
  test('Update pemesanan successful', () async {
    final resp = await PemesananClient.fetchAllTesting();
    expect(resp.length, 1);

    final pemesanan = resp[0];
    pemesanan.tipe_kamar = 'Premium';

    final resp2 = await PemesananClient.updatePemesananTesting(pemesanan);
    expect(resp2.statusCode, 200);
  });
}
