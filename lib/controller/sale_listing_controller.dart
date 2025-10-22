import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SaleListingController extends GetxController {
  var ageRestriction = 0.obs;
  var designType = ''.obs;
  var propertyAddress = ''.obs;
  var propertyDocument = ''.obs;
  var bathroomIndex = 100.obs;
  var bedroomIndex = 100.obs;
  var livingRoomIndex = 100.obs;
  var kitchenIndex = 100.obs;
  var bathroom = ''.obs;
  var bedroom = ''.obs;
  var livingRoom = ''.obs;
  var currency = ''.obs;
  var kitchen = ''.obs;
  var saleFee = ''.obs;
  var otherCharges = ''.obs;
  var saleCommission = 0.obs;
  var saleCommissionIndex = 100.obs;

  var coveredBy = ''.obs;
  var totalArea = ''.obs;
  var interiorDesign = ''.obs;
  var parkingSpace = ''.obs;
  var water = ''.obs;
  var electricity = ''.obs;
  var description = ''.obs;
  var propertyCategory = ''.obs;
  var propertyType = ''.obs;
  var state = ''.obs;
  var lga = ''.obs;
  var negotiable = 0.obs;
  var myImages = [].obs;
  var newfiles = [].obs;
  var facilities = [].obs;

  var legalFeeIndex = 0.obs;
  var agencyFeeIndex = 0.obs;
  final ImagePicker _picker = ImagePicker();

  getImage() async {
    final List<XFile> image = (await _picker.pickMultiImage());

    for (var img in image) {
      newfiles.add(File(img.path));
    }
  }

  handleResetInformation() {
    ageRestriction.value = 0;
    designType.value = '';
    propertyAddress.value = '';
    bathroom.value = '';
    bathroomIndex.value = 100;
    bedroom.value = '';
    bedroomIndex.value = 100;
    livingRoom.value = '';
    livingRoomIndex.value = 100;
    kitchen.value = '';
    kitchenIndex.value = 100;
    currency.value = '';
    saleFee.value = '';
    otherCharges.value = '';
    saleCommission.value = 0;
    saleCommissionIndex.value = 100;

    coveredBy.value = '';
    totalArea.value = '';
    interiorDesign.value = '';
    parkingSpace.value = '';
    water.value = '';
    electricity.value = '';
    description.value = '';
    propertyCategory.value = '';
    propertyType.value = '';
    state.value = '';
    lga.value = '';
    negotiable.value = 0;
    myImages.value = [];
    newfiles.value = [];

    legalFeeIndex.value = 0;
    agencyFeeIndex.value = 0;
  }

  String _formatValue(String value) {
    return value.replaceAll(',', '');
  }

  Future<bool> handleShowConfirmPrice(BuildContext context) async {
    var res = false;
    var formatter = NumberFormat("#,###");
    var formatedPrice = otherCharges.value == 'Yes'
        ? formatter.format(_formatValue(saleFee.value) == ''
            ? 0
            : int.parse(_formatValue(saleFee.value)))
        : formatter.format(saleFee.value == ''
            ? 0
            : int.parse(_formatValue(saleFee.value)) +
                (int.parse(_formatValue(saleFee.value)) *
                        saleCommission.value) /
                    100);

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Is this the price for your property?",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${currency.value == 'Naira' ? "NGN" : "\$"}$formatedPrice",
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  res = false;
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  res = true;
                  Get.back();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
    return res;
  }
}
