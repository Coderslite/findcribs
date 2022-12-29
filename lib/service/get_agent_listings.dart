import 'dart:convert';

import 'package:findcribs/models/house_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';

Future<List<HouseListModel>> getAgentListings(int id) async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  var response =
      await http.get(Uri.parse("$baseUrl/listing?user=$id"), headers: {
    "Authorization": "$token",
  });

  var responseData = jsonDecode(response.body);

  if (responseData['status'] == true) {
    List houseList = responseData['data']['listing'];
    return houseList.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
