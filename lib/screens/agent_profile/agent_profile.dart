// ignore_for_file: library_prefixes, duplicate_ignore, avoid_print, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/controller/user_favorited_agent_controller.dart';
import 'package:findcribs/main.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/screens/agent_profile/agent_profile_listing.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/product_details/photo_view_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:socket_io_client/socket_io_client.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart' as launchUrl;
import 'package:http/http.dart' as http;

import '../../components/constants.dart';
import '../../controller/get_chat_controller.dart';
import '../../controller/user_favourited_listing_controller.dart';
import '../../models/user_favourite_agent.dart';
import '../../service/favourited_agent_service.dart';

class AgentProfileScreen extends StatefulWidget {
  final int? userId;
  final int? propertyId;
  const AgentProfileScreen({
    super.key,
    this.userId,
    this.propertyId,
  });

  @override
  AgentProfileScreenState createState() => AgentProfileScreenState();
}

class AgentProfileScreenState extends State<AgentProfileScreen> {
  var messageController = TextEditingController();
  String message = '';
  late Socket socket;
  bool isLiked = false;
  UserFavoritedAgentController userFavoritedAgentController =
      Get.put(UserFavoritedAgentController());

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    socket = IO.io(
        socketUrl,
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': "$token"}) // optional
            .build());
    socket.connect();
    socket.onConnect((data) {
      print("connected");
    });
    socket.onDisconnect((data) => print("disconnected"));
    socket.on(
      "ERROR",
      (data) {
        var errorMessage = jsonDecode(data);
        print("Error ${errorMessage['message']}");
        print(data);
      },
    );

