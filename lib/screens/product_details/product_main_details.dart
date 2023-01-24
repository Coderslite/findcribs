// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/models/house_detail_model.dart';
import 'package:findcribs/screens/product_details/photo_view_preview.dart';
import 'package:findcribs/service/property_details_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/get_chat_controller.dart';
import '../../controller/user_favourited_listing_controller.dart';
import '../../models/user_favourite_listing.dart';
import '../../service/user_favourited_listing_service.dart';
import '../../util/social_login.dart';

// ignore: must_be_immutable
class ProductMainDetails extends StatefulWidget {
  ProductMainDetails({
    Key? key,
    required this.panelOpened,
    this.id,
  }) : super(key: key);
  final bool panelOpened;
  int? id;

  @override
  State<ProductMainDetails> createState() => _ProductMainDetailsState();
}

class _ProductMainDetailsState extends State<ProductMainDetails> {
  late Future<HouseDetailModel> singleProperty;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  List<UserFavouritedListingModel> filteredFavouritePropertyList = [];
  List<UserFavouritedListingModel> firstFavouritePropertyList = [];
  late Future<List<UserFavouritedListingModel>> favouritePropertyList;
  GetAllChatController getAllChatController = Get.put(GetAllChatController());

  final _controller = PageController(
    initialPage: 0,
  );
  bool end = false;
  List images = [1];
  bool isLiked = false;

  handleGetLikedProperties() {
    favouritePropertyList = getUserFavouritedListing();
    favouritePropertyList.then((value) {
      // print(value);
      setState(() {
        firstFavouritePropertyList = filteredFavouritePropertyList = value;
        handleFilter(widget.id.toString());
      });
    });
  }

