import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/social_login.dart';

class HomeRootController extends GetxController {
  var index = 0.obs;
  var isToolTip = false.obs;

  selectedTab(idx) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    token == null && index >= 0
        ? showModalBottomSheet<void>(
            context: Get.context!,
            builder: (BuildContext context) {
              return const SocialLogin();
            })
        : index.value = idx;
  }
}
