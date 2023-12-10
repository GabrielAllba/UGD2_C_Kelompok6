import 'dart:convert';

class Review {
  int? id;
  int? id_user;
  String nama_kamar;
  String review;
  String tanggal;

  Review({
    this.id,
    this.id_user,
    required this.nama_kamar,
    required this.review,
    required this.tanggal,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        id_user: json["id_user"],
        nama_kamar: json["nama_kamar"],
        review: json["review"],
        tanggal: json["tanggal"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "review": review,
        "nama_kamar": nama_kamar,
        "tanggal": tanggal,
      };
}
