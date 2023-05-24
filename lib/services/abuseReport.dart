
import 'package:http/http.dart' as http;

import '../config/urls.dart';


class AbuseReportService{
  Future<dynamic> abuseReport({required String issue}) async{
    var message = {
      "status-code":0,
      "message":""
    };
    try {
      var response = await http.post(Uri.parse("${BaseUrls().baseUrl}abuse"),body: {
        "issue":issue,
      });
      message["status-code"] = response.statusCode ;
      message["message"] = "Issue sent Succesfully";
      return message;

    } on Exception catch (e) {
      message["status-code"] = 404;
      message["message"] = e.toString();
      return message;
    }


  }

  Future<dynamic> bugReport({required String issue}) async{
    var message = {
      "status-code":0,
      "message":""
    };
    try {
      var response = await http.post(Uri.parse("${BaseUrls().baseUrl}bug"),body: {
        "bug":issue,
      });
      message["status-code"] = response.statusCode ;
      message["message"] = "Thank-you for your feedback";
      return message;

    } on Exception catch (e) {
      message["status-code"] = 404;
      message["message"] = e.toString();
      return message;
    }


  }
}