import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/house_list_model.dart';

Future<HouseListModel> getSingleProperty(int? id) async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(id);
  final response = await http.get(Uri.parse("$baseUrl/listing/$id"),
      headers: {"authorization": "$token"});

  var jsonResponse = jsonDecode(response.body);
  if (jsonResponse['status'] == true) {
    return HouseListModel.fromJson(jsonResponse['data']);
  } else {
    Navigator.pop(Get.context!);
    Fluttertoast.showToast(msg: "property not available");
    throw Exception(jsonResponse['message']);
  }
}
