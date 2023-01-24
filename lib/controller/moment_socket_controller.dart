import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/story_list_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late Socket momentSocket;

class MomentSocketController extends GetxController {
  GetStoryListController getStoryListController =
      Get.put(GetStoryListController());

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    momentSocket = IO.io(
        '$socketUrl/moment',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': "$token"}) // optional
            .build());
    momentSocket.connect();
    momentSocket.onConnect((data) {
      print("story socket connected");
      getStoryListController.handleGetStory();
    });
    // handleStatusDetector();

    momentSocket.onDisconnect((data) => print("disconnected"));
    momentSocket.on(
      "ERROR",
      (data) {
        var errorMessage = jsonDecode(data);
        print("Error" + errorMessage['message']);
        print(data);
      },
    );
    momentSocket.on(
        "ADDED_STORY", (data) => getStoryListController.handleGetStory());
    momentSocket.on(
        "DELETED_STORY", (data) => getStoryListController.handleGetStory());
    // if (messageController.text)
  }

  @override
  void onInit() {
    handleConnect();
    super.onInit();
  }
}
