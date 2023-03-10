import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  var location = ''.obs;
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
    bathroomIndex.value = 0;
    bedroom.value = '';
    bedroomIndex.value = 0;
    livingRoom.value = '';
    livingRoomIndex.value = 0;
    kitchen.value = '';
    kitchenIndex.value = 0;
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
    location.value = '';
    lga.value = '';
    negotiable.value = 0;
    myImages.value = [];
    newfiles.value = [];

    legalFeeIndex.value = 0;
    agencyFeeIndex.value = 0;
    Get.delete<RentListingController>();
  }
}
