// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:findcribs/controller/user_favorited_agent_controller.dart';
import 'package:findcribs/controller/user_favourited_listing_controller.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/models/user_favourite_listing.dart';
import 'package:findcribs/screens/favourite_screen/favourite_agent.dart';
import 'package:findcribs/screens/favourite_screen/favourite_listings.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:findcribs/service/user_favourited_listing_service.dart';
import 'package:findcribs/widgets/agent_listings.dart';
import 'package:flutter/material.dart';
import 'package:findcribs/components/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/connectivity_controller.dart';
import '../../widgets/property_listings.dart';
import '../homepage/home_root.dart';

class FavouritePageScreen extends StatefulWidget {
  const FavouritePageScreen({super.key});

  @override
  State<FavouritePageScreen> createState() => _FavouritePageScreenState();
}

class _FavouritePageScreenState extends State<FavouritePageScreen> {
  List<HouseListModel> filteredFavouritePropertyList = [];
  List<HouseListModel> firstFavouritePropertyList = [];
  late Future<List<HouseListModel>> favouritePropertyList;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    super.initState();
  }

  handleGetFavouriteListing() {
    favouritePropertyList = getUserFavouritedListing();
    favouritePropertyList.then((value) {
      // print(value);
      if (mounted) {
        setState(() {
          firstFavouritePropertyList = filteredFavouritePropertyList = value;
        });
      }
    });
  }

  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  UserFavouritedListingController userFavouritedListingController =
      Get.put(UserFavouritedListingController());

  UserFavoritedAgentController userFavoritedAgentController =
      Get.put(UserFavoritedAgentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Obx(
        // ignore: unrelated_type_equality_checks
        () => connectivityController.connectionStatus == ConnectivityResult.none
            ? Center(
                child: GestureDetector(
                onTap: () {
                  Get.to(const HomePageRoot(navigateIndex: 1));
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
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text("Favourite Agents",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ),
                          ElevatedButton(
                            // Connect EndPoint
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FavouriteAgentScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(86, 25),
                                backgroundColor: mobileButtonColor),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  color: mobileButtonTextColor,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),

                    // agent lists
                    Expanded(
                      child: userFavoritedAgentController.allAgents.isEmpty
                          ? const Center(
                              child:
                                  Text("You have not favourited any agent yet"))
                          : Obx(
                              () => ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: userFavoritedAgentController
                                            .allAgents.length <
                                        5
                                    ? userFavoritedAgentController
                                        .allAgents.length
                                    : 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          19, 0, 19, 15),
                                      child: Agent_Listings(
                                        id: userFavoritedAgentController
                                            .allAgents[index].userId,
                                        name: userFavoritedAgentController
                                            .allAgents[index].businessName
                                            .toString(),
                                        image: userFavoritedAgentController
                                            .allAgents[index].profilePic
                                            .toString(),
                                        category: userFavoritedAgentController
                                            .allAgents[index].category
                                            .toString(),
                                        isverified: userFavoritedAgentController
                                            .allAgents[index].isVerified,
                                      ));
                                },
                              ),
                            ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text("Favourite Listings",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ),
                          ElevatedButton(
                            // Connect EndPoint
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FavouriteListingScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(86, 25),
                                backgroundColor: mobileButtonColor),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  color: mobileButtonTextColor,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    // property lists
                    const SizedBox(height: 14),
                    Expanded(
                      child: userFavouritedListingController
                              .favouritedListing.isEmpty
                          ? const Center(child: Text("No Favourited Property"))
                          : Obx(
                              () => RefreshIndicator(
                                onRefresh: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  return userFavouritedListingController
                                      .handleGetFavouritedListing();
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: userFavouritedListingController
                                              .favouritedListing.length <
                                          5
                                      ? userFavouritedListingController
                                          .favouritedListing.length
                                      : 5,
                                  itemBuilder: (context, index) {
                                    HouseListModel listing =
                                        userFavouritedListingController
                                            .favouritedListing[index];
                                    int rentFee = listing.rentalFee.toInt();

                                    int price = (rentFee);
                                    var formatter = NumberFormat("#,###");
                                    var formatedPrice = formatter.format(price);
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ProductDetails(
                                            id: userFavouritedListingController
                                                .favouritedListing[index]
                                                .listingId,
                                          );
                                        }));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            19, 0, 19, 15),
                                        height: 130,
                                        child: Property_Listings(
                                          id: listing.id,
                                          images: listing.image,
                                          bedroom: listing.bedroom,
                                          propertyAddress:
                                              listing.propertyAddress,
                                          propertyType: listing.propertyType,
                                          propertyState:
                                              listing.state.toString(),
                                          price: formatedPrice,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
