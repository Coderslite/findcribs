import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/active_listing/active_listing.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/disabled_listing/disabled_listing.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/saved_listing/saved_listing.dart';
import 'package:findcribs/service/active_list_service.dart';
import 'package:findcribs/service/disabled_list_service.dart';
import 'package:findcribs/service/saved_list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserListing extends StatefulWidget {
  const UserListing({Key? key}) : super(key: key);

  @override
  State<UserListing> createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {
  late Future<List<HouseListModel>> propertyList;
  late Future<List<HouseListModel>> savedPropertyList;
  late Future<List<HouseListModel>> disabledPropertyList;
  List<HouseListModel> filteredActiveList = [];
  List<HouseListModel> filteredSavedList = [];
  List<HouseListModel> filteredDisabledList = [];
  List<HouseListModel> firstActiveList = [];
  List<HouseListModel> firstSavedList = [];
  List<HouseListModel> firstDisabledList = [];
  // late Future<List<FavouriteStoryListModel>> storyList;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  void initState() {
    super.initState();
    propertyList = getActivePropertyList();
    savedPropertyList = getSavedPropertyList();
    disabledPropertyList = getDisabledPropertyList();
    // storyList = getFavouriteStoryList();
    propertyList.then((value) {
      // print(value);
      setState(() {
        firstActiveList =
            firstSavedList = firstDisabledList = filteredActiveList = value;
        handleActiveFilter('Active');
      });
    });

    savedPropertyList.then((value) {
      // print(value);
      setState(() {
        firstSavedList = filteredSavedList = value;
        handleSavedFilter('Saved');
      });
    });

    disabledPropertyList.then((value) {
      // print(value);
      setState(() {
        firstDisabledList = filteredDisabledList = value;
        handleSavedFilter('Disabled');
      });
    });
  }

  handleActiveFilter(String value) {
    setState(() {
      filteredActiveList = firstActiveList.where((element) {
        return element.status!.toLowerCase() == value.toLowerCase();
      }).toList();
      // print(filteredActiveList);
    });
  }

  handleSavedFilter(String value) {
    setState(() {
      filteredSavedList = firstSavedList.where((element) {
        return element.status!.toLowerCase() == value.toLowerCase();
      }).toList();
      // print(filteredActiveList);
    });
  }

  handleDisabledFilter(String value) {
    setState(() {
      filteredSavedList = firstSavedList.where((element) {
        return element.status!.toLowerCase() == value.toLowerCase();
      }).toList();
      // print(filteredActiveList);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: NotificationListener(
            onNotification: (info) {
              propertyList.then((value) {
                // print(value);
                setState(() {
                  firstActiveList = firstSavedList =
                      firstDisabledList = filteredActiveList = value;
                  handleActiveFilter('Active');
                });
              });

              savedPropertyList.then((value) {
                // print(value);
                setState(() {
                  firstSavedList = filteredSavedList = value;
                  handleSavedFilter('Saved');
                });
              });

              disabledPropertyList.then((value) {
                // print(value);
                setState(() {
                  firstDisabledList = filteredDisabledList = value;
                  handleSavedFilter('Disabled');
                });
              });
              return true;
            },
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
                      "Business Info",
                      style: TextStyle(
                          fontFamily: "RedHatDisplay",
                          fontSize: size.width / 22),
                    ),
                    const Text("            "),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    right: 15,
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return const ActiveListing();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Active Listings",
                                  style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    fontSize: size.width / 26,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "View and manage all published listings",
                                style: TextStyle(fontSize: size.width / 37),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFFFFC107),
                            radius: 12,
                            child: Text(
                              filteredActiveList.length.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: size.width / 26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return const SavedListing();
                    }));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 15,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Saved Listings",
                                  style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    fontSize: size.width / 26,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "View, edit or publish listings in your draft",
                                style: TextStyle(fontSize: size.width / 37),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFFFC107),
                              radius: 12,
                              child: Text(
                                filteredSavedList.length.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: size.width / 26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return const DisabledListing();
                    }));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 15,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Disabled Listings",
                                  style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    fontSize: size.width / 26,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "View and manage all disabled listings",
                                style: TextStyle(fontSize: size.width / 37),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFFFC107),
                              radius: 12,
                              child: Text(
                                filteredDisabledList.length.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: size.width / 26,
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
      ),
    );
  }
}
