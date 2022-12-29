import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/house_list_model.dart';

Future<List<HouseListModel>> getSearchedProperty(
    String state, String area, String search, int page) async {
  var response = await http.get(Uri.parse(
      "http://18.233.168.44:5000/user/search-listing?state=$state&area=$area&search=$search&page=$page&size=4"));
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List house = responseData['data']['listing'];
    return house.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
