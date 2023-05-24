// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

List<JobsModel> jobsModelFromJson(String str) => List<JobsModel>.from(json.decode(str).map((x) => JobsModel.fromJson(x)));

String jobsModelToJson(List<JobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsModel {
    JobsModel({
        required this.id,
        required this.postedBy,
        required this.applicants,
        required this.jobName,
        required this.jobDescription,
        required this.datePosted,
        required this.expired,
        required this.applicationMethod,
        required this.trending,
        required this.verified,
    });

    int id;
    PostedBy postedBy;
    List<PostedBy> applicants;
    String jobName;
    String jobDescription;
    String? applicationMethod;
    DateTime datePosted;
    bool expired;
    bool verified;
    bool trending;

    factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
        verified:json["verified"],
        applicationMethod: json["application_method"],
        id: json["id"],
        postedBy: PostedBy.fromJson(json["posted_by"]),
        applicants: List<PostedBy>.from(json["applicants"].map((x) => PostedBy.fromJson(x))),
        jobName: json["job_name"],
        jobDescription: json["job_description"],
        datePosted: DateTime.parse(json["date_posted"]),
        expired: json["expired"],
        trending: json["trending"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "posted_by": postedBy.toJson(),
        "applicants": List<dynamic>.from(applicants.map((x) => x.toJson())),
        "job_name": jobName,
        "job_description": jobDescription,
        "date_posted": datePosted.toIso8601String(),
        "expired": expired,
        "trending": trending,
        "application_method":applicationMethod,
        "verified":verified
    };
}

class PostedBy {
    PostedBy({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
    });

    int id;
    String firstName;
    String lastName;
    String email;
    String phone;

    factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"]!,
        email: json["email"]!,
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
    };
}





