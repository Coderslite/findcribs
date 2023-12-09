// ignore_for_file: library_prefixes, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
import 'package:findcribs/controller/connectivity_controller.dart';
import 'package:findcribs/controller/get_profile_controller.dart';
import 'package:findcribs/controller/home_root_controller.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/screens/agent_profile/profile.dart';
import 'package:findcribs/screens/chat_screen/chat_screen.dart';
import 'package:findcribs/screens/favourite_screen/favourite_page.dart';
import 'package:findcribs/screens/homepage/homepage_screen.dart';
import 'package:findcribs/screens/listing_process/get_started.dart';
import 'package:findcribs/screens/listing_process/listing/select_listing_type.dart';
import 'package:findcribs/screens/story/story_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import '../../controller/get_chat_controller.dart';
import '../../main.dart';
import '../../models/user_profile_information_model.dart';
import '../../util/colors.dart';
import '../../util/social_login.dart';
import '../agent_profile/components/personal_info/personal_information.dart';

class HomePageRoot extends StatefulWidget {
  final int navigateIndex;
  const HomePageRoot({
    Key? key,
    required this.navigateIndex,
  }) : super(key: key);

  @override
  State<HomePageRoot> createState() => _HomePageRootState();
}

class _HomePageRootState extends State<HomePageRoot> {
  bool isLoading = false;

  final tooltipController = JustTheController();

  List<ChatMessageModel> filteredMessageByTime = [];
  late Future<List<ChatMessageModel>> getChat;
  List<ChatMessageModel> messageList = [];
  int unreadMessages = 0;
  late Future<UserProfile> userProfile;
  late StreamSubscription<bool> subscription;

  int? myId;
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  String notificationMsg = "Waiting for notifications";
  GetAllChatController getAllChatController = Get.put(GetAllChatController());
  GetProfileController getProfileController = Get.put(GetProfileController());
  HomeRootController homeRootController = Get.put(HomeRootController());
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
      print(event.messageType);
      print("foreground");
    });

    Timer(const Duration(seconds: 5), () {
      handleCheckNumber();
    });
  }

  handleCheckNumber() {
    if (getProfileController.phoneNumber.string == 'null' &&
        getProfileController.isLoading.isFalse) {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.warning,
        borderSide: const BorderSide(
          color: Colors.yellow,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: 'You haven\'t updated your phone number',
        showCloseIcon: true,
        btnOkText: "Update now",
        btnOkOnPress: () {
          Get.off(const PersonalInformationScreen());
        },
      ).show();
    } else {}
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: JustTheTooltip(
          controller: tooltipController,
          isModal: true,
          borderRadius: BorderRadius.circular(20),
          curve: Curves.easeInOutCirc,
          tailBaseWidth: 20,
          tailLength: 10,
          content: SizedBox(
            height: 100,
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    homeRootController.isToolTip.value = false;
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
                    homeRootController.isToolTip.value = false;
                    tooltipController.hideTooltip().then((v) =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
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
                            color: blue,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: blue,
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
              token == null
                  ? showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const SocialLogin();
                      })
                  : getProfileController.agent.string == 'null' ||
                          getProfileController.agent.string == '{}'
                      ? handleGetStarted()
                      : homeRootController.isToolTip.isTrue
                          ? tooltipController.hideTooltip()
                          : tooltipController.showTooltip();
            },
            child: const Material(
              color: blue,
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
            showIgnore: false,
            showLater: false,
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
            durationUntilAlertAgain: const Duration(minutes: 1),
          ),
          child: SafeArea(
            child: getBody(),
          ),
        ),
      ),
    );
  }

  getBody() {
    List<Widget> pages = [
      const HomepageScreen(),
      const FavouritePageScreen(),
      Container(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
    return Obx(
      () => IndexedStack(
        index: homeRootController.index.toInt(),
        children: pages,
      ),
    );
  }

  getFooter(size) {
    List bottomItems = [
      "assets/svgs/home.svg",
      "assets/svgs/love.svg",
      "assets/svgs/blank.svg",
      "assets/svgs/chat_active.svg",
      "assets/svgs/account_icon.svg"
    ];

    return Obx(
      () => Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(),
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
                        homeRootController.selectedTab(index);
                      },
                      child: index == 3
                          ? getAllChatController.filteredUnreadMessage.isEmpty
                              ? SizedBox(
                                  width: size.width / 7,
                                  child: SvgPicture.asset(
                                    bottomItems[index],
                                    width: 25,
                                    color:
                                        index == homeRootController.index.value
                                            ? blue
                                            : context.isDarkMode
                                                ? white
                                                : lightBlue,
                                  ),
                                )
                              : SizedBox(
                                  width: size.width / 7,
                                  child: badges.Badge(
                                    badgeContent: Text(getAllChatController
                                        .filteredUnreadMessage.length
                                        .toString()),
                                    child: SvgPicture.asset(
                                      bottomItems[index],
                                      width: 25,
                                      color: index ==
                                              homeRootController.index.value
                                          ? blue
                                          : context.isDarkMode
                                              ? white
                                              : lightBlue,
                                    ),
                                  ),
                                )
                          : SizedBox(
                              width: size.width / 7,
                              child: SvgPicture.asset(
                                bottomItems[index],
                                width: 25,
                                color: index == homeRootController.index.value
                                    ? blue
                                    : context.isDarkMode
                                        ? white
                                        : lightBlue,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleGetStarted() async {
    print("handling get started");
    if (getProfileController.agent.string == 'null' ||
        getProfileController.agent.string == '{}') {
      Get.to(const GetStarted());
    } else {
      Get.to(const SelectListingType());
    }
  }
}
