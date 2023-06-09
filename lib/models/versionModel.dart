// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
  VersionModel({
    required this.id,
    required this.version,
    required this.isActive,
    required this.details,
    required this.isForcedUpdate,
  });

  int id;
  String version;
  bool isActive;
  bool isForcedUpdate;
  String details;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
    id: json["id"],
    version: json["version"],
    details: json["details"],
    isActive: json["isActive"],
    isForcedUpdate: json["isForcedUpdate"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "version": version,
    "isActive": isActive,
    "isForcedUpdate": isForcedUpdate,
    "details":details

  };
}
