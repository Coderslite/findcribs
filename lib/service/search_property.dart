// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:http/http.dart' as http;

import '../models/house_list_model.dart';

Future<List<HouseListModel>> getSearchedProperty(
    String state, String area, String search, int page) async {
  print("$state state");
  print("$area area");
  print("$search search");
  var response = await http.get(Uri.parse(
      "$baseUrl/search-listing?state=$state&lga=$area&search=$search&page=$page&size=4"));
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List house = responseData['data']['listing'];
    return house.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
