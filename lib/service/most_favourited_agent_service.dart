import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/most_favourited_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<MostFavouritedModel>> getFavouriteAgentList(String? favouritedBy) async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response =
      await http.get(Uri.parse("$baseUrl/agent/$favouritedBy"), headers: {
    "Authorization": "$token",
  });
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List houseData = jsonResponse['data']['agents'];

    return houseData.map((e) => MostFavouritedModel.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
