import 'dart:convert';
import 'package:findcribs/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/house_list_model.dart';

Future<HouseListModel> getSingleProperty(int? id) async {
  // var token = "be2dc9cdded61704c07c7e67eb8971f5f434e6a6";

  final response = await http.get(
    Uri.parse("$baseUrl/listing/$id"),
  );
  var jsonResponse = jsonDecode(response.body);
  if (jsonResponse['status'] == true) {
    return HouseListModel.fromJson(jsonResponse['data']);
  } else {
    Navigator.pop(Get.context!);
    Fluttertoast.showToast(msg: "property not available");
    throw Exception(jsonResponse['message']);
  }
}
