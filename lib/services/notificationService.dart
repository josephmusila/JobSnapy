
import "package:http/http.dart" as http;

import '../config/urls.dart';
import '../models/notificationsModel.dart';

class NotificationService{
  final getNotificationsUrl = Uri.parse("${BaseUrls().baseUrl}notifications");
  List<List<NotificationsModel>> notifications=[];

  Future<List<NotificationsModel>> getNotifications() async {
    var response =
    await http.get(getNotificationsUrl);
    // print(response.statusCode);
    return notificationsModelFromJson(response.body);
  }
}