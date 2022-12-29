// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:findcribs/service/property_list_categoty_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';
import '../authentication_screen/sign_up_page.dart';
import 'package:http/http.dart' as http;

import '../homepage/home_root.dart';
import '../homepage/single_property.dart';
import '../listing_process/get_started.dart';
import '../listing_process/listing/listing.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  late Future<List<HouseListModel>> propertyList;
  List<HouseListModel> filteredList = [];
  List<HouseListModel> firstList = [];
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  bool isLoading = true;
  final tooltipController = JustTheController();
  bool isToolTip = false;
  bool isChecking = false;
  int page = 1;
  bool _hasNextPage = true;
  late ScrollController _controller;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    handleGetProperties();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  handleGetProperties() {
    propertyList = getPropertyListCategory('hotel', page);
    propertyList.then((value) {
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
            filteredList.add(value[s]);
          }
        });
      }
    });
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
      propertyList = getPropertyListCategory('hotel', page);
      propertyList.then((value) {
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
              filteredList.add(value[s]);
            }
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

  @override
  Widget build(BuildContext context) {
    double mobileWidth = MediaQuery.of(context).size.width;
    double mobileHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: JustTheTooltip(
          controller: tooltipController,
          isModal: true,
          borderRadius: BorderRadius.circular(20),
          curve: Curves.easeInOutCirc,
          tailBaseWidth: 20,
          tailLength: 10,
          child: GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('token');
              final category = prefs.getString('category');
              token == null
                  ? showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            height: 250,
                            child: Column(children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: mobileHeight * .08,
                                  width: mobileWidth * 99,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'lib/assets/icons/goog_le.png',
                                          height: 23,
                                          width: 30,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Continue with Google',
                                            style: TextStyle(
                                                color: mobileTextColor,
                                                fontFamily:
                                                    'RedHatDisplayLight',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: mobileHeight * .08,
                                  width: mobileWidth * 99,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'lib/assets/icons/fb.png',
                                          height: 25,
                                          width: 30,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Continue with Facebook',
                                            style: TextStyle(
                                                color: mobileTextColor,
                                                fontFamily:
                                                    'RedHatDisplayLight',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Dont have an account?',
                                    style:
                                        TextStyle(color: mobileFormTextColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Connect EndPoint
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const EmailScreen();
                                      }));
                                    },
                                    child: const Text(
                                      ' Signup',
                                      style: TextStyle(
                                        color: mobileButtonColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]));
                      })
                  : category != null
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
                    handleGetStarted();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
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
                      const Text("Post a story")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    tooltipController
                        .hideTooltip()
                        .then((v) => handleGetStarted());
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
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomePageRoot(
                            navigateIndex: 0,
                          );
                        }));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: SvgPicture.asset(
                          "assets/svgs/home.svg",
                          width: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomePageRoot(
                            navigateIndex: 1,
                          );
                        }));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: SvgPicture.asset(
                          "assets/svgs/love.svg",
                          width: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: SvgPicture.asset(
                        "assets/svgs/blank.svg",
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomePageRoot(
                            navigateIndex: 3,
                          );
                        }));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: SvgPicture.asset(
                          "assets/svgs/chat2.svg",
                          width: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return HomePageRoot(
                                navigateIndex: 4,
                              );
                            },
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: SvgPicture.asset(
                          "assets/svgs/account.svg",
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: isChecking
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
            : Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (_) {
                            //   return HomePageRoot(navigateIndex: 0);
                            // }));
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
                              child: SvgPicture.asset(
                                  "assets/svgs/arrow_back.svg"),
                            ),
                          ),
                        ),
                        const Text(
                          "Hotel",
                          style: TextStyle(
                              fontFamily: 'RedHatDisplay',
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 20,
                          // child: SvgPicture.asset("assets/svgs/list.svg"),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Sale",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_up_down,
                                  size: 11,
                                  // color: Color(0XFFE5E5E5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_up_down,
                                  size: 11,
                                  // color: Color(0XFFE5E5E5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Sort",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_up_down,
                                  size: 11,
                                  // color: Color(0XFFE5E5E5),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_up_down,
                                  size: 11,
                                  // color: Color(0XFFE5E5E5),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_up_down,
                                  size: 11,
                                  // color: Color(0XFFE5E5E5),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                          : firstList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/opps.png"),
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
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, x) {
                                    int price = (filteredList[x]
                                            .rentalFee!
                                            .toInt() +
                                        filteredList[x].cautionFee!.toInt() +
                                        filteredList[x].legalFee!.toInt() +
                                        filteredList[x].agencyFee!.toInt());
                                    var formatter = NumberFormat("#,###");
                                    var formatedPrice = formatter.format(price);
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return ProductDetails(
                                                id: filteredList[x].id,
                                              );
                                            }));
                                          },
                                          child: SingleProperty(
                                            id: filteredList[x].id,
                                            image: filteredList[x].image,
                                            designType:
                                                filteredList[x].designType,
                                            currency: filteredList[x].currency,
                                            propertyType:
                                                filteredList[x].propertyType,
                                            propertyAddress:
                                                filteredList[x].propertyAddress,
                                            bedroom: filteredList[x].bedroom,
                                            propertyCategory: filteredList[x]
                                                .propertyCategory,
                                            price: formatedPrice,
                                            isPromoted:
                                                filteredList[x].isPromoted,
                                            propertyName: filteredList[x]
                                                .propertyName
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    );
                                  }),
                    ),
                    if (_isLoadMoreRunning == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
              ));
  }

  handleGetStarted() async {
    setState(() {
      isChecking = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    var response = await http.get(Uri.parse("$baseUrl/profile"), headers: {
      "Authorization": "$token",
    });
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      setState(() {
        isChecking = false;
      });
      var responseData = jsonResponse['data']['profile'];
      if (responseData['agent'] != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ListPropertyScreen1(
            tab: 0,
          );
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const GetStarted();
        }));
      }
    } else {
      setState(() {
        isChecking = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }
}
