import 'package:findcribs/controller/get_property_listing_controller.dart';
import 'package:get/get.dart';

import '../models/house_list_model.dart';
import '../service/property_details_service.dart';

late Future<HouseListModel> singlePropertyModel;

GetPropertyListingController getPropertyListingController =
    Get.put(GetPropertyListingController());

class GetSinglePropertyController extends GetxController {
  var propertyId = ''.obs;
  var singleProperty = [].obs;
  var isLoading = true.obs;

  handleGetPropertyById() {
    isLoading.value = true;
    singleProperty.value = getPropertyListingController.filteredList
        .where((p0) => p0.id.toString() == propertyId.toString())
        .toList();
    isLoading.value = false;
  }

  handleGetSinglePropertyById() {
    isLoading.value = true;
    singleProperty.value = [];
    singlePropertyModel = getSingleProperty(int.parse(propertyId.string));
    singlePropertyModel.then((value) {
      singleProperty.add(value);
      isLoading.value = false;
    });
  }

  handlePropertyClicked(int id) {
    propertyId.value = id.toString();
    isLoading.value = true;
    getPropertyListingController.filteredList
            .where((p0) => p0.id.toString() == id.toString())
            .isNotEmpty
        ? handleGetPropertyById()
        : handleGetSinglePropertyById();
  }
}
