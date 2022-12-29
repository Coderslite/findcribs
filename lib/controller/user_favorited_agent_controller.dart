import 'package:get/get.dart';

import '../models/user_favourite_agent.dart';
import '../service/favourited_agent_service.dart';

class UserFavoritedAgentController extends GetxController {
  var allAgents = [].obs;
  var isLoading = true.obs;
  late Future<List<UserFavouriteAgentModel>> agentList;

  handleGetAllAgents() async {
    agentList = getMyFavouriteAgentList();
    // storyList = getFavouriteStoryList();
    agentList.then((value) {
      // print(value);
      isLoading.value = false;
      allAgents.value = value;
    });
  }

  @override
  void onInit() {
    handleGetAllAgents();
    super.onInit();
  }

  @override
  void onClose() {
    handleGetAllAgents();

    super.onClose();
  }
}
