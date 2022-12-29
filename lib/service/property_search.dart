import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:http/http.dart' as http;

Future<List<HouseListModel>> propertySearchList(String? query) async {
  List<HouseListModel> results = [];

  final response = await http.get(
    Uri.parse("$baseUrl/listing"),
  );
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    List houseData = jsonResponse['data'];

    results = houseData.map((e) => HouseListModel.fromJson(e)).toList();

    if (query != null) {
      results = results
          .where((element) =>
              element.propertyType!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
  return results;
}
