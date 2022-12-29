import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<NotificationModel>> getNotification(page) async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  var response = await http
      .get(Uri.parse("$baseUrl/notification?page=$page&size=10"), headers: {
    "Authorization": "$token",
  });
  var jsonResponse = jsonDecode(response.body);
  if (jsonResponse['status'] == true) {
    List notificationData = jsonResponse['data']['notifications'];

    return notificationData.map((e) => NotificationModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
