import 'dart:convert';

class Pemesanan{

  int? id_user;
  String tipe_kamar;
  int harga_dasar;
  int harga;
  String tanggal_checkin;
  String tanggal_checkout;
  String qr_code;

  Pemesanan(
    { 
    this.id_user,
    required this.tipe_kamar,
    required this.harga_dasar,
    required this.harga,
    required this.tanggal_checkin,
    required this.tanggal_checkout,
    required this.qr_code}
  );

  factory Pemesanan.fromRawJson(String str) => Pemesanan.fromJson(json.decode(str));
  factory Pemesanan.fromJson(Map<String, dynamic> json) =>Pemesanan(
    id_user:json["id_user"],
    tipe_kamar: json["tipe_kamar"],
    harga_dasar: json["harga_dasar"],
    harga: json["harga"],
    tanggal_checkin: json["tanggal_checkin"],
    tanggal_checkout: json["tanggal_checkout"],
    qr_code: json["qr_code"],);

    String toRawJson() => json.encode(toJson());
    Map<String, dynamic> toJson() => {
      "id_user":id_user,
      "tipe_kamar" : tipe_kamar,
      "harga_dasar" : harga_dasar,
      "harga" :harga,
      "tanggal_checkin" : tanggal_checkin,
      "tanggal_checkout" : tanggal_checkout,
      "qr_code" : qr_code,
    };
}