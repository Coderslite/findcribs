// ignore_for_file: avoid_print, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:findcribs/controller/get_chat_controller.dart';
import 'package:findcribs/controller/get_profile_controller.dart';
import 'package:findcribs/controller/socket_controller.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'package:socket_io_client/socket_io_client.dart';
// ignore: library_prefixes
import 'package:timeago/timeago.dart' as timeago;

import '../../controller/connectivity_controller.dart';
import '../../util/colors.dart';
import '../homepage/home_root.dart';
import 'chat_details.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  late Future<UserProfile> userProfile;
  GetProfileController getProfileController = Get.put(GetProfileController());

  @override
  void initState() {
    getAllChatController.handleGetMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        // ignore: unrelated_type_equality_checks
        () => connectivityController.connectionStatus == ConnectivityResult.none
            ? Center(
                child: GestureDetector(
                onTap: () {
                  Get.to(const HomePageRoot(navigateIndex: 0));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/network_failure.png",
                      scale: 10,
                    ),
                    const Text("Something went wrong"),
                  ],
                ),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 36,
                        color: context.isDarkMode
                            ? white
                            : const Color(0xFF263238),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 15.67),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFFB1B1B1),
                          ),
                          hintText: "Search for chats & messages",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: context.isDarkMode
                                  ? white
                                  : const Color(0xFF7C7C7C))),
                      onChanged: (value) {
                        getAllChatController.handleSearchChat(value,
                            int.parse(getProfileController.myId.toString()));
                      },
                      scrollPadding: const EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Expanded(child: ChatList())
                ],
              ),
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late Future<List<ChatMessageModel>> getChat;
  List<ChatMessageModel> messageList = [];
  late Future<UserProfile> userProfile;
  late Socket socket;
  List online = [];
  List filteredUnreadMessage = [];
  List filteredReadMessage = [];
  List<ChatMessageModel> filteredMessageByTime = [];
  bool isLoading = true;
  List isTyping = [];
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  SocketController socketController = Get.put(SocketController());
  GetProfileController getProfileController = Get.put(GetProfileController());

  @override
  void initState() {
    getAllChatController.handleGetMessage();
    super.initState();
  }

  @override
  void dispose() {
    // socket.dispose();
    // ignore: todo
    // TODO: implement dispose
    getAllChatController.handleGetMessage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => getAllChatController.isLoading.isTrue
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CollectionSlideTransition(
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 3,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 3,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 3,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : getAllChatController.allAvailableChats.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/opps.png"),
                      const Text(
                        "Opps!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text("No Recent Chat"),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return getAllChatController.handleGetMessage();
                  },
                  child: ListView.builder(
                      // reverse: true,
                      itemCount: getAllChatController.allAvailableChats.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String receiverId = getAllChatController
                                    .allAvailableChats[index].userTwo['id']
                                    .toString() ==
                                'null'
                            ? '0'
                            : getAllChatController.allAvailableChats[index]
                                        .userTwo['id'] !=
                                    int.tryParse(
                                        getProfileController.myId.toString())
                                ? getAllChatController
                                    .allAvailableChats[index].userTwo['id']
                                    .toString()
                                : getAllChatController
                                    .allAvailableChats[index].userOne['id']
                                    .toString();
                        String receiverFirstName = getAllChatController
                                    .allAvailableChats[index].userTwo['id'] !=
                                int.parse(getProfileController.myId.toString())
                            ? getAllChatController
                                .allAvailableChats[index].userTwo['first_name']
                            : getAllChatController
                                .allAvailableChats[index].userTwo['first_name'];
                        String receiverLastName = getAllChatController
                                    .allAvailableChats[index].userTwo['id'] !=
                                int.parse(getProfileController.myId.toString())
                            ? getAllChatController
                                .allAvailableChats[index].userTwo['last_name']
                            : getAllChatController
                                .allAvailableChats[index].userTwo['last_name'];
                        String receiverImage = getAllChatController
                                    .allAvailableChats[index].userTwo['id'] !=
                                int.parse(getProfileController.myId.toString())
                            ? getAllChatController.allAvailableChats[index]
                                    .userTwo['profile_pic'] ??
                                'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                            : getAllChatController.allAvailableChats[index]
                                    .userTwo['profile_pic'] ??
                                'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg';
                        String usrDate;
                        if (getAllChatController
                                    .allAvailableChats[index].messages ==
                                null ||
                            getAllChatController
                                .allAvailableChats[index].messages!.isEmpty) {
                          // Fallback to current time if no messages exist
                          usrDate = DateTime.now().toString();
                        } else {
                          // Safely get the last message's createdAt
                          final lastMessage = getAllChatController
                              .allAvailableChats[index].messages!.last;
                          usrDate = lastMessage['createdAt']?.toString() ??
                              DateTime.now().toString();
                        }

                        var todayDate = DateTime.parse(usrDate);
                        var lastChatTime = timeago.format(todayDate);
                        List filteredUnreadMessageArray = getAllChatController
                            .allAvailableChats[index].messages;
                        filteredUnreadMessage =
                            filteredUnreadMessageArray.where((msg) {
                          return msg['status'] == 'sent' &&
                              msg['senderId'] !=
                                  int.parse(
                                      getProfileController.myId.toString());
                        }).toList();
                        print(filteredUnreadMessage);
                        filteredReadMessage =
                            filteredUnreadMessageArray.where((element) {
                          return element['status'] == 'read' &&
                              element['senderId'] ==
                                  int.parse(
                                      getProfileController.myId.toString());
                        }).toList();
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatDetails(
                                  chatIndex: index,
                                  receiverId: int.parse(receiverId),
                                  receiverImage: receiverImage,
                                  firstName: receiverFirstName,
                                  lastName: receiverLastName,
                                  chatId: getAllChatController
                                      .allAvailableChats[index].id,
                                  lastReadMsg: filteredReadMessage.isEmpty
                                      ? 0
                                      : filteredReadMessage.last['id']),
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Stack(
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60,
                                                  imageUrl: receiverImage,
                                                  progressIndicatorBuilder:
                                                      (context, url, progress) {
                                                    return JumpingDotsProgressIndicator();
                                                  }),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: CircleAvatar(
                                                radius: 7,
                                                backgroundColor: socketController
                                                            .online
                                                            .contains(
                                                                receiverId) ==
                                                        true
                                                    ? const Color(0xFF168912)
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getAllChatController.allAvailableChats[index].userTwo['id']
                                                                  .toString() !=
                                                              getProfileController
                                                                  .myId
                                                                  .toString()
                                                          ? getAllChatController
                                                                      .allAvailableChats[
                                                                          index]
                                                                      .userTwo[
                                                                  'first_name'] +
                                                              " " +
                                                              getAllChatController
                                                                      .allAvailableChats[
                                                                          index]
                                                                      .userTwo[
                                                                  'last_name']
                                                          : getAllChatController
                                                                      .allAvailableChats[
                                                                          index]
                                                                      .userTwo[
                                                                  'first_name'] +
                                                              " " +
                                                              getAllChatController
                                                                      .allAvailableChats[
                                                                          index]
                                                                      .userTwo[
                                                                  'last_name'],
                                                      style: const TextStyle(
                                                          // color: grey,
                                                          fontSize: 14),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        filteredUnreadMessage
                                                                .isEmpty
                                                            ? Container()
                                                            : CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                radius: 10,
                                                                child: Text(
                                                                  filteredUnreadMessage
                                                                      .length
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize: 8,
                                                                  ),
                                                                ),
                                                              ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const Icon(
                                                              Icons.check,
                                                              size: 12,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(lastChatTime
                                                                .toString()),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  socketController
                                                              .isTypingChatId
                                                              .toString() ==
                                                          getAllChatController
                                                              .allAvailableChats[
                                                                  index]
                                                              .id
                                                              .toString()
                                                      ? "Typing..."
                                                      : (getAllChatController
                                                                      .allAvailableChats[
                                                                          index]
                                                                      .messages ==
                                                                  null ||
                                                              getAllChatController
                                                                  .allAvailableChats[
                                                                      index]
                                                                  .messages!
                                                                  .isEmpty)
                                                          ? "No messages yet" // Fallback text if no messages
                                                          : getAllChatController
                                                                  .allAvailableChats[
                                                                      index]
                                                                  .messages!
                                                                  .last[
                                                                      'message']
                                                                  ?.toString() ??
                                                              "Message unavailable", // Fallback if 'message' is null
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFFA5A5A5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
    );
  }
}
