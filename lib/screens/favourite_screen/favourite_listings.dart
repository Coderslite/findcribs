// ignore_for_file: avoid_print

import 'package:findcribs/models/user_favourite_listing.dart';
import 'package:flutter/material.dart';
import 'package:findcribs/widgets/property_listings.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../controller/user_favourited_listing_controller.dart';

class FavouriteListingScreen extends StatefulWidget {
  const FavouriteListingScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteListingScreen> createState() => _FavouriteListingScreenState();
}

class _FavouriteListingScreenState extends State<FavouriteListingScreen> {
  List<UserFavouritedListingModel> filteredFavouritePropertyList = [];
  List<UserFavouritedListingModel> firstFavouritePropertyList = [];
  late Future<List<UserFavouritedListingModel>> favouritePropertyList;
  late Future<List<UserFavouritedListingModel>> filteredList;
  String searchingText = '';
  final textController = TextEditingController();
  bool isLoading = false;
  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());

  @override
  void initState() {
    super.initState();
    // favouritePropertyList = getUserFavouritedListing();
    // favouritePropertyList.then((value) {
    //   // print(value);
    //   setState(() {
    //     isLoading = false;
    //     firstFavouritePropertyList = filteredFavouritePropertyList = value;
    //     print(firstFavouritePropertyList);
    //   });
    // });
  }

  handleFilter(String value) {
    setState(() {
      filteredFavouritePropertyList =
          firstFavouritePropertyList.where((element) {
        return element.listing!['property_type']
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            element.listing!['design_type']!.contains(value.toLowerCase());
      }).toList();
      print(filteredFavouritePropertyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF0072BA),
                      )),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Favourite Listing",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Divider(
              color: Color(0xFFE0E0E0),
            ),
            const SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: TextFormField(
                controller: textController,
                onFieldSubmitted: (value) {
                  setState(() {
                    searchingText = value;
                  });
                  handleFilter(textController.text);
                },
                onChanged: (value) {},
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            searchingText = '';
                            textController.clear();
                            handleFilter(textController.text);
                          });
                        },
                        child: const Icon(Icons.cancel_outlined)),
                    fillColor: const Color(0xFFF9F9F9),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: "Search for property by design type...",
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFFB1B1B1))),
              ),
            ),
            const SizedBox(
              height: 14,
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
                  : userFavouritedListingController.favouritedListing.isEmpty
                      ? const Center(child: Text("No Favourited Property"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: userFavouritedListingController
                              .favouritedListing.length,
                          itemBuilder: (context, index) {
                            int rentFee = userFavouritedListingController
                                .favouritedListing[index]
                                .listing!['rental_fee'];

                            int price = (rentFee);
                            var formatter = NumberFormat("#,###");
                            var formatedPrice = formatter.format(price);
                            return Container(
                                margin:
                                    const EdgeInsets.fromLTRB(19, 0, 19, 15),
                                height: 130,
                                child: Property_Listings(
                                  id: userFavouritedListingController
                                      .favouritedListing[index].listingId,
                                  images: userFavouritedListingController
                                      .favouritedListing[index]
                                      .listing!["listingImage"],
                                  bedroom: userFavouritedListingController
                                      .favouritedListing[index]
                                      .listing!['bedroom'],
                                  propertyAddress:
                                      userFavouritedListingController
                                          .favouritedListing[index]
                                          .listing!['property_address'],
                                  propertyType: userFavouritedListingController
                                      .favouritedListing[index]
                                      .listing!['property_type'],
                                  propertyState: userFavouritedListingController
                                      .favouritedListing[index]
                                      .listing!['state'],
                                  price: formatedPrice,
                                ));
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
