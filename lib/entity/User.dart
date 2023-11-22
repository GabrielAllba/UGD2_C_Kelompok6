import 'dart:convert';
import 'dart:typed_data';

class User {
  int? id;
  String username;
  String? password;
  String email;
  String no_telp;
  String tgl_lahir;

  User({
    this.id,
    required this.username,
    this.password,
    required this.email,
    required this.no_telp,
    required this.tgl_lahir,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        no_telp: json['no_telp'],
        tgl_lahir: json['tgl_lahir'],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "no_telp": no_telp,
        "tgl_lahir": tgl_lahir,
      };
}
