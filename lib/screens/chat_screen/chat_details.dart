// ignore_for_file: avoid_print, library_prefixes, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'package:findcribs/controller/get_chat_controller.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/models/message_model.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:findcribs/service/get_chat_service.dart';
import 'package:findcribs/service/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart' as launchUrl;

import '../../service/user_profile_by_id_service.dart';

// ignore: library_prefixes

// ignore: camel_case_types
class ChatDetails extends StatefulWidget {
  final int receiverId;
  final String receiverImage;
  final int chatIndex;
  final String firstName;
  final String lastName;
  final int? chatId;
  final int? lastReadMsg;
  const ChatDetails(
      {Key? key,
      required this.chatIndex,
      required this.receiverId,
      required this.firstName,
      required this.lastName,
      required this.chatId,
      required this.receiverImage,
      this.lastReadMsg})
      : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class MyMessageModel {
  String? message;
  int? senderId;
  String? myId;
  String? realReceiverId;
  int? propertyId;
  String status;
  String time;

  MyMessageModel({
    required this.message,
    required this.senderId,
    required this.myId,
    required this.realReceiverId,
    this.propertyId,
    required this.status,
    required this.time,
  });
}

class _ChatDetailsState extends State<ChatDetails> {
  late Future<List<ChatMessageModel>> getChat;
  List messageList = [];
  List firstMessageList = [];
  List<MessageModel> currentMessageList = [];
  late Future<UserProfile> userProfile;
  late Future<UserProfile> userProfile2;
  List myMessage = [];
  List myMessageList = [];
  // Map<String, dynamic> messages = {};
  int? id;
  late Socket socket;
  List online = [];

  var messageController = TextEditingController();
  String message = '';
  ScrollController listScrollController = ScrollController();
  bool isTyping = false;
  String isTypingChatId = '';
  late StreamSubscription<bool> subscription;
  FocusNode focusNode = FocusNode();
  String receiverPhone = '';

  GetAllChatController getAllChatController = Get.put(GetAllChatController());

  @override
  void initState() {
    // print(widget.receiverId);
    getAllChatController.handleGetMessage();
    handleGetFirstMessages();
    // handleGetUserProfile();

    handleGetProfile();
    handleConnect();
    super.initState();
    subscription = KeyboardVisibilityController().onChange.listen((event) {
      final message = event ? "keyboard open" : "not opened";
      print(message);
      if (event) {
        socket.emit("START_TYPING", {
          "chatId": widget.chatId,
        });
      } else {
        print("stopped");
        socket.emit("STOP_TYPING", {
          "chatId": widget.chatId,
        });
      }
    });
  }

  handleScroll() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  handleGetFirstMessages() async {
    if (mounted) {
      setState(() {
        messageList = firstMessageList = getAllChatController.allAvailableChats;
        myMessage = messageList.where((element) {
          return element.id == widget.chatId;
        }).toList();

        myMessageList = myMessage[0].messages!;
      });
    }
  }

  handleGetMessages() async {
    getChat = getMessageList();
    getChat.then((value) {
      if (mounted) {
        setState(() {
          handleScroll();
          messageList = value;
          myMessage = messageList.where((element) {
            return element.id == widget.chatId;
          }).toList();

          myMessageList = myMessage[0].messages!;
          // myMessage.add(messages);
          print(myMessageList);
        });
      }
    });
  }

