import 'dart:convert';

import '../config/urls.dart';
import "package:http/http.dart" as http;

import '../models/commentsModel.dart';
import '../models/jobsModel.dart';

class JobService {
  List<JobsModel> jobs = [];
  final getAllJobsUrl = Uri.parse("${BaseUrls().baseUrl}jobs");

  Future<List<JobsModel>> getAllJobs() async {
    try {
      var response = await http.get(getAllJobsUrl);
      jobs = jobsModelFromJson(response.body);
      return jobs;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<dynamic> postJob(
      {required String jobName,
      required String jobDescription,
        required String applicationMethod,
        required bool verified,
      required String postedBy}) async {
    try {
      var response =
          await http.post(Uri.parse("${BaseUrls().baseUrl}jobs/"), body: {
            "application_method":applicationMethod,
        "posted_by": postedBy,
        "job_name": jobName,
        "job_description": jobDescription,
            "verified":"true"
      });
      if(response.statusCode == 200){
        getAllJobs();
        return response.statusCode;
      }else{
        return response.statusCode;
      }

    }  catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteJob({required String id,required String user}) async{
    var response = await http.delete(Uri.parse("${BaseUrls().baseUrl}deletejob/$id"),body: {"user":user});
    getAllJobs();
  }


  Future<dynamic> addComment(
      {required String comment,
      required String jobId,
      required String postedBy}) async {
    try {
      var response = await http.post(
          Uri.parse("${BaseUrls().baseUrl}add-comment/"),
          body: {"comment": comment, "job": jobId, "posted_by": postedBy});
      return response.statusCode;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CommentsModel>> getComments(String id) async {
    var response =
        await http.get(Uri.parse("${BaseUrls().baseUrl}comments/$id"));

    // print(response.body);
    return commentsModelFromJson(response.body);
  }

  Future<dynamic> applyJob(
      {required String userId, required String jobId}) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var request = http.Request(
          'PATCH', Uri.parse('${BaseUrls().baseUrl}applications/$jobId'));
      request.body = json.encode({
        "applicants": {"id": userId}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print(response.reasonPhrase);
      }
    }  catch (e) {
      throw e;
    }
  }
}
