// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/house_detail_model.dart';
import '../../models/user_favourite_listing.dart';
import '../../service/user_favourited_listing_service.dart';
import '../../util/social_login.dart';
import '../product_details/product_details.dart';

class SingleProperty extends StatefulWidget {
//  final List<HouseListModel> filteredList;
  final int? id;
  final List? image;
  final String? designType;
  final String? currency;
  final String? propertyType;
  final String? propertyAddress;
  final int? bedroom;
  final String? propertyCategory;
  final String? price;
  final bool? isPromoted;
  final String propertyName;

  const SingleProperty({
    Key? key,
    required this.id,
    required this.image,
    required this.designType,
    required this.currency,
    required this.propertyType,
    required this.propertyAddress,
    required this.bedroom,
    required this.propertyCategory,
    required this.price,
    this.isPromoted,
    required this.propertyName,
  }) : super(key: key);

  @override
  State<SingleProperty> createState() => _SinglePropertyState();
}

class _SinglePropertyState extends State<SingleProperty> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  late Future<HouseDetailModel> singleProperty;

  List<UserFavouritedListingModel> filteredFavouritePropertyList = [];
  List<UserFavouritedListingModel> firstFavouritePropertyList = [];
  late Future<List<UserFavouritedListingModel>> favouritePropertyList;
  ValueNotifier<int> _networklHasErrorNotifier = ValueNotifier(0);

  bool isLiked = false;

  handleGetLikedProperties() {
    favouritePropertyList = getUserFavouritedListing();
    favouritePropertyList.then((value) {
      // print(value);
      if (mounted) {
        setState(() {
          firstFavouritePropertyList = filteredFavouritePropertyList = value;
          handleFilter(widget.id.toString());
        });
        print(firstFavouritePropertyList);
      }
    });
  }

  handleFilter(String value) {
    setState(() {
      filteredFavouritePropertyList =
          firstFavouritePropertyList.where((element) {
        return element.listingId.toString().contains(value);
      }).toList();
      print("filter" + filteredFavouritePropertyList.toString());
    });
    if (filteredFavouritePropertyList.isEmpty) {
      setState(() {
        isLiked = false;
      });
    } else {
      setState(() {
        isLiked = true;
      });
    }
  }

  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());
  @override
  void initState() {
    // handleGetLikedProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        // handleGetProperties();
        return true;
      },
      child: Obx(
        () => Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProductDetails(
                          id: widget.id,
                        );
                      }));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 166,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ValueListenableBuilder(
                              valueListenable: _networklHasErrorNotifier,
                              builder:
                                  (BuildContext context, int count, child) {
                                print("rebuild");
                                return CachedNetworkImage(
                                  errorWidget: (context, url, error) {
                                    return InkWell(
                                        onTap: () {
                                          print("clicked");
                                          setState(() {
                                            _networklHasErrorNotifier.value++;
                                          });
                                        },
                                        child: Center(child: Text("Retry")));
                                  },
                                  // imageBuilder: (context, imageProvider) {
                                  //   return Center(
                                  //     child: CircularProgressIndicator(),
                                  //   );
                                  // },
                                  imageUrl: widget.image!.isEmpty
                                      ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                                      : widget.image![0]['url'],
                                  fit: BoxFit.cover,
                                  width: 1000,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          JumpingDotsProgressIndicator(
                                    fontSize: 20.0,
                                    color: Colors.blue,
                                  ),
                                );
                              }),
                        ),
                        // child: Image.network(

                        //   widget.image1,

                        //   fit: BoxFit.cover,

                        // ),

                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            widget.propertyCategory.toString() ==
                                    'Estate Market'
                                ? ""
                                : capitalize(widget.designType.toString()),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        capitalize(widget.propertyCategory == 'Estate Market'
                            ? widget.propertyName.toString()
                            : widget.propertyCategory.toString()),
                        style: const TextStyle(
                            fontFamily: 'RedHatDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        widget.currency == 'Naira'
                            ? "NGN${widget.price}"
                            : "\$".toString() + widget.price.toString(),
                        style: const TextStyle(
                            fontFamily: 'RedHatDisplay',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFFEC121),
                            size: 10,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.propertyAddress.toString(),
                            style: const TextStyle(
                              fontFamily: 'RedHatDisplay',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8A99B1),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          widget.propertyCategory != 'Estate Market'
                              ? const Icon(
                                  Icons.qr_code_rounded,
                                  color: Color(0xFFFEC121),
                                  size: 10,
                                )
                              : Container(),
                          const SizedBox(
                            width: 2,
                          ),
                          widget.propertyCategory != 'Estate Market'
                              ? Text(
                                  widget.bedroom.toString() + " bedroom",
                                  style: const TextStyle(
                                    fontFamily: 'RedHatDisplay',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF8A99B1),
                                  ),
                                )
                              : const Text("")
                        ],
                      ),
                      Row(
                        children: [
                          widget.isPromoted == true
                              ? Row(
                                  children: const [
                                    Icon(
                                      Icons.star_rate,
                                      color: Color(0xFFFEC121),
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Promoted",
                                      style: TextStyle(
                                        fontFamily: 'RedHatDisplay',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF0072BA),
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Positioned.fill(
                  top: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            // // width: 85,
                            // padding:
                            //     const EdgeInsets.all(5),
                            height: 25,
                            decoration: BoxDecoration(
                              color: const Color(0XFFFEC121),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  capitalize('for ') +
                                      capitalize(
                                          widget.propertyType.toString()),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context)
                        //           .size
                        //           .width /
                        //       1.6,
                        // ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () async {
                              var prefs = await SharedPreferences.getInstance();
                              var token = prefs.getString('token');
                              token == null
                                  ? showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const SocialLogin();
                                      })
                                  : userFavouritedListingController
                                      .handleLike(widget.id);
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: userFavouritedListingController
                                      .userFavouritedListing
                                      .contains(widget.id)
                                  ? const Icon(CupertinoIcons.heart_solid,
                                      size: 16, color: Color(0xFFDD1611))
                                  : const Icon(CupertinoIcons.heart,
                                      size: 16, color: Color(0XFF304059)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