  handleGetUserProfile() async {
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        id = value.id!;
      });
    });
  }

  handleGetProfile() {
    setState(() {
      userProfile2 = getUserProfileById(widget.receiverId);
      userProfile2.then((value) {
        receiverPhone = value.agent!['phone_number'].toString();
      });
    });
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
    setState(() {
      online.remove(userOnline['id']);
    });
  }

  handleStatusDetector() {
    socket.on("ONLINE", (data) {
      if (mounted) {
        setState(() {
          handleOnline(data);
        });
      }

      // print(online);
      // print(data);
    });
    socket.on("OFFLINE", (data) {
      // print("offline");
      setState(() {
        handleOffline(data);
        print(data);
      });
    });
  }

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    socket = IO.io(
        'http://18.233.168.44:5000/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': "$token"}) // optional
            .build());
    socket.connect();
    socket.onConnect((data) {
      print("connected");
      socket.emit('BULK_READ', {
        "lastReadMesgId": widget.lastReadMsg,
      });
    });
    handleStatusDetector();

    socket.onDisconnect((data) => print("disconnected"));
    socket.on(
      "ERROR",
      (data) {
        var errorMessage = jsonDecode(data);
        print("Error" + errorMessage['message']);
        print(data);
      },
    );

    socket.emit('BULK_READ', {
      "lastReadMesgId": widget.lastReadMsg,
    });
    socket.on("BULK_READ", (data) {
      print(data);
      setState(() {
        handleGetMessages();
      });
      print("bulk");
    });
    // socket check typing status
    // if (messageController.text)
    socket.on("START_TYPING", (data) {
      // print(data);
      var statusData = jsonDecode(data);
      print("my chat id" + widget.chatId.toString());
      print(statusData);
      if ((widget.chatId) == statusData['chatId']) {
        setState(() {
          isTyping = true;
        });
      }
    });
    socket.on("STOP_TYPING", (data) {
      var statusData = jsonDecode(data);
      print(statusData);
      if ((widget.chatId) == statusData['chatId']) {
        setState(() {
          isTyping = false;
        });
      }

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

      handleGetMessages();
    });

    socket.on("MESSAGES", (data) {
      handleGetMessages();

      print("handling messages event");
    });
    socket.on("MESSAGE", (data) {
      print("got a message" + data);
      if (mounted) {
        handleGetMessages();

        var messageId = jsonDecode(data);
        print(messageId['messageId']);
        socket.emit("DELIVERED", {
          "messageId": messageId['messageId'],
        });
        socket.emit("READ", {"messageId": messageId['messageId']});

        handleScroll();
      }
    });
    socket.on("DELIVERED", (data) {
      // var chatData = jsonDecode(data);
      print("delivered");
      print(data);
    });
    socket.on("READ", (data) {
      // var chatData = jsonDecode(data);

      handleGetMessages();

      print("read");
      print(data);
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    // socket.dispose();
    subscription.cancel();
    focusNode.dispose();
    getAllChatController.handleGetMessage();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(height: 36,),
          Container(
            padding:
                const EdgeInsets.only(bottom: 18, top: 54, left: 21, right: 21),
            color: const Color(0xFFFFFFFF),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) {
                        //   return HomePageRoot(navigateIndex: 3);
                        // }));
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF0F7F8),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.arrow_back_ios)),
                    ),
                    const InkWell(
                      // onTap: () {Navigator.pop(context);},
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 41,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.receiverImage),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.firstName.toString() +
                                    " " +
                                    widget.lastName.toString(),
                                style: const TextStyle(
                                    color: Color(0xFF263238), fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // ignore: deprecated_member_use
                                  launchUrl.launch("tel:$receiverPhone");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset("assets/svgs/call.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // SvgPicture.asset("assets/svgs/search.svg"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          isTyping
                              ? const Text("typing...")
                              : online.contains(widget.receiverId)
                                  ? const Text(
                                      "Online",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF168912)),
                                    )
                                  : const Text(
                                      "Offline",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          // const SizedBox(height: 33,),
          Expanded(
              child: myMessage.isEmpty
                  ? const Center(
                      child: Text("Loading...."),
                    )
                  : SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: myMessageList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          controller: listScrollController,
                          itemBuilder: (context, index) {
                            // print(myMessage);
                            // print(data[index]);
                            // print(widget.receiverId + "-" + "1");
                            // print("my id" + id.toString());
                            // print("receiver id" +
                            //     myMessage[index]['receiverId'].toString());
                            // print("real receiver id" + widget.receiverId.toString());
                            var chatDate = myMessageList[index]['createdAt'];
                            var todayDate = DateTime.parse(chatDate);
                            var lastChatTime = timeago.format(todayDate);

                            return ChatItem(
                              realReceiverId: widget.receiverId.toString(),
                              // isMe: chats[index],
                              myId: id.toString(),
                              senderId:
                                  myMessageList[index]['senderId'].toString(),
                              message:
                                  myMessageList[index]['message'].toString(),
                              propertyId: myMessageList[index]['propertyId'],
                              status: myMessageList[index]['status'],
                              time: lastChatTime,
                              // chatID: '2',
                            );
                          }),
                    )),

          Container(
            color: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svgs/attach.svg"),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: messageController,
                    textInputAction: TextInputAction.send,
                    maxLines: 3,
                    minLines: 1,
                    onFieldSubmitted: (value) {
                      // sendMessage();
                      handleSendMessage(messageController.text);
                    },
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF7F7F7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 15.67),
                        // suffixIcon: Image.asset("assets/images/emoji.png"),
                        hintText: "Messages...",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xFF7C7C7C))),
                    onChanged: (va) {
                      setState(() {
                        message = va;
                      });
                    },
                    scrollPadding: const EdgeInsets.all(0),
                  ),
                ),
                // Align(
                //     alignment: Alignment.bottomRight,
                //     child: Padding(
                //         padding: const EdgeInsets.only(
                //           right: 50,
                //           top: 10,
                //         ),
                //         child: Image.asset("assets/images/emoji.png"))),
                // const SizedBox(
                //   width: 20,
                // ),
                // message == ''
                //     ? Align(
                //         alignment: Alignment.centerRight,
                //         child: Padding(
                //           padding: const EdgeInsets.only(
                //             top: 5.0,
                //           ),
                //           child: SocialMediaRecorder(
                //             storeSoundRecoringPath:
                //                 getTemporaryDirectory().toString() +
                //                     "/voice_recorder",
                //             radius: BorderRadius.circular(20),
                //             sendRequestFunction: (soundFile) {
                //               print("the current path is ${soundFile.path}");
                //             },
                //             encode: AudioEncoderType.AAC,
                //           ),
                //         ),
                //       )
                //     :
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        handleSendMessage(messageController.text);
                      },
                      child: const Icon(
                        Icons.send_rounded,
                        color: Color(0xFF0072BA),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  handleSendMessage(String chatMessage) async {
    // print(widget.receiverId);
    // var dateFormat =  DateFormat('a');
    //  DateTime durationEnd =  dateFormat.parse('10:00PM');
    // final String formattedDateTime =
    //     DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    print(DateTime.now().toIso8601String());

    var messageMap = {
      "clientMesgId": UniqueKey().toString(),
      "mesgType": "text",
      "receiverId": widget.receiverId,
      "message": chatMessage,
      "sentAt": DateTime.now().toIso8601String(),
    };
    // var newMessage = MyMessageModel(
    //     message: chatMessage,
    //     senderId: id,
    //     myId: id.toString(),
    //     realReceiverId: widget.receiverId.toString(),
    //     status: 'pending',
    //     time: DateTime.now().toString());
    socket.emit('MESSAGE', messageMap);
    messageController.clear();
    if (mounted) {
      setState(() {
        message = '';
        // myMessageList.add(newMessage);
        getAllChatController.handleGetMessage();
        handleGetMessages();
      });
    }
  }
}

