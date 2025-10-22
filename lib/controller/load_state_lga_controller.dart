import 'dart:convert';

import 'package:findcribs/controller/estate_listing_controller.dart';
import 'package:findcribs/controller/rent_listing_controller.dart';
import 'package:findcribs/controller/sale_listing_controller.dart';
import 'package:findcribs/controller/search_listing_controller.dart';
import 'package:findcribs/models/state_lga_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var estateListingController = Get.put(EstateListingController());
var saleListingController = Get.put(SaleListingController());
var rentListingController = Get.put(RentListingController());
var searchListingController = Get.put(SearchListingController());

class LoadStateLgaController extends GetxController {
  var data = [].obs;
  var lga = [].obs;
  Future<List<StateLgaModel>> loadStates() async {
    Future.delayed(const Duration(seconds: 3), () {});
    final states = await DefaultAssetBundle.of(Get.context!)
        .loadString('assets/json/nigeria-state-and-lgas.json');
    data.value = await jsonDecode(states);
    return data.map((e) => StateLgaModel.fromJson(e)).toList();
  }

  handleEstateFetchLga() {
    lga.value = data
        .where((p0) =>
            p0['state'].toLowerCase() ==
            estateListingController.state.toLowerCase().toString())
        .toList();
    lga.value = lga[0]['lgas'];
    estateListingController.lga.value = '';
  }

  handleRentFetchLga() {
    try {
      print("fetching");
      print(rentListingController.state.value);
      lga.value = data
          .where((p0) =>
              p0['state'].toLowerCase() ==
              rentListingController.state.toLowerCase().toString())
          .toList();
      lga.value = lga[0]['lgas'];
      print(lga.length);
      print("lga");
      rentListingController.lga.value = '';
    } catch (err) {
      print(err);
    }
  }

  handleSaleFetchLga() {
    lga.value = data
        .where((p0) =>
            p0['state'].toLowerCase() ==
            saleListingController.state.toLowerCase().toString())
        .toList();
    lga.value = lga[0]['lgas'];
    saleListingController.lga.value = '';
  }

  handleSearchFetchLga() {
    lga.value = data
        .where((p0) =>
            p0['state'].toLowerCase() ==
            searchListingController.location.toLowerCase().toString())
        .toList();
    lga.value = lga[0]['lgas'];
    searchListingController.lga.value = '';
  }

  @override
  void onReady() {
    loadStates();
    super.onInit();
  }
}
