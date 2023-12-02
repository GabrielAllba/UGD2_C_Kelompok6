import 'package:ugd2_c_kelompok6/entity/User.dart';

import 'dart:convert';
import 'package:http/http.dart';

class AuthClient {
  static final String url = '10.0.2.2:8000';
  static final String endpointregister = '/api/register';
  static final String endpointlogin = '/api/login';
  static final String endpointuser = '/api/user';

  // hp
  // static final String url = 'ipaddress cmd';
  // static final String endpoint = '/GD_API_1150/public/api/User';

  static Future<Response> register(User user) async {
    try {
      var response = await post(
        Uri.http(url, endpointregister),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      print(response.body);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user) async {
    try {
      var response = await put(
        Uri.http(url, '$endpointuser/${user.id}'),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> login(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password
      }; // Fix the password key
      var response = await post(
        Uri.http(url, endpointlogin),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// Only for testing purpose
  Future<Response> loginTesting(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password
      }; // Fix the password key
      var response = await post(Uri.http(url, endpointlogin),
          headers: {"Accept": "application/json"}, body: data);

      print(response.body);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(int id) async {
    try {
      var response = await get(Uri.http(url, '$endpointuser/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
