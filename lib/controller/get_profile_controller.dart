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
  var agent = ''.obs;
  var isLoading = true.obs;

  handleGetProfile() {
    userProfile = getUserProfile();
    userProfile.then((value) {
      isLoading.value = false;
      profileImg.value = value.profileImg.toString();
      category.value = value.category.toString();
      firstName.value = value.firstName.toString();
      lastName.value = value.lastName.toString();
      isVerified.value = value.agent!['is_verified'].toString();
      agent.value = value.agent.toString();
    });
  }

  @override
  void onInit() {
    handleGetProfile();
    super.onInit();
  }
}
