import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_c_kelompok6/client/AuthClient.dart';
import 'package:ugd2_c_kelompok6/entity/User.dart';

void main() {
  test('Register failed', () async {
    final user = User(
        username: 'billy666',
        email: 'billy666777@aol.fr',
        no_telp: '082177821792',
        tgl_lahir: '1994-05-27');

    final resp = await AuthClient.registerTesting(user);

    expect(resp.statusCode, 400);
  });

  test('Register successful', () async {
    final user = User(
        username: 'billy666',
        email: 'billy666@aol.fr',
        password: 'billy666',
        no_telp: '082177821792',
        tgl_lahir: '1994-05-27');

    final resp = await AuthClient.registerTesting(user);

    expect(resp.statusCode, 200);
  });

  test('Login failed', () async {
    final resp =
        await AuthClient().loginTesting('billy666@aol.fr', 'billy666777');

    expect(resp.statusCode, 401);
  });

  test('Login successful', () async {
    final resp = await AuthClient().loginTesting('billy666@aol.fr', 'billy666');

    expect(resp.statusCode, 200);
  });
}
