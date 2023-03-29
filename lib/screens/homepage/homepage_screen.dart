// ignore_for_file: avoid_print

import 'dart:io';

// import 'package:badges/badges.dart';
import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:findcribs/controller/connectivity_controller.dart';
import 'package:findcribs/controller/moment_socket_controller.dart';
import 'package:findcribs/controller/story_list_controller.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:findcribs/util/social_login.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import 'package:findcribs/models/notification_model.dart';
import 'package:findcribs/models/story_list_model.dart';
import 'package:findcribs/screens/homepage/each_story.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:findcribs/screens/homepage/single_property.dart';
import 'package:findcribs/screens/listing_screen/apartment.dart';
import 'package:findcribs/screens/listing_screen/coming_soon.dart';
import 'package:findcribs/screens/listing_screen/duplex_screen.dart';
import 'package:findcribs/screens/listing_screen/estate_market.dart';
import 'package:findcribs/screens/listing_screen/terrace_screen.dart';
import 'package:findcribs/screens/notification_screen/notification_screen.dart';
import 'package:findcribs/screens/search_screen/search.dart';
import 'package:findcribs/screens/story_screen/story_base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/get_property_listing_controller.dart';
import '../../service/notification_all_service.dart';
// ignore: library_prefixes

import '../favourite_screen/all_agent/all_agent.dart';
import '../notification_screen/get_all_notificaton_controller.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String category = 'All';
  late Future<List<StoryListModel>> storyList;
  List<StoryListModel> firstStoryList = [];
  List<StoryListModel> filteredStoryList = [];

  late Future<List<NotificationModel>> notificationList;
  List<NotificationModel> filteredNotificationList = [];
  List<NotificationModel> filteredUnreadNotificationList = [];
  late ScrollController controller;

  handleGetNotification() {
    notificationList = getAllNotification();
    notificationList.then((value) {
      setState(() {
        filteredNotificationList = value;
        filteredUnreadNotificationList = filteredNotificationList
            .where((element) => element.isRead == false)
            .toList();
      });
    });
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
           getPropertyListingController.loadMore();

    }

    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    double delta = 200.0; // or something else..
    if (maxScroll - currentScroll <= delta) {
      // whatever you determine here
      //.. load more
    }
  }

  @override
  void initState() {
    super.initState();
    // // handleGetNotification();
    // handleGetProperties(page);
    // // handleGetStory();
    // // _controller = ScrollController()..addListener(_loadMore);
    controller = ScrollController();
    controller.addListener(_scrollListener);
    // _controller.addListener();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  GetStoryListController getStoryListController =
      Get.put(GetStoryListController());

  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());

  GetAllNotificationController getAllNotificationController =
      Get.put(GetAllNotificationController());
  MomentSocketController momentSocketController =
      Get.put(MomentSocketController());

  GetPropertyListingController getPropertyListingController =
      Get.put(GetPropertyListingController());
  @override
  Widget build(BuildContext context) {
    print("rebuild homescreen widget");
    return Scaffold(
      // bottomNavigationBar:
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
            : Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      // handleGetStory();
                      // handleGetPropertiesReferesh(page);
                      // userFavouritedListingController
                      //     .handleGetFavouritedListing();
                      // getAllNotificationController.handleGetNotification();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return HomePageRoot(navigateIndex: 0);
                      }));
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "FindCribs",
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Search_Screen()));
                                    },
                                    child: const Icon(Icons.search)),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                    onTap: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      final token = prefs.getString('token');
                                      token == null
                                          ? showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const SocialLogin();
                                              })
                                          : Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NotificationScreen()));
                                    },
                                    child: getAllNotificationController
                                            .allNotificationList.isEmpty
                                        ? const Icon(
                                            Icons.notifications_none_outlined)
                                        : Badge(
                                            toAnimate: false,
                                            animationDuration: const Duration(
                                                milliseconds: 500),
                                            badgeContent: Text(
                                              getAllNotificationController
                                                  .allNotificationList.length
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            elevation: 1,
                                            position:
                                                BadgePosition.topEnd(top: -20),
                                            child: const Icon(Icons
                                                .notifications_none_outlined))),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    token == null
                                        ? showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const SocialLogin();
                                            })
                                        :

                                        //  Navigator.push(context,
                                        //     MaterialPageRoute(builder: (_) {
                                        //     return const CreateNetworkScreen();
                                        //   }));
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                            return const AllAgent();
                                          }));
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFF0072BA)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const Text(
                                    "Pick a favourite",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            getStoryListController.allStoryList.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(const StoryBaseScreen(
                                          moment: [],
                                          profileImg: '',
                                          agentId: 1,
                                          type: 'findcribs'));
                                    },
                                    child: Column(
                                      children: [
                                        DottedBorder(
                                          borderType: BorderType.Oval,
                                          color: Colors.blue,
                                          strokeWidth: 1.5,
                                          strokeCap: StrokeCap.round,
                                          padding: const EdgeInsets.all(2),
                                          child: SizedBox(
                                            width: 70,
                                            height: 70,
                                            child: ClipOval(
                                                child: Image.asset(
                                                    "assets/images/logo.png")),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "FindCribs",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 95,
                              child: ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: getStoryListController
                                      .allStoryList.length,
                                  itemBuilder: (context, index) {
                                    String fileExtension = p.extension(File(
                                            getStoryListController
                                                .allStoryList[index]
                                                .moment!
                                                .last['mediaUrl']
                                                .toString())
                                        .path);
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return StoryBaseScreen(
                                                  type: 'individuals',
                                                  agentId:
                                                      getStoryListController
                                                          .allStoryList[index]
                                                          .id,
                                                  profileImg:
                                                      getStoryListController
                                                          .allStoryList[index]
                                                          .profilePic
                                                          .toString(),
                                                  moment: getStoryListController
                                                      .allStoryList[index]
                                                      .moment!
                                                      .toList(),
                                                );
                                              }));
                                            },
                                            child: EachStory(
                                              type: fileExtension,
                                              firstName: getStoryListController
                                                  .allStoryList[index].firstName
                                                  .toString(),
                                              lastName: getStoryListController
                                                  .allStoryList[index].lastName
                                                  .toString(),
                                              fileName: getStoryListController
                                                  .allStoryList[index]
                                                  .moment!
                                                  .last['mediaUrl'],
                                            )),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Obx(
                          () => ListView(
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            cacheExtent: 100,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 20, right: 20),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Get.to(ExternalDirScreen());
                                      },
                                      child: Row(
                                        children: const [
                                          Text(
                                            "Categories",
                                            style: TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 0,
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 220,

                                                    // color: Colors.amber,

                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x00e5e5e5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFFE6E6E6),
                                                        )),

                                                    child: Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15.0),
                                                            child: Container(
                                                              width: 80,
                                                              height: 5,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFE6E6E6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                          ),
                                                          FormBuilder(
                                                            child:
                                                                FormBuilderRadioGroup(
                                                              name: 'duplex',
                                                              wrapDirection:
                                                                  Axis.vertical,
                                                              orientation:
                                                                  OptionsOrientation
                                                                      .vertical,
                                                              onChanged: (e) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (_) {
                                                                      return DuplexScreen(
                                                                        duplexType:
                                                                            e.toString(),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              controlAffinity:
                                                                  ControlAffinity
                                                                      .leading,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                              ),
                                                              options: [
                                                                "Detached Duplex",
                                                                "Semi Duplex",
                                                                "Duplex Bungalow",
                                                              ]
                                                                  .map((e) =>
                                                                      FormBuilderFieldOption(
                                                                        value:
                                                                            e,
                                                                        child:
                                                                            Text(e),
                                                                      ))
                                                                  .toList(
                                                                      growable:
                                                                          false),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Duplex",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/category1.png",
                                                      scale: 6.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 280,

                                                    // color: Colors.amber,

                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x00e5e5e5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFFE6E6E6),
                                                        )),

                                                    child: Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15.0),
                                                            child: Container(
                                                              width: 80,
                                                              height: 5,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFE6E6E6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                          ),
                                                          FormBuilder(
                                                            child:
                                                                FormBuilderRadioGroup(
                                                              name: 'apartment',
                                                              wrapDirection:
                                                                  Axis.vertical,
                                                              orientation:
                                                                  OptionsOrientation
                                                                      .vertical,
                                                              onChanged: (e) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (_) {
                                                                      return ApartmentScreen(
                                                                        apartmentType:
                                                                            e.toString(),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              controlAffinity:
                                                                  ControlAffinity
                                                                      .leading,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                              ),
                                                              options: [
                                                                "Flats",
                                                                "Shortlet",
                                                                "Service apartment",
                                                                "Self-contained"
                                                              ]
                                                                  .map((e) =>
                                                                      FormBuilderFieldOption(
                                                                        value:
                                                                            e,
                                                                        child:
                                                                            Text(e),
                                                                      ))
                                                                  .toList(
                                                                      growable:
                                                                          false),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Apartments",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/category3.png",
                                                      scale: 6.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return const TerraceScreen();
                                              }));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Terrace",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/category2.png",
                                                      scale: 5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return const ComingSoon();
                                              }));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Hotels",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/category4.png",
                                                      scale: 5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return const EstateMarketScreen();
                                              }));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 68,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Estate Market",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/estatemarket.png",
                                                      scale: 1.6,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return const ComingSoon();
                                              }));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00e5e5e5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE6E6E6),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Land",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF455A64),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'RedHatDisplay',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "assets/images/land.png",
                                                      scale: 15,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Featured",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 160,

                                              // color: Colors.amber,

                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),

                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0),
                                                      child: Container(
                                                        width: 80,
                                                        height: 5,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFFE6E6E6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                    FormBuilder(
                                                      child:
                                                          FormBuilderRadioGroup(
                                                        name: 'sale',
                                                        initialValue: category,
                                                        wrapDirection:
                                                            Axis.horizontal,
                                                        orientation:
                                                            OptionsOrientation
                                                                .horizontal,
                                                        controlAffinity:
                                                            ControlAffinity
                                                                .leading,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            category = value
                                                                .toString();
                                                          });
                                                        },
                                                        options: [
                                                          "All",
                                                          "Sale",
                                                          "Rent",
                                                        ]
                                                            .map((e) =>
                                                                FormBuilderFieldOption(
                                                                  value: e,
                                                                  child:
                                                                      Text(e),
                                                                ))
                                                            .toList(
                                                                growable:
                                                                    false),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              category,
                                              style: const TextStyle(
                                                  fontFamily: 'RedHatDisplay',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10),
                                            ),
                                            const Icon(
                                              CupertinoIcons.arrow_up_down,

                                              size: 11,

                                              // color: Color(0XFFE5E5E5),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              getPropertyListingController.isLoading.isTrue
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CollectionSlideTransition(
                                            children: const <Widget>[
                                              CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                radius: 6,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : getPropertyListingController
                                          .filteredList.isEmpty
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  "assets/images/opps.png"),
                                              const Text(
                                                "Opps!",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 35),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              const Text("No Item Available"),
                                            ],
                                          ),
                                        )
                                      : Obx(
                                          () => ListView.builder(
                                              physics: const ScrollPhysics(),
                                              // controller: _controller,
                                              shrinkWrap: true,
                                              // reverse: true,
                                              itemCount:
                                                  getPropertyListingController
                                                      .filteredList.length,
                                              itemBuilder: ((context, index) {
                                                int price =
                                                    (getPropertyListingController
                                                        .filteredList[index]
                                                        .rentalFee!
                                                        .toInt()
                                                    //  +
                                                    // getPropertyListingController.filteredList[index].agencyFee!.toInt()
                                                    );
                                                var formatter =
                                                    NumberFormat("#,###");
                                                var formatedPrice =
                                                    formatter.format(price);
                                                return SingleProperty(
                                                  id: getPropertyListingController
                                                      .filteredList[index].id,
                                                  image:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .image,
                                                  designType:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .designType,
                                                  currency:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .currency,
                                                  propertyType:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .propertyType,
                                                  propertyAddress:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .propertyAddress,
                                                  bedroom:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .bedroom,
                                                  propertyCategory:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .propertyCategory,
                                                  price: formatedPrice,
                                                  isPromoted:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .isPromoted,
                                                  propertyName:
                                                      getPropertyListingController
                                                          .filteredList[index]
                                                          .propertyName
                                                          .toString(),
                                                          comingFrom: 'Homescreen',
                                                );
                                              })),
                                        ),
                              if (getPropertyListingController
                                  .isLoadMoreRunning.isTrue)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 80),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CollectionSlideTransition(
                                          children: const <Widget>[
                                            CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 6,
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 6,
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.yellow,
                                              radius: 6,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
