import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/story_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<StoryModel>> getUserStoryList() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var response = await http.get(
    Uri.parse("$baseUrl/moment"),
    headers: {
      "Authorization": "$token",
    },
  );
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List storyList = responseData['data'];
    return storyList.map((e) => StoryModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
