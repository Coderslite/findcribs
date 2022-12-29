// ignore_for_file: library_prefixes, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/connectivity_controller.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/screens/agent_profile/profile.dart';
import 'package:findcribs/screens/chat_screen/chat_screen.dart';
import 'package:findcribs/screens/favourite_screen/favourite_page.dart';
import 'package:findcribs/screens/homepage/homepage_screen.dart';
import 'package:findcribs/screens/listing_process/get_started.dart';
import 'package:findcribs/screens/listing_process/listing/listing.dart';
import 'package:findcribs/screens/story/story_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:upgrader/upgrader.dart';

import '../../controller/get_chat_controller.dart';
import '../../main.dart';
import '../../models/user_profile_information_model.dart';
import '../../service/user_profile_service.dart';
import '../../util/social_login.dart';

// ignore: must_be_immutable
class HomePageRoot extends StatefulWidget {
  int navigateIndex;
  HomePageRoot({
    Key? key,
    required this.navigateIndex,
  }) : super(key: key);

  @override
  State<HomePageRoot> createState() => _HomePageRootState();
}

class _HomePageRootState extends State<HomePageRoot> {
  int pageIndex = 0;
  bool isLoading = false;
//  navigateIndex == null ? int pageIndex = 0:pageIndex = navigateIndex;
  final tooltipController = JustTheController();
  bool isToolTip = false;

  late Socket socket;
  List online = [];
  List<ChatMessageModel> filteredMessageByTime = [];
  late Future<List<ChatMessageModel>> getChat;
  List<ChatMessageModel> messageList = [];
  int unreadMessages = 0;
  late Future<UserProfile> userProfile;
  bool isAgent = false;
  late StreamSubscription<bool> subscription;

  int? myId;
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  String notificationMsg = "Waiting for notifications";
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  bool isShowFloatButton = true;

  handleKeyboardDetect(bool event) async {
    if (mounted) {
      if (event) {
        setState(() {
          isShowFloatButton = false;
        });
      } else {
        setState(() {
          isShowFloatButton = true;
        });
      }
    }
  }

