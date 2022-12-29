import 'dart:convert';

import 'package:findcribs/models/house_detail_model.dart';
import 'package:http/http.dart' as http;

import '../components/constants.dart';
import '../models/house_list_model.dart';

Future<List<HouseListModel>> filterPropertyCategory(
    String? propertyType,
    String? minPrice,
    String? maxPrice,
    String? category,
    String? livingRoom,
    String? bathroom,
    String? bedroom,
    String? kitchen,
    String? location,int page) async {
  var response = await http.get(
    Uri.parse(
        "$baseUrl/search-listing-category?type=$propertyType&minPrice=$minPrice&maxPrice=$maxPrice&category=$category&livingroom=$livingRoom&bathroom=$bathroom&bedroom=$bedroom&kitchen=$kitchen&location=$location&page$page"),
  );
  var responseData = jsonDecode(response.body);
  if (responseData['status'] == true) {
    List houseList = responseData['data']['listing'];
    return houseList.map((e) => HouseListModel.fromJson(e)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}
