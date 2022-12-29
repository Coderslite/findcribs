import 'package:get/get.dart';

class FilterTerraceController extends GetxController {
  var propertyType = 'All'.obs;
  var state = "Nigeria".obs;
  var area = "".obs;

  var sortPropertyBathroom = 0.0.obs;
  var sortPropertyBedroom = 0.obs;
  var sortPropertyBedroom1 = 0.obs;
  var sortPropertLivingroom = 0.0.obs;
  var sortPropertyKitchen = 0.0.obs;
  var minPrice = 0.obs;
  var maxPrice = 100.obs;
  var location = ''.obs;

  handleFilterPropertyType(String propertytype) {
    propertyType.value = propertytype;
  }
    handleResetInfo() {
    propertyType.value = 'All';
    state.value = "Nigeria";
    area.value = "";

    sortPropertyBathroom.value = 0.0;
    sortPropertyBedroom.value = 0;
    sortPropertyBedroom1.value = 0;
    sortPropertLivingroom.value = 0.0;
    sortPropertyKitchen.value = 0.0;
    minPrice.value = 0;
    maxPrice.value = 100;
    location.value = '';
  }
}
