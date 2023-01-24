import 'package:findcribs/controller/connectivity_controller.dart';
import 'package:findcribs/controller/delete_story_controller.dart';
import 'package:findcribs/controller/estate_listing_controller.dart';
import 'package:findcribs/controller/get_chat_controller.dart';
import 'package:findcribs/controller/get_profile_controller.dart';
import 'package:findcribs/controller/login_controller.dart';
import 'package:findcribs/controller/moment_socket_controller.dart';
import 'package:findcribs/controller/rent_listing_controller.dart';
import 'package:findcribs/controller/sale_listing_controller.dart';
import 'package:findcribs/controller/socket_controller.dart';
import 'package:findcribs/controller/story_list_controller.dart';
import 'package:findcribs/controller/user_favorited_agent_controller.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:findcribs/screens/notification_screen/get_all_notificaton_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController());
    Get.put(LoginController());
    // Get.put(GetPropertyListingController());
    Get.put(UserFavouritedListingController());
    Get.put(GetAllChatController());
    Get.put(GetStoryListController());
    Get.put(UserFavoritedAgentController());
    Get.put(GetAllNotificationController());
    Get.put(DeleteStoryController());
    Get.put(GetProfileController());
    Get.put(RentListingController());
    Get.put(SaleListingController());
    Get.put(EstateListingController());
  }
}
