// ignore_for_file: avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/login_controller.dart';
import 'package:findcribs/controller/share_link_controller.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/business_detail.dart';
import 'package:findcribs/screens/agent_profile/components/help/help.dart';
import 'package:findcribs/screens/agent_profile/components/legal/legal.dart';
import 'package:findcribs/screens/agent_profile/components/personal_info/personal_information.dart';
import 'package:findcribs/screens/agent_profile/components/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../controller/connectivity_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../homepage/home_root.dart';
import 'agent_profile_listing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  GetProfileController getProfileController = Get.put(GetProfileController());
  LoginController loginController = Get.put(LoginController());
  ShareLinkController shareLinkController = Get.put(ShareLinkController());
  @override
  void initState() {
    getProfileController.handleGetProfile();
    shareLinkController.handleGenerateAgentLink(
        getProfileController.myId.string,
        getProfileController.profileImg.string,
        getProfileController.firstName.string +
            getProfileController.lastName.string);

    super.initState();
  }

  ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
            // ignore: unrelated_type_equality_checks
            () => connectivityController.connectionStatus ==
                    ConnectivityResult.none
                ? Center(
                    child: GestureDetector(
                    onTap: () {
                      Get.to(const HomePageRoot(navigateIndex: 0));
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(
                                "Profile",
                                style: TextStyle(fontSize: size.width / 22),
                              ),
                              InkWell(
                                  onTap: () {
                                    shareLinkController.handleShareAgentLink();
                                  },
                                  child: Icon(Icons.share))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 126,
                                      height: 126,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              JumpingDotsProgressIndicator(
                                        fontSize: 20.0,
                                        color: Colors.blue,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageUrl: getProfileController
                                                  .profileImg.value ==
                                              'null'
                                          ? avataImg
                                          : getProfileController.profileImg
                                              .toString(),
                                    ),
                                  ),
                                  getProfileController.isVerified.string ==
                                          'verified'
                                      ? Positioned(
                                          top: 0,
                                          left: 100,
                                          right: 5,
                                          child: Image.asset(
                                              "assets/images/tick.png"))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "${getProfileController.firstName} ${getProfileController.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            getProfileController.agent.string == 'null' ||
                                    getProfileController.agent.string == '{}'
                                ? "Not Identified"
                                : getProfileController.agent['category']
                                    .toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          getProfileController.favouritingAgentCount.value == ''
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${getProfileController.favouritingAgentCount}",
                                          ),
                                          const Text(
                                            "Followers",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${getProfileController.favouritedAgentCount}",
                                          ),
                                          const Text(
                                            "Following",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SalesScreen(
                                                id: int.parse(
                                                  getProfileController.myId
                                                      .toString(),
                                                ),
                                                isVerified: getProfileController
                                                    .agent['is_verified'],
                                                image: getProfileController
                                                            .profileImg
                                                            .string ==
                                                        'null'
                                                    ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                                    : getProfileController
                                                        .profileImg
                                                        .toString(),
                                                businessName:
                                                    getProfileController
                                                        .agent['business_name']
                                                        .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${getProfileController.listingCount}",
                                            ),
                                            const Text(
                                              "Listings",
                                              style: TextStyle(
                                                  color: Colors.blueGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const PersonalInformationScreen();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Personal Details",
                                            style: TextStyle(
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Manage your personal information",
                                          style: TextStyle(
                                              fontSize: size.width / 37,
                                              color: const Color(0XFF8A99B1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      size: size.width / 26,
                                      color: const Color(0XFF8A99B1)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          getProfileController.agent.toString() == 'null' ||
                                  getProfileController.agent.string == '{}'
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return const BusinessDetail();
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Business Details",
                                                  style: TextStyle(
                                                    fontSize: size.width / 26,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                "Manage your business information",
                                                style: TextStyle(
                                                  fontSize: size.width / 37,
                                                  color:
                                                      const Color(0XFF8A99B1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: size.width / 26,
                                          color: const Color(0XFF8A99B1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const HelpScreen();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Get Help",
                                            style: TextStyle(
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Get support or send feedback",
                                          style: TextStyle(
                                            fontSize: size.width / 37,
                                            color: const Color(0XFF8A99B1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.width / 26,
                                    color: const Color(0XFF8A99B1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const LegalSettings();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Legal",
                                            style: TextStyle(
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "About our contract with you",
                                          style: TextStyle(
                                              fontSize: size.width / 37,
                                              color: const Color(0XFF8A99B1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.width / 26,
                                    color: const Color(0XFF8A99B1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const Settings();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Settings",
                                            style: TextStyle(
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Do your own customization",
                                          style: TextStyle(
                                            fontSize: size.width / 37,
                                            color: const Color(0XFF8A99B1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: size.width / 26,
                                    color: const Color(0XFF8A99B1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              loginController.handleLogout();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Logout",
                                            style: TextStyle(
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Sign out from this account ",
                                          style: TextStyle(
                                            fontSize: size.width / 37,
                                            color: const Color(0XFF8A99B1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              loginController.lougoutUser();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Delete Account",
                                            style: TextStyle(
                                              fontFamily: "RedHatDisplay",
                                              fontSize: size.width / 26,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Delete user account",
                                          style: TextStyle(
                                            fontSize: size.width / 37,
                                            color: const Color(0XFF8A99B1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
  }
}
