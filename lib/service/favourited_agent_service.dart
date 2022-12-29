import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/user_favourite_agent.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<UserFavouriteAgentModel>> getMyFavouriteAgentList() async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response =
      await http.get(Uri.parse("$baseUrl/friend/friend-by-user"), headers: {
    "Authorization": "$token",
  });
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List agentDataList = jsonResponse['data'];

    return agentDataList.map((e) => UserFavouriteAgentModel.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
