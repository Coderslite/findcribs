import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/search_agent_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<SearchAgentModel>> searchAgent(String query) async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var response =
      await http.get(Uri.parse("$baseUrl/agent/search?query=$query"), headers: {
    "authorization": "$token",
  });
  print(response.body);
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List agentsResult = responseData['data']['agents'];

    return agentsResult.map((e) => SearchAgentModel.fromJson(e)).toList();
  } else {
    throw Exception(responseData['message']);
  }
}