    socket.on("MESSAGE_SENT", (data) {
      print("message sent successfully");
    });
  }

  @override
  void initState() {
    super.initState();
    handleConnect();
    // storyList = getFavouriteStoryList();
    handleFilter();
  }

  handleFilter() {
    var result = userFavoritedAgentController.allAgents
        .where((element) => element.userId == widget.userId)
        .toList();
    if (result.isEmpty) {
      setState(() {
        isLiked = false;
      });
    } else {
      setState(() {
        isLiked = true;
      });
    }
  }

  UserFavoritedAgentController userFavouritedAgentController =
      Get.put(UserFavoritedAgentController());

  handleFavouriteAgent() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.post(
      Uri.parse("$baseUrl/agent/favourite/${widget.userId}"),
      headers: {"Authorization": "$token"},
    );
    jsonDecode(response.body);
    userFavouritedAgentController.handleGetAllAgents(id: widget.userId);
  }

  GetAllChatController getAllChatController = Get.put(GetAllChatController());

  handleSendMessage(
      String chatMessage, int? receiverId, int? propertyId) async {
    getAllChatController.handleGetMessage();
    // print(widget.receiverId);
    var messageMap = {
      "clientMesgId": UniqueKey().toString(),
      "mesgType": "text",
      "receiverId": receiverId,
      "message": chatMessage,
      "propertyId": propertyId,
      "sentAt": DateTime(2022).toString(),
    };
    print(messageMap);
    socket.emit('MESSAGE', messageMap);
    messageController.clear();
    setState(() {
      message = '';
    });
    Fluttertoast.showToast(msg: "Message Sent");
  }

  @override
  void dispose() {
    userFavouritedAgentController.handleGetAllAgents();
    getAllChatController.handleGetMessage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserProfile>(
            future: agentService.getUserById(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("You Don't have an account"));
              }
              if (snapshot.hasData) {
                var userData = snapshot.data!;
                // print(userData.profileImg);

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 40,
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //             color: const Color(0xFFF0F7F8),
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             Navigator.pop(context);
                      //           },
                      //           child: const Icon(Icons.arrow_back_ios),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0XFFF0F7F8),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                    "assets/svgs/arrow_back.svg"),
                              ),
                            ),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(fontSize: size.width / 22),
                          ),
                          const Text(""),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  var images = [];
                                  userData.profileImg == null
                                      ? images.add(
                                          'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg')
                                      : images
                                          .add(userData.profileImg.toString());
                                  print(images.length);
                                  Get.to(PhotoPreview(
                                    businessName: '',
                                    images: images,
                                    profilePreview: true,
                                  ));
                                },
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 126,
                                    height: 126,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            JumpingDotsProgressIndicator(
                                      fontSize: 20.0,
                                      color: Colors.blue,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl: userData.profileImg == null
                                        ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                        : userData.profileImg.toString(),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 100,
                                right: 5,
                                child: userData.agent!['is_verified'] == true
                                    ? Image.asset("assets/images/tick.png")
                                    : Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "@${userData.agent!['business_name']}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        userData.agent!['category'] ?? "Not Identified",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${userData.favouritingAgentCount}",
                                ),
                                const Text(
                                  "Followers",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${userData.favouritedAgentCount}",
                                ),
                                const Text(
                                  "Following",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SalesScreen(
                                      id: int.parse(
                                        widget.userId.toString(),
                                      ),
                                      isVerified:
                                          userData.agent!['is_verified'],
                                      image: userData.profileImg == null
                                          ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                          : userData.profileImg.toString(),
                                      businessName: userData
                                          .agent!['business_name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "${userData.listingCount}",
                                  ),
                                  const Text(
                                    "Listings",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SvgPicture.asset("assets/svgs/star_spur.svg"),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     const Text(
                      //       "4.4 Ratings",
                      //       style: TextStyle(color: Colors.grey),
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "About",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(26, 12, 26, 12),
                        child: Text(
                          userData.agent!['about'],
                          style: const TextStyle(
                              color: Color(0xFF8A99B1),
                              fontSize: 12,
                              height: 1.8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              var phone = userData.agent!['phone_number'];
                              launchUrl.launch("tel:$phone");
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF0072BA),
                                      width: 1)),
                              child: const Icon(
                                Icons.call,
                                color: Color(0xFF0072BA),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                              handleFavouriteAgent();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF0072BA),
                                      width: 1)),
                              child: isLiked
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color(0xFF0072BA),
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Color(0xFF0072BA),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return AnimatedPadding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.decelerate,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        padding: const EdgeInsets.all(10),
                                        child: Wrap(
                                          children: <Widget>[
                                            SizedBox(
                                              // height: 20,
                                              child: TextFormField(
                                                  controller: messageController,
                                                  onChanged: (value) {
                                                    message = value;
                                                  },
                                                  onFieldSubmitted: (value) {
                                                    handleSendMessage(
                                                        messageController.text,
                                                        userData.id,
                                                        widget.propertyId);
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        "Send Message to Seller",
                                                  )),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  handleSendMessage(
                                                      messageController.text,
                                                      userData.id,
                                                      widget.propertyId);
                                                },
                                                child:
                                                    const Text("Send Message")),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFF0072BA),
                                      width: 1)),
                              child: Center(
                                child: SizedBox(
                                  height: 24,
                                  child:
                                      SvgPicture.asset("assets/svgs/chat.svg"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 60,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesScreen(
                                id: int.parse(
                                  widget.userId.toString(),
                                ),
                                isVerified: userData.agent!['is_verified'],
                                image: userData.profileImg == null
                                    ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                    : userData.profileImg.toString(),
                                businessName:
                                    userData.agent!['business_name'].toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 330,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.2))),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset("assets/images/house.png"),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                "All listings",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text(
                                  userData.listingCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 330,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.2))),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset("assets/images/play.png"),
                              const SizedBox(width: 8),
                              const Text(
                                "View Story",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 140,
                              ),
                              Container(
                                width: 30,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text(
                                  userData.storyCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey.withOpacity(0.3))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CollectionSlideTransition(
                      children: const <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 12,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 12,
                        ),
                      ],
                    ),
                    FadingText('Loading...'),
                  ],
                ),
              );
            }),
      ),
    );
  }

  handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('action', '');
    prefs.remove('token');
    prefs.remove('email');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return const LoginScreen();
    }));
  }
}
