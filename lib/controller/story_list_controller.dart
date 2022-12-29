import 'package:get/get.dart';

import '../models/story_list_model.dart';
import '../service/get_all_story_list.dart';

class GetStoryListController extends GetxController {
  var allStoryList = [].obs;
  late Future<List<StoryListModel>> storyList;
  List<StoryListModel> filteredStoryList = [];

  handleGetStory() async {
    storyList = getAllStoryList();
    storyList.then((value) {
      filteredStoryList = value;
           filteredStoryList = value
            .where((element) => element.moment!.isNotEmpty)
            .toList();
      
      allStoryList.value = filteredStoryList;
      // print("allStories" + allStoryList.toString());
    });
  }

  @override
  void onInit() {
    handleGetStory();
    super.onInit();
  }
}
