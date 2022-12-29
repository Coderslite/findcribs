// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:findcribs/screens/notification_screen/get_all_notificaton_controller.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:findcribs/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GetAllNotificationController getAllNotificationController =
      Get.put(GetAllNotificationController());

  bool isLoading = true;
  late Future<List<NotificationModel>> notificationList;
  List<NotificationModel> filteredNotificationList = [];
  List<NotificationModel> firstList = [];
  List<NotificationModel> filteredUnreadNotificationList = [];
  int page = 1;
  bool _hasNextPage = true;
  late ScrollController _controller;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  // late Future<List<FavouriteStoryListModel>> storyList;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        _loadMore();
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
      });
    }
  }

  handleGetNotification(int page) {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      notificationList = getNotification(page);
      // storyList = getFavouriteStoryList();
      notificationList.then((value) {
        // print(value);
        if (value.isEmpty) {
          setState(() {
            isLoading = false;
            _hasNextPage = false;
            _isLoadMoreRunning = false;
          });
        } else {
          setState(() {
            firstList = value;
            isLoading = false;
            for (int s = 0; s < value.length; s++) {
              filteredNotificationList.add(value[s]);
            }
            filteredUnreadNotificationList = filteredNotificationList
                .where((element) => element.isRead == false)
                .toList();
          });
        }
      });
    }
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        isLoading == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 600) {
      setState(() {
        // Display a progress indicator at the bottom
        _isLoadMoreRunning = true;
        page += 1;
      });
      notificationList = getNotification(page);
      // storyList = getFavouriteStoryList();
      notificationList.then((value) {
        // print(value);
        if (value.isEmpty) {
          setState(() {
            isLoading = false;
            _hasNextPage = false;
            _isLoadMoreRunning = true;
          });
        } else {
          setState(() {
            firstList = value;
            isLoading = false;
            for (int s = 0; s < value.length; s++) {
              filteredNotificationList.add(value[s]);
            }
            filteredUnreadNotificationList = filteredNotificationList
                .where((element) => element.isRead == false)
                .toList();
          });
        }
      });
    } else {
      print("Nothing is loading");
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    handleGetNotification(page);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getAllNotificationController.handleGetNotification();
    super.initState();
  }

  @override
  void dispose() {
    getAllNotificationController.handleGetNotification();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0XFFF0F7F8),
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child:
                                SvgPicture.asset("assets/svgs/arrow_back.svg"),
                          ),
                        ),
                      ),
                      Text(
                        "Notification",
                        style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            fontSize: size.width / 22),
                      ),
                      const Text("            "),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        filteredUnreadNotificationList.isEmpty
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        handleMarkAllRead();
                                      },
                                      child: const Text(
                                        "Mark all as read",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ListView.builder(
                            shrinkWrap: true,
                            // reverse: true,
                            itemCount: filteredNotificationList.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              String usrDate =
                                  (filteredNotificationList[index].createdAt)
                                      .toString();
                              var todayDate = DateTime.parse(usrDate);
                              var notDate =
                                  DateFormat('yyyy-MM-dd').format(todayDate);
                              var notificationTime = timeago.format(todayDate);

                              print(notDate);
                              Duration dur =
                                  DateTime.now().difference(todayDate);
                              String differenceInYears =
                                  (dur.inDays).floor().toString();
                              print(differenceInYears);
                              // return new Text(differenceInYears + ' years');
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return filteredNotificationList[index]
                                                .type ==
                                            'listing'
                                        ? ProductDetails(
                                            id: filteredNotificationList[index]
                                                .refId)
                                        : filteredNotificationList[index]
                                                    .type ==
                                                'chat'
                                            ? HomePageRoot(navigateIndex: 3)
                                            : HomePageRoot(navigateIndex: 0);
                                  })).then((value) => handleNotificationRead(
                                      filteredNotificationList[index].id));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: index < 1
                                          ? Column(
                                              children: [
                                                Text(
                                                  int.parse(differenceInYears) <
                                                          1
                                                      ? "Today"
                                                      : int.parse(differenceInYears) >
                                                                  0 &&
                                                              int.parse(
                                                                      differenceInYears) <
                                                                  2
                                                          ? "Yesterday"
                                                          : notDate,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 38,
                                                ),
                                              ],
                                            )
                                          : (DateTime.now()
                                                      .difference(DateTime.parse(
                                                          filteredNotificationList[
                                                                  index]
                                                              .createdAt
                                                              .toString()))
                                                      .inDays
                                                      .floor()
                                                      .toString()) !=
                                                  DateTime.now()
                                                      .difference(DateTime.parse(
                                                          filteredNotificationList[
                                                                  index - 1]
                                                              .createdAt
                                                              .toString()))
                                                      .inDays
                                                      .floor()
                                                      .toString()
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      int.parse(differenceInYears) <
                                                              1
                                                          ? "Today"
                                                          : int.parse(differenceInYears) >
                                                                      0 &&
                                                                  int.parse(
                                                                          differenceInYears) <
                                                                      2
                                                              ? "Yesterday"
                                                              : notDate,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 38,
                                                    ),
                                                  ],
                                                )
                                              : const Text(""),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 25),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  filteredNotificationList[
                                                                  index]
                                                              .isRead ==
                                                          true
                                                      ? const Color(0xFFF7F7F7)
                                                      : const Color(0xFFD4E6EB),
                                              child: filteredNotificationList[
                                                              index]
                                                          .isRead ==
                                                      true
                                                  ? Image.asset(
                                                      "assets/images/notification_read.png")
                                                  : Image.asset(
                                                      "assets/images/notification_unread.png")),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filteredNotificationList[
                                                          index]
                                                      .description
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          filteredNotificationList[
                                                                          index]
                                                                      .isRead ==
                                                                  true
                                                              ? FontWeight.w300
                                                              : FontWeight.w700,
                                                      color: const Color(
                                                          0xFF4F5E76)),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  notificationTime,
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFFAFAFAF),
                                                    fontFamily: "",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        _isLoadMoreRunning
                            ? const CircularProgressIndicator()
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  handleNotificationRead(int? id) async {
    getAllNotificationController.handleGetNotification();
    handleGetNotification(page);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.put(
      Uri.parse("$baseUrl/notification/read/$id"),
      headers: {
        "Authorization": "$token",
      },
    );
    var responseData = jsonDecode(response.body);

    if (responseData['status'] == true) {
      print("updated");
    } else {
      print("not updated");
    }
  }

  handleMarkAllRead() async {
    getAllNotificationController.handleGetNotification();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.put(
      Uri.parse("$baseUrl/notification/read/all"),
      headers: {
        "Authorization": "$token",
      },
    );
    var responseData = jsonDecode(response.body);

    if (responseData['status'] == true) {
      setState(() {
        isLoading = true;
        // handleGetNotification(page);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const NotificationScreen();
        }));
      });
    } else {
      print("not updated");
    }
  }
}
