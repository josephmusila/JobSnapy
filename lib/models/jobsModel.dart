// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

List<JobsModel> jobsModelFromJson(String str) => List<JobsModel>.from(json.decode(str).map((x) => JobsModel.fromJson(x)));

String jobsModelToJson(List<JobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsModel {
    int id;
    PostedBy postedBy;
    List<PostedBy> applicants;
    String jobName;
    String jobDescription;
    dynamic qualification;
    String applicationMethod;
    DateTime datePosted;
    bool isImage;
    bool expired;
    bool verified;
    bool trending;
    dynamic poster;

    JobsModel({

        required this.id,
        required this.postedBy,
        required this.applicants,
        required this.jobName,
        required this.jobDescription,
        required this.applicationMethod,
        required this.datePosted,
        required this.isImage,
        required this.expired,
        required this.verified,
        required this.trending,
        this.qualification,
        this.poster,
    });

    factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
        id: json["id"],
        postedBy: PostedBy.fromJson(json["posted_by"]),
        applicants: List<PostedBy>.from(json["applicants"].map((x) => PostedBy.fromJson(x))),
        jobName: json["job_name"],
        jobDescription: json["job_description"],
        applicationMethod: json["application_method"],
        datePosted: DateTime.parse(json["date_posted"]),
        isImage: json["isImage"],
        expired: json["expired"],
        verified: json["verified"],
        trending: json["trending"],
        poster: json["poster"],
        qualification: json["qualifications"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "posted_by": postedBy.toJson(),
        "applicants": List<dynamic>.from(applicants.map((x) => x.toJson())),
        "job_name": jobName,
        "job_description": jobDescription,
        "application_method": applicationMethod,
        "date_posted": datePosted.toIso8601String(),
        "isImage": isImage,
        "expired": expired,
        "verified": verified,
        "trending": trending,
        "poster": poster,
        "qualifications":qualification
    };
}

class PostedBy {
    int id;
    String firstName;
    String lastName;
    String email;
    String phone;

    PostedBy({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
    });

    factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
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
