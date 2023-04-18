import 'package:get/get.dart';

import '../models/story_model.dart';
import '../service/get_user_story_list.dart';

class GetMyStoryController extends GetxController {
  late Future<List<StoryModel>> myStoryModel;
  var myStoryList = [].obs;
  var isLoading = true.obs;
  handleGetStoryList() {
    myStoryModel = getUserStoryList();
    myStoryModel.then((value) {
      myStoryList.value = value;
      isLoading.value = false;
    });
  }

  @override
  void onInit() {
    handleGetStoryList();
    super.onInit();
  }
}
