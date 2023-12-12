import 'dart:convert';

class Feedback {
  int? id;
  int id_user;
  String feedback;
  String? created_at;
  String? updated_at;

  Feedback({
    this.id,
    required this.id_user,
    required this.feedback,
    this.created_at,
    this.updated_at,
  });

  factory Feedback.fromRawJson(String str) =>
      Feedback.fromJson(json.decode(str));

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["id"],
        id_user: json["id_user"],
        feedback: json["feedback"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  String toRawJson() => json.encode(
        toJson(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "feedback": feedback,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
