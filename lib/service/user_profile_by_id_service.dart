// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<UserProfile> getUserProfileById(int? id) async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response = await http.get(
    Uri.parse(
      "$baseUrl/profile/$id",
    ),
    headers: {
      "Authorization": "$token",
    },
  );
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    // print(responseData['data']);
    return UserProfile.fromJson(responseData['data']['profile']);
  } else {
    print(response.reasonPhrase);
    throw Exception(response.statusCode);
  }
}
