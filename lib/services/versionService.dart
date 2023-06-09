import '../models/versionModel.dart';
import '../config/urls.dart';
import "package:http/http.dart" as http;


class VersionService{

  Future<VersionModel> getUpdates() async{
    var response = await http.get(Uri.parse("${BaseUrls().baseUrl}updates"));
    // print(response.body);
    return versionModelFromJson(response.body);
  }
}