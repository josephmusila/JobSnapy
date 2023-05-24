// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

List<CommentsModel> commentsModelFromJson(String str) => List<CommentsModel>.from(json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
  CommentsModel({
    required this.id,
    required this.job,
    this.comment,
    required this.postedBy,
  });

  int id;
  int job;
  String? comment;
  PostedBy postedBy;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    id: json["id"],
    job: json["job"],
    comment: json["comment"],
    postedBy: PostedBy.fromJson(json["posted_by"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job": job,
    "comment": comment,
    "posted_by": postedBy.toJson(),
  };
}

class PostedBy {
  PostedBy({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,

  });

  String firstName;
  String lastName;
  String email;
  String phone;


  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],

  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,

  };
}