class ChatItem extends StatefulWidget {
  final String senderId;
  final String realReceiverId;
  final String? myId;
  final int? propertyId;
  final String status;
  final String time;
  // final bool isMe;
  final String message;
  // final String chatID;
  const ChatItem(
      {Key? key,
      // required this.isMe,
      required this.senderId,
      required this.message,
      // required this.chatID,
      required this.myId,
      required this.realReceiverId,
      required this.propertyId,
      required this.status,
      required this.time})
      : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  double left = 0;

  double right = 0;

  Color color = const Color(0xFFFFFFFF);

  Color bkg = const Color(0xFF0072BA);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    left = widget.realReceiverId != widget.senderId ? 60.0 : 20.0;
    right = widget.realReceiverId != widget.senderId ? 20 : 60;
    color = widget.realReceiverId != widget.senderId
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF444444);
    bkg = widget.realReceiverId != widget.senderId
        ? const Color(0xFF0072BA)
        : const Color(0xFFFFFFFF);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 12, 12, 17),
      margin: EdgeInsets.only(top: 10, left: left, right: right),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: bkg,
      ),
      child: Column(
        crossAxisAlignment: widget.realReceiverId != widget.senderId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          widget.realReceiverId != widget.senderId
              ? widget.propertyId == null
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return ProductDetails(id: widget.propertyId);
                        }));
                      },
                      child: const Text(
                        "You responded to this item",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
              : widget.propertyId == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return ProductDetails(id: widget.propertyId);
                        }));
                      },
                      child: const Text("This property was responded to")),
          Column(
            crossAxisAlignment: widget.realReceiverId != widget.senderId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: widget.realReceiverId != widget.senderId
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Text(
                      widget.message,
                      style: TextStyle(color: color, fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  widget.realReceiverId != widget.senderId
                      ? widget.status == 'pending'
                          ? JumpingDotsProgressIndicator(color: Colors.white)
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset("assets/images/sender_mark.png"),
                                widget.status == "sent"
                                    ? Image.asset(
                                        "assets/images/sender_mark.png")
                                    : Positioned(
                                        top: 2,
                                        left: 2,
                                        child: Image.asset(
                                            "assets/images/sender_mark.png"))
                              ],
                            )
                      : widget.status == 'pending'
                          ? JumpingDotsProgressIndicator(color: Colors.white)
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset("assets/images/sender_mark.png"),
                                widget.status == "sent"
                                    ? Image.asset(
                                        "assets/images/receiver_mark.png")
                                    : Positioned(
                                        top: 2,
                                        left: 2,
                                        child: Image.asset(
                                            "assets/images/receiver_mark.png"),
                                      )
                              ],
                            ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5.6,
                    child: Text(
                      widget.time,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: widget.realReceiverId != widget.senderId
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF444444),
                          fontSize: 8),
                    ),
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Row(
              //       children: [
              //         Image.asset("assets/images/sender_mark.png"),
              //         const SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           "18pm",
              //           style:
              //               TextStyle(color: Color(0xFFFFFFFF), fontSize: 10),
              //         )
              //       ],
              //     )
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
