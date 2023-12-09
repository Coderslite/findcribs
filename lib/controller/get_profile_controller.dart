import 'package:get/get.dart';

import '../models/user_profile_information_model.dart';
import '../service/user_profile_service.dart';

late Future<UserProfile> userProfile;

class GetProfileController extends GetxController {
  var profileImg = ''.obs;
  var category = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var isVerified = ''.obs;
  var agent = {}.obs;
  var isLoading = true.obs;
  var myId = ''.obs;
  var phoneNumber = ''.obs;
  var listingCount = ''.obs;
  var favouritingAgentCount = ''.obs;
  var favouritedAgentCount = ''.obs;
  handleGetProfile() {
    userProfile = getUserProfile();
    userProfile.then((value) {
      isLoading.value = false;
      profileImg.value = value.profileImg.toString();
      category.value = value.category.toString();
      firstName.value = value.firstName.toString();
      lastName.value = value.lastName.toString();
      agent.value = value.agent.toString() == 'null' ? {} : value.agent!;
      myId.value = value.id.toString();
      phoneNumber.value = value.phoneNumber.toString();
      isVerified.value = value.agent!['is_verified'].toString();
      listingCount.value = value.listingCount.toString();
      favouritedAgentCount.value = value.favouritedAgentCount.toString();
      favouritingAgentCount.value = value.favouritingAgentCount.toString();
    });
  }

  @override
  void onInit() {
    handleGetProfile();
    super.onInit();
  }
}
