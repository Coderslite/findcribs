// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/get_single_property_listing.dart';
import '../../models/house_detail_model.dart';
import '../../models/user_favourite_listing.dart';
import '../../service/user_favourited_listing_service.dart';
import '../../util/colors.dart';
import '../../util/social_login.dart';
import '../product_details/product_details.dart';

class SingleProperty extends StatefulWidget {
//  final List<HouseListModel> filteredList;
  final HouseListModel listing;

  final String comingFrom;
  const SingleProperty({
    super.key,
    required this.listing,
    required this.comingFrom,
  });

  @override
  State<SingleProperty> createState() => _SinglePropertyState();
}

class _SinglePropertyState extends State<SingleProperty> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  late Future<HouseDetailModel> singleProperty;

  List<HouseListModel> filteredFavouritePropertyList = [];
  List<HouseListModel> firstFavouritePropertyList = [];
  late Future<List<HouseListModel>> favouritePropertyList;

  GetSinglePropertyController getSinglePropertyController =
      Get.put(GetSinglePropertyController());
  bool isLiked = false;

  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());
  @override
  void initState() {
    // handleGetLikedProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int price = int.parse(widget.listing.rentalFee.toString());
    var formatter = NumberFormat("#,###");
    var formatedPrice = formatter.format(price);
    return Obx(
      () => Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    getSinglePropertyController.propertyId.value =
                        widget.listing.id.toString();
                    getSinglePropertyController.isLoading.value = true;

                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                      return ProductDetails(
                        id: widget.listing.id,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return InkWell(
                                    onTap: () {},
                                    child: const Center(child: Text("Retry")));
                              },
                              imageUrl: widget.listing.image!.isEmpty
                                  ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                                  : widget.listing.image![0]['url'],
                              fit: BoxFit.cover,
                              // width: 1000,
                              filterQuality: FilterQuality.none,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      JumpingDotsProgressIndicator(
                                fontSize: 20.0,
                                color: Colors.blue,
                              ),
                              imageBuilder: (context, imageProvider) {
                                return Image(
                                  image: imageProvider,
                                  // Apply image compression options here
                                  // For example, use the `colorBlendMode` property to reduce quality
                                  color: Colors.black.withOpacity(0.9),
                                  colorBlendMode: BlendMode.dstATop,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          )),
                      // child: Image.network(

                      //   widget.listing.image1,

                      //   fit: BoxFit.cover,

                      // ),

                      Positioned.fill(
                        bottom: 10,
                        left: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                capitalize("${widget.listing.state} State"),
                                style: const TextStyle(
                                  color: white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  widget.listing.propertyCategory.toString() ==
                                          'Estate Market'
                                      ? ""
                                      : capitalize(
                                          widget.listing.designType.toString()),
                                  style: const TextStyle(
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      capitalize(
                          widget.listing.propertyCategory == 'Estate Market'
                              ? widget.listing.propertyName.toString()
                              : widget.listing.propertyCategory.toString()),
                      style: const TextStyle(
                          fontFamily: 'RedHatDisplay',
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.listing.currency == 'Naira'
                          ? "NGN${formatedPrice}"
                          : "\$".toString() + formatedPrice.toString(),
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
                          widget.listing.propertyAddress.toString(),
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
                        widget.listing.propertyCategory != 'Estate Market'
                            ? const Icon(
                                Icons.qr_code_rounded,
                                color: Color(0xFFFEC121),
                                size: 10,
                              )
                            : Container(),
                        const SizedBox(
                          width: 2,
                        ),
                        widget.listing.propertyCategory != 'Estate Market'
                            ? Text(
                                "${widget.listing.bedroom} bedroom",
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
                        widget.listing.isPromoted == true
                            ? const Row(
                                children: [
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                capitalize('for ') +
                                    capitalize(
                                        widget.listing.propertyType.toString()),
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
                                    .handleLike(widget.listing);

                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: userFavouritedListingController
                                    .favouritedListing
                                    .where((e) => e.id == widget.listing.id)
                                    .toList()
                                    .isNotEmpty
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
    );
  }
}
