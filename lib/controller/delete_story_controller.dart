import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/story/story_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteStoryController extends GetxController {
  var toBeDeletedStory = [].obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var idDeleting = 0.obs;

  handleAddDeleteStory(int id) {
    if (toBeDeletedStory.contains(id)) {
      toBeDeletedStory.remove(id);
    } else {
      toBeDeletedStory.add(id);
    }
  }

  handleDeleteMoment() {
    for (var element in toBeDeletedStory) {
      deleteMoment(element);
    }
    toBeDeletedStory.value = [];
  }

  deleteMoment(int id) async {
    isLoading.value = true;
    idDeleting.value = id;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var resposne =
        await http.delete(Uri.parse("$baseUrl/moment/$id"), headers: {
      "Authorization": "$token",
    });
    var responseData = jsonDecode(resposne.body);

    if (responseData['status'] == true) {
      isLoading.value = false;
      idDeleting.value = 0;
      Get.off(const StoryList());
    } else {
      isLoading.value = false;
      idDeleting.value = 0;
    }
  }

  @override
  void onClose() {
    toBeDeletedStory.value = [];
    super.onClose();
  }
}
