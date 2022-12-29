import 'dart:io';

import 'package:findcribs/screens/story/image_preview.dart';
import 'package:findcribs/screens/story/single_active_listing.dart';
import 'package:findcribs/screens/story/video_trim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../models/house_list_model.dart';
import '../../service/active_list_service.dart';

class AttachActiveListing extends StatefulWidget {
  final File file;
  final String type;
  const AttachActiveListing({Key? key, required this.file, required this.type})
      : super(key: key);

  @override
  State<AttachActiveListing> createState() => _AttachActiveListingState();
}

class _AttachActiveListingState extends State<AttachActiveListing> {
  late Future<List<HouseListModel>> propertyList;
  List<HouseListModel> filteredList = [];
  List<HouseListModel> firstList = [];
  bool isLoading = true;
  // late Future<List<FavouriteStoryListModel>> storyList;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    super.initState();
    handleGetActiveRentList();
  }

  handleGetActiveRentList() {
    propertyList = getActivePropertyList();
    // storyList = getFavouriteStoryList();
    propertyList.then((value) {
      // print(value);
      setState(() {
        isLoading = false;
        firstList = filteredList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
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
                        child: SvgPicture.asset("assets/svgs/arrow_back.svg"),
                      ),
                    ),
                  ),
                  Text(
                    "Active Listing",
                    style: TextStyle(
                        fontFamily: "RedHatDisplay", fontSize: size.width / 22),
                  ),
                  const Text("            "),
                ],
              ),
              const SizedBox(
                height: 20,
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
                    : filteredList.isEmpty
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
                            itemBuilder: (context, index) {
                              int price =
                                  (filteredList[index].rentalFee!.toInt() +
                                      filteredList[index].cautionFee!.toInt() +
                                      filteredList[index].legalFee!.toInt() +
                                      filteredList[index].agencyFee!.toInt());
                              var formatter = NumberFormat("#,###");
                              var formatedPrice = formatter.format(price);
                              return GestureDetector(
                                onTap: () {
                                  widget.type == 'video'
                                      ? 
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (_) {
                                      //     return VideoTrim(
                                      //       file: widget.file,
                                      //       listingId: filteredList[index]
                                      //           .id
                                      //           .toString(),
                                      //     );
                                      //   }))
                                      null
                                      : Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                          return ImagePreview(
                                            file: widget.file,
                                            listingId: filteredList[index]
                                                .id
                                                .toString(),
                                          );
                                        }));
                                },
                                child: SingleActiveListing(
                                  viewCount:
                                      filteredList[index].viewCount.toString(),
                                  likeCOunt:
                                      filteredList[index].likeCount.toString(),
                                  image: filteredList[index].image,
                                  currency: filteredList[index].currency,
                                  propertyAddress:
                                      filteredList[index].propertyAddress,
                                  propertyLocation:
                                      filteredList[index].state,
                                  id: filteredList[index].id.toString(),
                                  formattedPrice: formatedPrice,
                                  status: 'Active',
                                  isPromoted: filteredList[index].isPromoted,
                                ),
                              );
                            }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
