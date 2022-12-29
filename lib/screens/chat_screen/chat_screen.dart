// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:findcribs/controller/get_chat_controller.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/service/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timeago/timeago.dart' as timeago;

import '../../controller/connectivity_controller.dart';
import '../homepage/home_root.dart';
import 'chat_details.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int? id;

  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  late Future<UserProfile> userProfile;

  handleGetUserProfile() async {
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        id = value.id!;
      });
    });
  }

  @override
  void initState() {
    handleGetUserProfile();
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
                  Get.to(HomePageRoot(navigateIndex: 0));
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
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Chats",
                      style: TextStyle(fontSize: 36, color: Color(0xFF263238)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
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
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Color(0xFF7C7C7C))),
                      onChanged: (value) {
                        getAllChatController.handleSearchChat(
                            value, int.parse(id.toString()));
                      },
                      scrollPadding: const EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Expanded(
                      child: SingleChildScrollView(
                          // reverse: true,
                          child: ChatList()))
                ],
              ),
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late Future<List<ChatMessageModel>> getChat;
  List<ChatMessageModel> messageList = [];
  late Future<UserProfile> userProfile;
  int? id;
  late Socket socket;
  List online = [];
  List filteredUnreadMessage = [];
  List filteredReadMessage = [];
  List<ChatMessageModel> filteredMessageByTime = [];
  bool isLoading = true;
  List isTyping = [];
  GetAllChatController getAllChatController = Get.put(GetAllChatController());

  @override
  void initState() {
    handleConnect();
    // handleGetMessages();
    handleGetUserProfile();
    handleGetUserProfile();
    getAllChatController.handleGetMessage();
    // handleStatusDetector();
    super.initState();
  }

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    // ignore: avoid_print
    print(token);

    socket = IO.io(
        'http://18.233.168.44:5000',
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
    // if (messageController.text)
    socket.on("START_TYPING", (data) {
      // print(data);
      var statusData = jsonDecode(data);
      print(statusData);
    });
    socket.on("STOP_TYPING", (data) {
      var statusData = jsonDecode(data);
      print(statusData);

      // if (widget.chatId == statusData['chatid']) {
      //   if (mounted) {
      //     setState(() {
      //       isTyping = false;
      //     });
      //   }
      // }
    });
    socket.on("MESSAGE_SENT", (data) {
      print("message sent successfully");
      setState(() {
        getAllChatController.handleGetMessage();
      });
    });

    socket.on("MESSAGES", (data) {
      setState(() {
        getAllChatController.handleGetMessage();
      });

      // handleFilteredLatestMessage();
      print("handling messages event");
    });
    socket.on("MESSAGE", (data) {
      print("got a message" + data);
      setState(() {
        getAllChatController.handleGetMessage();
      });

      var messageId = jsonDecode(data);
      print(messageId['messageId']);
      // socket.emit("DELIVERED", {
      //   "messageId": messageId['messageId'],
      // });
      // socket.emit("READ", {"messageId": messageId['messageId']});
    });

    // socket.on("DELIVERED", (data) {
    //   // var chatData = jsonDecode(data);
    //   print("delivered");
    //   print(data);
    // });
    // socket.on("READ", (data) {
    //   // var chatData = jsonDecode(data);
    //   print("read");
    //   print(data);
    // });
  }

  handleOnline(data) {
    var userOnline = jsonDecode(data);
    bool check = online.contains(userOnline['id']);
    if (check == false) {
      if (mounted) {
        setState(() {
          online.add(userOnline['id']);
          print(online);
        });
      }
    }
  }

  handleOffline(data) {
    var userOnline = jsonDecode(data);
    if (mounted) {
      setState(() {
        online.remove(userOnline['id']);
      });
    }
  }

  handleStatusDetector() {
    socket.on("ONLINE", (data) {
      handleOnline(data);

      // print(online);
      // print(data);
    });
    // socket.on("OFFLINE", (data) {
    //   // print("offline");
    //   handleOffline(data);
    //   print(data);
    // });
  }

  // handleGetMessages() async {
  //   setState(() {
  //     getChat = getMessageList();
  //     getChat.then((value) {
  //       if (mounted) {
  //         setState(() {
  //           // value.where((element) => false)
  //           messageList = filteredMessageByTime = value;
  //           handleFilteredLatestMessage();
  //           isLoading = false;
  //         });
  //       }
  //     });
  //   });
  // }

  // handleFilteredLatestMessage() {
  //   setState(() {
  //     filteredMessageByTime.sort(
  //       (a, b) {
  //         return a.lastMessage!['createdAt']
  //             .compareTo(b.lastMessage!['createdAt']);
  //       },
  //     );
  //   });
  // }

  handleGetUserProfile() async {
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        id = value.id!;
      });
    });
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
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getAllChatController.allAvailableChats.length,
                      itemBuilder: (context, index) {
                        int receiverId = getAllChatController
                                    .allAvailableChats[index].users![1]['id'] !=
                                id
                            ? getAllChatController
                                .allAvailableChats[index].users![1]['id']
                            : getAllChatController
                                .allAvailableChats[index].users![0]['id'];
                        String receiverFirstName = getAllChatController
                                    .allAvailableChats[index].users![1]['id'] !=
                                id
                            ? getAllChatController.allAvailableChats[index]
                                .users![1]['first_name']
                            : getAllChatController.allAvailableChats[index]
                                .users![0]['first_name'];
                        String receiverLastName = getAllChatController
                                    .allAvailableChats[index].users![1]['id'] !=
                                id
                            ? getAllChatController
                                .allAvailableChats[index].users![1]['last_name']
                            : getAllChatController.allAvailableChats[index]
                                .users![0]['last_name'];
                        String receiverImage = getAllChatController
                                    .allAvailableChats[index].users![0]['id'] !=
                                id
                            ? getAllChatController.allAvailableChats[index]
                                    .users![0]['profile_pic'] ??
                                'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                            : getAllChatController.allAvailableChats[index]
                                    .users![1]['profile_pic'] ??
                                'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg';
                        String usrDate = (getAllChatController
                                .allAvailableChats[index]
                                .messages!
                                .last['createdAt'])
                            .toString();
                        var todayDate = DateTime.parse(usrDate);
                        var lastChatTime = timeago.format(todayDate);
                        filteredUnreadMessage = getAllChatController
                            .allAvailableChats[index].messages!
                            .where((element) {
                          return element['status'] == 'sent' &&
                              element['senderId'] == receiverId;
                        }).toList();
                        filteredReadMessage = getAllChatController
                            .allAvailableChats[index].messages!
                            .where((element) {
                          return element['status'] == 'read' &&
                              element['senderId'] == receiverId;
                        }).toList();
                        // print("filtered message" +
                        //     filteredReadMessage.toString());

                        print("receiverId " + receiverId.toString());
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatDetails(
                                  chatIndex: index,
                                  receiverId: receiverId,
                                  receiverImage: receiverImage,
                                  firstName: receiverFirstName,
                                  lastName: receiverLastName,
                                  chatId: getAllChatController
                                      .allAvailableChats[index].id,
                                  lastReadMsg: filteredUnreadMessage.isEmpty
                                      ? 0
                                      : filteredUnreadMessage.first['id']),
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  getAllChatController.allAvailableChats[index].users![0]
                                                              ['id'] !=
                                                          id
                                                      ? getAllChatController.allAvailableChats[index].users![0]
                                                              ['first_name'] +
                                                          " " +
                                                          getAllChatController
                                                                  .allAvailableChats[
                                                                      index]
                                                                  .users![0]
                                                              ['last_name']
                                                      : getAllChatController
                                                                  .allAvailableChats[
                                                                      index]
                                                                  .users![1]
                                                              ['first_name'] +
                                                          " " +
                                                          getAllChatController
                                                              .allAvailableChats[index]
                                                              .users![1]['last_name'],
                                                  style: const TextStyle(
                                                      color: Color(0xFF263238),
                                                      fontSize: 14),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
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
                                                          MainAxisAlignment.end,
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
                                              isTyping.contains(
                                                      getAllChatController
                                                          .allAvailableChats[
                                                              index]
                                                          .id)
                                                  ? "Typing"
                                                  : getAllChatController
                                                      .allAvailableChats[index]
                                                      .messages!
                                                      .last['message']
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFFA5A5A5)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
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
