import 'package:get/get.dart';

import '../models/user_favourite_agent.dart';
import '../service/favourited_agent_service.dart';

class UserFavoritedAgentController extends GetxController {
  var allAgents = [].obs;
  var isLoading = true.obs;
  late Future<List<UserFavouriteAgentModel>> agentList;

  handleGetAllAgents({int? id}) async {
    try {
      if (id != null &&
          allAgents.where((agent) => agent.userId == id).toList().isNotEmpty) {
        allAgents.removeWhere((agent) => agent.userId == id);
      }
      var agentList = await getMyFavouriteAgentList();
      for (var x = 0; x < agentList.length; x++) {
        if (allAgents
                .where((agent) => agent.id == agentList[x].id)
                .toList()
                .isEmpty &&
            agentList[x].id.toString() != 'null') {
          allAgents.add(agentList[x]);
        }
      }
    } finally {
      isLoading.value = false;
    }
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
