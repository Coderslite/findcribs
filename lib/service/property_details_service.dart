import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:http/http.dart' as http;

import '../models/house_list_model.dart';

Future<HouseListModel> getSingleProperty(int? id) async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";

  final response = await http
      .get(Uri.parse("$baseUrl/listing/$id"),);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    return HouseListModel.fromJson(jsonResponse['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
