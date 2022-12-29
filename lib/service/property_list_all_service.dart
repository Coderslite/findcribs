import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:http/http.dart' as http;
Future<List<HouseListModel>> getAllPropertyList() async {
  // var prefs = await SharedPreferences.getInstance();
  final response = await http.get(
    Uri.parse("$baseUrl/listing?status=Active"),
  );
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List houseData = jsonResponse['data']['listing'];
    // print(houseData);
    // prefs.setString('propertyList', jsonEncode(jsonResponse));

    return houseData.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    // var houseList = prefs.getString('propertyList');
    // var jsonResponse = jsonDecode(houseList!);
    // List houseData = jsonResponse['data']['listing'];
    // return houseData.map((e) => HouseListModel.fromJson(e)).toList();
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
