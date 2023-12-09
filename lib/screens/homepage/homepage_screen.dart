// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';
import 'package:badges/badges.dart' as badges;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:findcribs/controller/connectivity_controller.dart';
import 'package:findcribs/controller/moment_socket_controller.dart';
import 'package:findcribs/controller/story_list_controller.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/util/social_login.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path/path.dart' as p;
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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/get_notification_controller.dart';
// ignore: library_prefixes

import '../../service/all_property_listing.dart';
import '../../service/property_by_category.dart';
import '../../util/colors.dart';
import '../../widgets/loading_widget.dart';
import '../favourite_screen/all_agent/all_agent.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  late Future<List<StoryListModel>> storyList;
  List<StoryListModel> firstStoryList = [];
  List<StoryListModel> filteredStoryList = [];
  late ScrollController controller;

  AllPropertyListingController houseController =
      Get.put(AllPropertyListingController());

  HouseByCategoryController house_controller =
      Get.put(HouseByCategoryController());

  handleFilter() {
    houseController.isFiltering.value = true;
    houseController.categoryPagingController.itemList!.clear();
    houseController.fetchPosts(1);
  }

  @override
  void initState() {
    print("homescreen init");
    houseController.fetchPosts(1);
    super.initState();
    // _controller.addListener();
  }

  @override
  void dispose() {
    houseController.handleReset();
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

  @override
  Widget build(BuildContext context) {
    print("rebuild homescreen widget");
    return Scaffold(
      // bottomNavigationBar:
      // backgroundColor: context.isDarkMode ? black : white,
      body: Obx(
        // ignore: unrelated_type_equality_checks
        () => connectivityController.connectionStatus == ConnectivityResult.none
            ? Center(
                child: GestureDetector(
                onTap: () {
                  Get.to(const HomePageRoot(
                    navigateIndex: 0,
                  ));
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
                    houseController.isFiltering.value = true;
                    houseController.categoryPagingController.itemList!.clear();
                    houseController.fetchPosts(0);
                    houseController.handleReset();
                    await Future.delayed(const Duration(seconds: 2));
                    // Get.off(const HomePageRoot(
                    //   navigateIndex: 0,
                    // ));
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
                                        : badges.Badge(
                                            badgeContent: Text(
                                              getAllNotificationController
                                                  .allNotificationList.length
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -20),
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
                        // height: 300,
                        child: houseController.isFiltering.isTrue
                            ? loadingWidget()
                            : PagedListView<int, HouseListModel>(
                                pagingController:
                                    houseController.categoryPagingController,
                                // physics: NeverScrollableScrollPhysics(),

                                builderDelegate:
                                    PagedChildBuilderDelegate<HouseListModel>(
                                  animateTransitions: false,
                                  itemBuilder: (context, post, index) {
                                    int price = (post.rentalFee!.toInt());
                                    var formatter = NumberFormat("#,###");
                                    var formatedPrice = formatter.format(price);
                                    return Column(
                                      children: [
                                        index == 0
                                            ? SizedBox(
                                                height: 310,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 8.0,
                                                              left: 20,
                                                              right: 20),
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
                                                                      fontFamily:
                                                                          'RedHatDisplay',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
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
                                                    SizedBox(
                                                      height: 170,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
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
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                220,

                                                                            // color: Colors.amber,

                                                                            decoration: BoxDecoration(
                                                                                color: const Color(0x00e5e5e5),
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(
                                                                                  color: const Color(0xFFE6E6E6),
                                                                                )),

                                                                            child:
                                                                                Center(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(top: 15.0),
                                                                                    child: Container(
                                                                                      width: 80,
                                                                                      height: 5,
                                                                                      decoration: BoxDecoration(color: const Color(0xFFE6E6E6), borderRadius: BorderRadius.circular(5)),
                                                                                    ),
                                                                                  ),
                                                                                  FormBuilder(
                                                                                    child: FormBuilderRadioGroup(
                                                                                      name: 'duplex',
                                                                                      wrapDirection: Axis.vertical,
                                                                                      orientation: OptionsOrientation.vertical,
                                                                                      onChanged: (e) {
                                                                                        house_controller.category.value = e.toString();
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (_) {
                                                                                              return DuplexScreen(
                                                                                                duplexType: e.toString(),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      controlAffinity: ControlAffinity.leading,
                                                                                      decoration: const InputDecoration(
                                                                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                                      ),
                                                                                      options: [
                                                                                        "Detached Duplex",
                                                                                        "Semi Duplex",
                                                                                        "Duplex Bungalow",
                                                                                      ]
                                                                                          .map((e) => FormBuilderFieldOption(
                                                                                                value: e,
                                                                                                child: Text(e),
                                                                                              ))
                                                                                          .toList(growable: false),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      height:
                                                                          68,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Duplex",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                280,

                                                                            // color: Colors.amber,

                                                                            decoration: BoxDecoration(
                                                                                color: const Color(0x00e5e5e5),
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(
                                                                                  color: const Color(0xFFE6E6E6),
                                                                                )),

                                                                            child:
                                                                                Center(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(top: 15.0),
                                                                                    child: Container(
                                                                                      width: 80,
                                                                                      height: 5,
                                                                                      decoration: BoxDecoration(color: const Color(0xFFE6E6E6), borderRadius: BorderRadius.circular(5)),
                                                                                    ),
                                                                                  ),
                                                                                  FormBuilder(
                                                                                    child: FormBuilderRadioGroup(
                                                                                      name: 'apartment',
                                                                                      wrapDirection: Axis.vertical,
                                                                                      orientation: OptionsOrientation.vertical,
                                                                                      onChanged: (e) {
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (_) {
                                                                                              house_controller.category.value = e.toString();
                                                                                              return ApartmentScreen(
                                                                                                apartmentType: e.toString(),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      controlAffinity: ControlAffinity.leading,
                                                                                      decoration: const InputDecoration(
                                                                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                                      ),
                                                                                      options: [
                                                                                        "Flats",
                                                                                        "Shortlet",
                                                                                        "Service apartment",
                                                                                        "Self-contained"
                                                                                      ]
                                                                                          .map((e) => FormBuilderFieldOption(
                                                                                                value: e,
                                                                                                child: Text(e),
                                                                                              ))
                                                                                          .toList(growable: false),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      height:
                                                                          68,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Apartments",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                                      house_controller
                                                                          .category
                                                                          .value = 'terrace';
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (_) {
                                                                        return const TerraceScreen();
                                                                      }));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      height:
                                                                          68,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Terrace",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (_) {
                                                                        return const ComingSoon();
                                                                      }));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      height:
                                                                          68,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Hotels",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                                      house_controller
                                                                          .category
                                                                          .value = 'Estate Market';
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (_) {
                                                                        return const EstateMarketScreen();
                                                                      }));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      height:
                                                                          68,
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Estate Market",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (_) {
                                                                        return const ComingSoon();
                                                                      }));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2.5,
                                                                      height:
                                                                          68,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(0x00e5e5e5),
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          border: Border.all(
                                                                            color:
                                                                                grey,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Land Title",
                                                                            style: TextStyle(
                                                                                color: context.isDarkMode ? white : Color(0xFF455A64),
                                                                                fontSize: 14,
                                                                                fontFamily: 'RedHatDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            child:
                                                                                Image.asset(
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
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Featured",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'RedHatDisplay',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet<
                                                                  void>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                    height: 160,

                                                                    // color: Colors.amber,

                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),

                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15.0),
                                                                            child:
                                                                                Container(
                                                                              width: 80,
                                                                              height: 5,
                                                                              decoration: BoxDecoration(color: const Color(0xFFE6E6E6), borderRadius: BorderRadius.circular(5)),
                                                                            ),
                                                                          ),
                                                                          FormBuilder(
                                                                            child:
                                                                                FormBuilderRadioGroup(
                                                                              name: 'sale',
                                                                              initialValue: houseController.propertyType.value,
                                                                              wrapDirection: Axis.horizontal,
                                                                              orientation: OptionsOrientation.horizontal,
                                                                              controlAffinity: ControlAffinity.leading,
                                                                              decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  houseController.propertyType.value = value.toString();
                                                                                  handleFilter();
                                                                                });
                                                                              },
                                                                              options: [
                                                                                "All",
                                                                                "Sale",
                                                                                "Rent",
                                                                              ]
                                                                                  .map((e) => FormBuilderFieldOption(
                                                                                        value: e,
                                                                                        child: Text(e),
                                                                                      ))
                                                                                  .toList(growable: false),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                border:
                                                                    Border.all(
                                                                  color: grey,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    houseController
                                                                        .propertyType
                                                                        .value,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'RedHatDisplay',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                  const Icon(
                                                                    CupertinoIcons
                                                                        .arrow_up_down,

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
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        SingleProperty(
                                            state: post.state!,
                                            isPromoted: post.isPromoted,
                                            id: post.id,
                                            image: post.image,
                                            designType: post.designType,
                                            currency: post.currency,
                                            propertyType: post.propertyType,
                                            propertyAddress:
                                                post.propertyAddress,
                                            bedroom: post.bedroom,
                                            propertyCategory:
                                                post.propertyCategory,
                                            price: formatedPrice,
                                            propertyName:
                                                post.propertyName.toString(),
                                            comingFrom: 'Homescreen')
                                      ],
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder: (context) =>
                                      Text('No posts found.'),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
