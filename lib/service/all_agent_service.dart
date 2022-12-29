// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/unfavourite_agent.dart';
// import '../models/unfavourited_agent_model.dart';

Future<List<UserUnFavouritedAgentModel>> getAllAgentList() async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response =
      await http.get(Uri.parse("$baseUrl/agent/by-favorited/all"), headers: {
    "Authorization": "$token",
  });
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List unfavouritedAgentList = jsonResponse['data']['agents'];

    return unfavouritedAgentList
        .map((e) => UserUnFavouritedAgentModel.fromJson(e))
        .toList();
  } else {

    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}
