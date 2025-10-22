import 'dart:convert';

import 'package:findcribs/controller/get_profile_controller.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/active_listing/active_listing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../components/constants.dart';
import 'package:http/http.dart' as http;

class VerifyPromotion extends StatefulWidget {
  final String reference;
  final StatefulWidget returnUrl;
  const VerifyPromotion(
      {super.key, required this.reference, required this.returnUrl});

  @override
  State<VerifyPromotion> createState() => _VerifyPromotionState();
}

class _VerifyPromotionState extends State<VerifyPromotion> {
  bool isLoading = true;
  String message = '';
  GetProfileController getProfileController = Get.put(GetProfileController());
  handleVerifyPromotion() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(widget.reference);

    var response = await http.get(
        Uri.parse("$baseUrl/confirm-payment-status/${widget.reference}"),
        headers: {
          "Authorization": "$token",
        });

    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        message = responseData['data']['status'];
        isLoading = false;
      });
      await getProfileController.handleGetProfile();
    } else {
      setState(() {
        isLoading = false;
        message = responseData['message']['status'];
      });
    }
  }

  @override
  void initState() {
    handleVerifyPromotion();
    super.initState();
  }

  bool failed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : message != 'success'
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/cancel.png",
                        scale: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Failed to proceed with promotion',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RedHatDisplay',
                          color: mobileTextSmallColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 57,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          // Connect EndPoint
                          onPressed: () {
                            Navigator.pop(context);
                            getProfileController.handleGetProfile();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 60),
                              backgroundColor: mobileButtonColor),
                          child: const Text(
                            //  Connect EndPoint

                            'Go Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'RedHatDisplay',
                              color: mobileButtonTextColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/image 10.png'),
                      const SizedBox(
                        height: 54,
                      ),
                      const Text(
                        'Payment Successfully!',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RedHatDisplay',
                          color: mobileTextSmallColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 57,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          // Connect EndPoint
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 60),
                              backgroundColor: mobileButtonColor),
                          child: const Text(
                            //  Connect EndPoint

                            'Go Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'RedHatDisplay',
                              color: mobileButtonTextColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
