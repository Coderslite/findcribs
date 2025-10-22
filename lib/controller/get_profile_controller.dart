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
  var whatsappNo = ''.obs;
  var listingCount = ''.obs;
  var favouritingAgentCount = ''.obs;
  var favouritedAgentCount = ''.obs;
  var subscriptionId = ''.obs;
  var subscriptionExpiry = ''.obs;
  var subscriptionName = ''.obs;
  var hasSubscription = false.obs;
  var showSuggestedAgents = true.obs;
  var showUpdateNumber = true.obs;
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
      whatsappNo.value = agent.containsKey('whatsapp_number')
          ? agent['whatsapp_number'].toString()
          : '';
      isVerified.value = value.agent!['is_verified'].toString();
      listingCount.value = value.listingCount.toString();
      favouritedAgentCount.value = value.favouritedAgentCount.toString();
      favouritingAgentCount.value = value.favouritingAgentCount.toString();
      subscriptionId.value = value.subscriptionLogs != null
          ? value.subscriptionLogs!['subscriptionId'].toString()
          : '1';
      subscriptionName.value = value.subscriptionLogs != null
          ? value.subscriptionLogs!['subscription']['name'].toString()
          : '1';
      DateTime expirationDate;
      try {
        expirationDate = value.subscriptionLogs != null &&
                value.subscriptionLogs!.containsKey('expiresAt') &&
                value.subscriptionLogs!['expiresAt'] != null
            ? DateTime.parse(value.subscriptionLogs!['expiresAt'])
            : DateTime.now().add(Duration(days: 30));
        subscriptionExpiry.value = expirationDate.toString();
      } catch (e) {
        // Handle parsing errors (e.g., invalid ISO 8601 string)
        print('Error parsing expiresAt: $e');
        expirationDate = DateTime.now(); // Fallback
      }

// Ensure both times are in the same time zone (e.g., UTC)
      DateTime now = DateTime.now().toUtc();
      expirationDate = expirationDate.toUtc();

      hasSubscription.value = value.subscriptionLogs!['subscriptionId'] <= 1
          ? false
          : expirationDate.isAfter(now);
    });
  }

  @override
  void onInit() {
    handleGetProfile();
    super.onInit();
  }
}
