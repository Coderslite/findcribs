import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<HouseListModel>> getActivePropertyList() async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response = await http.get(
    Uri.parse(
      "$baseUrl/listing/get-user-listing/Active",
    ),
    headers: {
      "Authorization": "$token",
    },
  );
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List houseData = jsonResponse['data']['listing'];

    return houseData.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
