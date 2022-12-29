import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:http/http.dart' as http;

Future<List<HouseListModel>> getPropertyListCategory(String category,int page) async {
  final response = await http.get(
    Uri.parse("$baseUrl/listing/get-listing-by-category/$category?page=$page&size=10"),
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
