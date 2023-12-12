import 'package:ugd2_c_kelompok6/entity/Pemesanan.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:ugd2_c_kelompok6/entity/Feedback.dart';

class FeedbackClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/feedback';

  static Future<List<Feedback>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Feedback.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Feedback> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Feedback.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Feedback>> findByUser(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/user/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Feedback.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Feedback feedback) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: feedback.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Feedback feedback) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${feedback.id}'),
          headers: {"Content-Type": "application/json"},
          body: feedback.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
