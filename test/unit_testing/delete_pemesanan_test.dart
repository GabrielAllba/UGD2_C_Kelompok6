import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/client/PemesananClient.dart';

void main() {
  test('Delete pemesanan successful', () async {
    final resp = await PemesananClient.fetchAllTesting();
    expect(resp.length, 1);

    final pemesanan = resp[0];

    final resp2 = await PemesananClient.destroyTesting(pemesanan.id);
    expect(resp2.statusCode, 200);
  });
}
