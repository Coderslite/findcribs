import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class RentListingController extends GetxController {
  final propertyCategoryKey = GlobalKey<FormFieldState>();

  var ageRestriction = 0.obs;
  var designType = ''.obs;
  var propertyAddress = ''.obs;
  var bathroomIndex = 100.obs;
  var bedroomIndex = 100.obs;
  var livingRoomIndex = 100.obs;
  var kitchenIndex = 100.obs;
  var bathroom = ''.obs;
  var bedroom = ''.obs;
  var livingRoom = ''.obs;
  var currency = ''.obs;
  var kitchen = ''.obs;
  var rentFrequency = ''.obs;
  var rentFee = '0'.obs;
  var otherCharges = ''.obs;
  var cautionFee = ''.obs;
  var serviceCharge = ''.obs;
  var legalFee = 0.obs;
  var agencyFee = 0.obs;

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
  RxList facilities = [].obs;

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
    rentFrequency.value = '';
    rentFee.value = '';
    otherCharges.value = '';
    cautionFee.value = '';
    serviceCharge.value = '';
    legalFee.value = 0;
    agencyFee.value = 0;

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
        ? formatter.format((_formatValue(rentFee.value) == ''
            ? 0
            : int.parse(_formatValue(rentFee.value))))
        : formatter
            .format((rentFee.value == ''
                ? 0
                : (int.parse(_formatValue(rentFee.value))) +
                    (cautionFee.value == ''
                        ? 0
                        : (int.parse(_formatValue(cautionFee.value)))) +
                    (serviceCharge.value == ''
                        ? 0
                        : (int.parse(_formatValue(serviceCharge.value)))) +
                    (rentFee.value == ''
                        ? 0
                        : ((int.parse(_formatValue(rentFee.value))) *
                                agencyFee.value) /
                            100) +
                    (rentFee.value == ''
                        ? 0
                        : ((int.parse(_formatValue(rentFee.value)) *
                                legalFee.value) /
                            100))))
            .toString();

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
