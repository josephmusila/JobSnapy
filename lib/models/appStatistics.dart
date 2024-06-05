// To parse this JSON data, do
//
//     final appStats = appStatsFromJson(jsonString);

import 'dart:convert';

AppStats appStatsFromJson(String str) => AppStats.fromJson(json.decode(str));

String appStatsToJson(AppStats data) => json.encode(data.toJson());

class AppStats {
  Statistics statistics;
  int userCount;
  int jobsCount;

  AppStats({
    required this.statistics,
    required this.userCount,
    required this.jobsCount,
  });

  factory AppStats.fromJson(Map<String, dynamic> json) => AppStats(
    statistics: Statistics.fromJson(json["statistics"]),
    userCount: json["userCount"],
    jobsCount: json["jobsCount"],
  );

  Map<String, dynamic> toJson() => {
    "statistics": statistics.toJson(),
    "userCount": userCount,
    "jobsCount": jobsCount,
  };
}

class Statistics {
  int id;
  DateTime date;
  int appVisits;
  int downloads;

  Statistics({
    required this.id,
    required this.date,
    required this.appVisits,
    required this.downloads,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    appVisits: json["app_visits"],
    downloads: json["downloads"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "app_visits": appVisits,
    "downloads": downloads,
  };
}
