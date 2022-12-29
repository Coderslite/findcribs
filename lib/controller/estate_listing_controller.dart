import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EstateListingController extends GetxController {
  var ageRestriction = 0.obs;
  var designType = ''.obs;
  var propertyAddress = ''.obs;
  var propertyName = ''.obs;
  var bathroom = 0.obs;
  var bedroom = 0.obs;
  var livingRoom = 0.obs;
  var currency = ''.obs;
  var kitchen = 0.obs;
  var rentFrequency = ''.obs;
  var price = ''.obs;
  var propertyCondition = ''.obs;

  var coveredBy = ''.obs;
  var totalArea = ''.obs;
  var interiorDesign = ''.obs;
  var parkingSpace = ''.obs;
  var water = ''.obs;
  var electricity = ''.obs;
  var description = ''.obs;
  var propertyCategory = ''.obs;
  var propertyType = 'rent'.obs;
  var location = ''.obs;
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
    propertyName.value = '';
    bathroom.value = 0;
    bedroom.value = 0;
    livingRoom.value = 0;
    currency.value = '';
    kitchen.value = 0;
    rentFrequency.value = '';
    price.value = '';
    propertyCondition.value = '';

    coveredBy.value = '';
    totalArea.value = '';
    interiorDesign.value = '';
    parkingSpace.value = '';
    water.value = '';
    electricity.value = '';
    description.value = '';
    propertyCategory.value = '';
    propertyType.value = 'rent';
    location.value = '';
    negotiable.value = 0;
    myImages.value = [];
    newfiles.value = [];

    legalFeeIndex.value = 0;
    agencyFeeIndex.value = 0;
  }
}