  @override
  void initState() {
    // Fluttertoast.showToast(msg: message.notification!.title.toString());

    handleGetProfile();
    handleConnect();
    subscription = KeyboardVisibilityController().onChange.listen((event) {
      handleKeyboardDetect(event);
    });

    super.initState();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then(
          (event) {},
        );

    // Foregrand State
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      getAllChatController.handleGetMessage();
      showFlutterNotification(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }

  handleGetProfile() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      userProfile = getUserProfile();
      userProfile.then((value) {
        if (value.agent == null) {
          setState(() {
            myId = value.id;
            isAgent = false;
            prefs.setBool('isAgent', false);
            getAllChatController.handleGetMessage();
          });
        } else {
          setState(() {
            myId = value.id;
            isAgent = true;
            prefs.setBool('isAgent', true);
            getAllChatController.handleGetMessage();
          });
        }
      });
    });
  }

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
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
      setState(() {
        getAllChatController.handleGetMessage();
      });
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
    socket.on("MESSAGE", (data) {
      setState(() {
        setState(() {
          getAllChatController.handleGetMessage();
        });
      });
    });
    socket.on("MESSAGE_SENT", (data) {
      print("message sent successfully");
      setState(() {
        getAllChatController.handleGetMessage();
      });
    });

    socket.on("MESSAGES", (data) {
      setState(() {
        setState(() {
          getAllChatController.handleGetMessage();
        });
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

  bool willPop = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (willPop) {
          return true;
        } else {
          Fluttertoast.showToast(msg: "Press again to exit app");
          setState(() {
            willPop = true;
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
          return false;
        }
      },
      child: Scaffold(
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: isShowFloatButton == false
              ? Container()
              : JustTheTooltip(
                  controller: tooltipController,
                  isModal: true,
                  borderRadius: BorderRadius.circular(20),
                  curve: Curves.easeInOutCirc,
                  tailBaseWidth: 20,
                  tailLength: 10,
                  // margin: const EdgeInsets.only(left: 90, right: 90, bottom: 70),
                  content: SizedBox(
                    height: 100,
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isToolTip = false;
                            });
                            tooltipController.hideTooltip().then((value) {
                              handleGetStarted();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/list_property.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("List a property")
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isToolTip = false;
                            });
                            tooltipController.hideTooltip().then((v) =>
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const StoryList();
                                })));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                margin: const EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0XFF0072BA),
                                      width: 2,
                                    )),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Color(0XFF0072BA),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Post a story"),
                              Expanded(child: Container())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token');
                      final isagent = prefs.getBool('isAgent');
                      token == null
                          ? showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return const SocialLogin();
                              })
                          : isagent == true || isAgent == true
                              ? isToolTip
                                  ? tooltipController.hideTooltip()
                                  : tooltipController.showTooltip()
                              : handleGetStarted();
                    },
                    child: const Material(
                      color: Color(0XFF0072BA),
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: getFooter(size),
          body: UpgradeAlert(
            upgrader: Upgrader(
              canDismissDialog: true,
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              durationUntilAlertAgain: const Duration(days: 1),
            ),
            child: SafeArea(
              child: isLoading
                  ? Center(
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
                    )
                  : getBody(),
            ),
          )),
    );
  }

  getBody() {
    List<Widget> pages = [
      const HomepageScreen(),
      const FavouritePageScreen(),
      // const HomepageScreen(),
      const HomepageScreen(),
      const ChatScreen(),
      // const ChatSocket(),
      // const ProfileScreen(),
      const ProfileScreen(),
    ];
    return IndexedStack(
      index: widget.navigateIndex,
      children: pages,
    );
  }

  getFooter(size) {
    List bottomItems = [
      widget.navigateIndex == 0
          ? "assets/svgs/home_active.svg"
          : "assets/svgs/home.svg",
      widget.navigateIndex == 1
          ? "assets/svgs/love_active.svg"
          : "assets/svgs/love.svg",
      widget.navigateIndex == 2
          ? "assets/svgs/blank.svg"
          : "assets/svgs/blank.svg",
      widget.navigateIndex == 3
          ? "assets/svgs/chat_active.svg"
          : "assets/svgs/chat2.svg",
      widget.navigateIndex == 4
          ? "assets/svgs/account_icon.svg"
          : "assets/svgs/account.svg",
    ];

    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 0.4,
              decoration: const BoxDecoration(
                color: Color(0xFFBDBDBD),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                bottomItems.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      selectedTab(index);
                    },
                    child: index == 3
                        ? getAllChatController.filteredUnreadMessage.isEmpty
                            ? SizedBox(
                                width: size.width / 7,
                                child: SvgPicture.asset(
                                  bottomItems[index],
                                  width: 25,
                                ),
                              )
                            : SizedBox(
                                width: size.width / 7,
                                child: Badge(
                                  badgeContent: Text(getAllChatController
                                      .filteredUnreadMessage.length
                                      .toString()),
                                  child: SvgPicture.asset(
                                    bottomItems[index],
                                    width: 25,
                                  ),
                                ),
                              )
                        : SizedBox(
                            width: size.width / 7,
                            child: SvgPicture.asset(
                              bottomItems[index],
                              width: 25,
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectedTab(index) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    token == null && index > 0
        ? showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const SocialLogin();
            })
        : setState(() {
            widget.navigateIndex = index;
          });
  }

  handleGetStarted() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    var response = await http.get(Uri.parse("$baseUrl/profile"), headers: {
      "Authorization": "$token",
    });
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      setState(() {
        isLoading = false;
      });
      var responseData = jsonResponse['data']['profile'];
      if (responseData['agent'] != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ListPropertyScreen1(tab: 0);
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const GetStarted();
        }));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }
}