  handleFilter(String value) {
    setState(() {
      filteredFavouritePropertyList =
          firstFavouritePropertyList.where((element) {
        return element.listingId.toString().contains(value);
      }).toList();
      print("filter$filteredFavouritePropertyList");
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

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // handleGetLikedProperties();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage == images.length - 1) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }

      if (end == false) {
        _currentPage++;
      } else {
        _currentPage--;
      }

      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    });

    userFavouritedListingController.handleCheckLike(widget.id);
    singleProperty = getSingleProperty(widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    getAllChatController.handleGetMessage();

    super.dispose();
  }

  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HouseDetailModel>(
        future: singleProperty,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Navigator.pu
            Fluttertoast.showToast(msg: 'Property not available');
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/opps.png"),
                const Text(
                  "Opps!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Property No longer Available"),
              ],
            );
          }
          if (snapshot.hasData) {
            var property = snapshot.data!;
            int price = (property.rentalFee!.toInt());
            images = property.images!;

            var formatter = NumberFormat("#,###");
            var formatedPrice = formatter.format(price);
            return Obx(
              () => Column(children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return PhotoPreview(
                              images: property.images,
                              businessName:
                                  property.agentBusinessName.toString());
                        }));
                      },
                      child: SizedBox(
                        height: property.propertyCategory == 'Estate Market'
                            ? MediaQuery.of(context).size.height / 1.6
                            : MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: property.images!.isEmpty
                            ? Image.network(
                                'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG',
                                fit: BoxFit.cover,
                              )
                            : PageView.builder(
                                controller: _controller,
                                scrollDirection: Axis.horizontal,
                                itemCount: property.images!.length,
                                allowImplicitScrolling: true,
                                itemBuilder: ((context, index) {
                                  return Stack(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        child: InkWell(
                                          onTap: () {
                                            print("images");
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return PhotoPreview(
                                                images: property.images,
                                                businessName: property
                                                    .agentBusinessName
                                                    .toString(),
                                              );
                                            }));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: property.images![index]
                                                ['url'],
                                            fit: BoxFit.cover,
                                            width: 1000,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                JumpingDotsProgressIndicator(
                                              fontSize: 20.0,
                                              color: Colors.blue,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: 85,
                            padding: const EdgeInsets.all(1),
                            height: 25,
                            decoration: BoxDecoration(
                              color: const Color(0XFFFEC121),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                'for ${property.propertyType}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Text(
                              // capitalize(property.designType.toString()) +
                              //     " " +
                              capitalize(
                                  property.propertyCategory == 'Estate Market'
                                      ? property.propertyName.toString()
                                      : property.propertyCategory.toString()),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/location.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        property.state.toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/type.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        property.totalAreaOfLand.toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/star.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        property.coveredByProperty.toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: property.images!.isEmpty
                            ? 1
                            : property.images!.length,
                        effect: const ExpandingDotsEffect(
                          spacing: 13,
                          expansionFactor: (19 / 8),
                          radius: 20,
                          activeDotColor: Colors.white,
                          dotColor: Color(0xFFDADADA),
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                    widget.panelOpened
                        ? Positioned(
                            top: 100,
                            right: 30,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    token == null
                                        ? showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const SocialLogin();
                                            })
                                        : userFavouritedListingController
                                            .handleLike(widget.id);
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFFF0F7F8)),
                                    child: userFavouritedListingController
                                            .userFavouritedListing
                                            .contains(widget.id)
                                        ? const Icon(CupertinoIcons.heart_solid,
                                            size: 16, color: Color(0xFFDD1611))
                                        : const Icon(CupertinoIcons.heart,
                                            size: 16, color: Color(0XFF304059)),
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                // Container(
                                //   width: 25,
                                //   height: 25,
                                //   decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Color(0XFFF0F7F8)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: SvgPicture.asset(
                                //       "assets/svgs/share.svg",
                                //       color: const Color(0XFF304059),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                // Container(
                                //   width: 25,
                                //   height: 25,
                                //   decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Color(0XFFF0F7F8)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: SvgPicture.asset(
                                //       "assets/svgs/point3.svg",
                                //       color: const Color(0XFF304059),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ))
                        : Positioned(
                            top: 40,
                            right: 30,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    token == null
                                        ? showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const SocialLogin();
                                            })
                                        : userFavouritedListingController
                                            .handleLike(widget.id);
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFFF0F7F8)),
                                    child: userFavouritedListingController
                                            .userFavouritedListing
                                            .contains(widget.id)
                                        ? const Icon(CupertinoIcons.heart_solid,
                                            size: 16, color: Color(0xFFDD1611))
                                        : const Icon(CupertinoIcons.heart,
                                            size: 16, color: Color(0XFF304059)),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Container(
                                //   width: 25,
                                //   height: 25,
                                //   decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Color(0XFFF0F7F8)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: SvgPicture.asset(
                                //       "assets/svgs/share.svg",
                                //       color: const Color(0XFF304059),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Container(
                                //   width: 25,
                                //   height: 25,
                                //   decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Color(0XFFF0F7F8)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(5.0),
                                //     child: SvgPicture.asset(
                                //       "assets/svgs/point3.svg",
                                //       color: const Color(0XFF304059),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                    Positioned(
                      top: 30,
                      left: 20,
                      child: GestureDetector(
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
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child:
                                SvgPicture.asset("assets/svgs/arrow_back.svg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  // margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                        bottom: 20.0,
                        top: property.propertyCategory == 'Estate Market'
                            ? 0.0
                            : 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        property.propertyCategory != 'Estate Market'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svgs/bedroom.svg"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${property.bedroom} Bedroom",
                                        style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF8A99B1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svgs/bathroom.svg"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${property.bathroom} Bathroom",
                                        style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF8A99B1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                          "assets/images/living_room.png"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${property.livingRoom} Living Room",
                                        style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF8A99B1),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset("assets/images/kitchen.png"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${property.kitchen} Kitchen",
                                        style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0XFF8A99B1),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                        const Divider(),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0XFF8A99B1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              property.propertyAddress.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF8A99B1),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            property.propertyType == 'sale'
                                ? const Text(
                                    "Sales Price",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF8A99B1),
                                    ),
                                  )
                                : Text(
                                    "Rent fee /${property.rentalFrequncy}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF8A99B1),
                                    ),
                                  ),
                            Text(
                              property.currency == 'Naira'
                                  ? "NGN$formatedPrice"
                                  : "\$$formatedPrice",
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w900,
                                color: Color(0XFF09172D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
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
        });
  }
}
