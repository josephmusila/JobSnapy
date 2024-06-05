import 'dart:convert';

import 'package:http/http.dart' as http;


import '../config/urls.dart';
import '../models/appStatistics.dart';


class AppStatsService{

  Future<AppStats> getAppStats() async{
    var response = await http.get(Uri.parse("${BaseUrls().baseUrl}statistics"));

    return appStatsFromJson(response.body);

  }

}