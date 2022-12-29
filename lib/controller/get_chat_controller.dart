import 'package:get/get.dart';

import '../models/chat_list_model.dart';
import '../service/get_chat_service.dart';

class GetAllChatController extends GetxController {
  var allAvailableChats = [].obs;
  var myMessage = [].obs;
  var isLoading = true.obs;
  var myMessagevar = [].obs;
  var filteredUnreadMessage = [].obs;
  var allUnreadMessage = [].obs;

  late Future<List<ChatMessageModel>> getChat;

  @override
  void onInit() {
    handleGetMessage();
    super.onInit();
  }

  handleGetMessage() {
    // allAvailableChats.value = [];
    getChat = getMessageList();
    getChat.then((chats) {
      allAvailableChats.value = myMessage.value = chats;
      allAvailableChats.sort(
        (a, b) {
          return a.lastMessage!['createdAt']
              .compareTo(b.lastMessage!['createdAt']);
        },
      );
    });

    // allAvailableChats.sort(
    //   (a, b) {
    //     return a.lastMessage!['createdAt']
    //         .compareTo(b.lastMessage!['createdAt']);
    //   },
    // );

    isLoading.value = false;
  }

  handleSearchChat(String value, int id) {
    if (value.isEmpty || value == '') {
      allAvailableChats.value = myMessage;
    } else {
      allAvailableChats.value = allAvailableChats.where((element) {
        return element.users[0]['id'] == id
            ? element.users[1]['first_name']
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                element.users[1]['last_name']
                    .toLowerCase()
                    .contains(value.toLowerCase())
            : element.users[0]['first_name']
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                element.users[0]['last_name']
                    .toLowerCase()
                    .contains(value.toLowerCase());
      }).toList();
    }
  }

  // handleGetLastChatCount(int? id) async {
  //   getChat = getMessageList();
  //   getChat.then((chats) {
  //     allAvailableChats.value = chats;
  //     allAvailableChats.sort(
  //       (a, b) {
  //         return a.lastMessage!['createdAt']
  //             .compareTo(b.lastMessage!['createdAt']);
  //       },
  //     );
  //     filteredUnreadMessage.value =
  //         allAvailableChats.last.messages!.where((element) {
  //       return element['status'] == 'sent' && element['senderId'] != id;
  //     }).toList();
  //     for (int x = 0; x < filteredUnreadMessage.length; x++) {
  //       allUnreadMessage.add("value");
  //     }
  //   });
  // }
}
