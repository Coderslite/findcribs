import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../components/constants.dart';
import 'get_chat_controller.dart';

late Socket socket;

class SocketController extends GetxController {
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  var online = [].obs;
  var isTypingChatId = ''.obs;
  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    socket = IO.io(
        socketUrl,
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': "$token"}) // optional
            .build());
    socket.connect();
    socket.onConnect((data) {
      print("connected");
      handleStatusDetector();
    });
    // handleStatusDetector();

    socket.onDisconnect((data) => print("disconnected"));
    socket.on(
      "ERROR",
      (data) {
        var errorMessage = jsonDecode(data);
        print("Error" + errorMessage['message']);
        print(data);
      },
    );
    // socket check typing status

    socket.on("START_TYPING", (data) {
      print(data);
      var statusData = jsonDecode(data);
      isTypingChatId.value = statusData['chatId'].toString();
    });
    print(isTypingChatId);
    socket.on("STOP_TYPING", (data) {
      isTypingChatId.value = '';

      // if (widget.chatId == statusData['chatid']) {
      //   if (mounted) {
      //     setState(() {
      //       isTyping = false;
      //     });
      //   }
      // }
    });
  }

  handleOnline(data) {
    var userOnline = jsonDecode(data);
    bool check = online.contains(userOnline['id']);
    if (check == false) {
      online.add(userOnline['id']);
      print(online);
    }
  }

  handleOffline(data) {
    var userOnline = jsonDecode(data);
    online.remove(userOnline['id']);
  }

  handleStatusDetector() {
    socket.on("ONLINE", (data) {
      handleOnline(data);
    });
    socket.on("OFFLINE", (data) {
      // print("offline");
      handleOffline(data);
      print(data);
    });
  }

  @override
  void onInit() {
    handleConnect();
    super.onInit();
  }
}
