import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/story_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<StoryListModel>> getAllStoryList() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var response = await http.get(
    Uri.parse("$baseUrl/moment/friends"),
    headers: {
      "Authorization": "$token",
    },
  );
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List storyList = responseData['data']['moment'];
    return storyList.map((e) => StoryListModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
