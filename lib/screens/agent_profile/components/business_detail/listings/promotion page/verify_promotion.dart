import 'dart:convert';

import 'package:findcribs/screens/agent_profile/components/business_detail/listings/active_listing/active_listing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../components/constants.dart';
import 'package:http/http.dart' as http;

class VerifyPromotion extends StatefulWidget {
  final String reference;
  const VerifyPromotion({Key? key, required this.reference}) : super(key: key);

  @override
  State<VerifyPromotion> createState() => _VerifyPromotionState();
}

class _VerifyPromotionState extends State<VerifyPromotion> {
  bool isLoading = true;
  String message = '';
  handleVerifyPromotion() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var response = await http.post(
        Uri.parse(
            "http://18.233.168.44:5000/user/promotions/verify?reference=${widget.reference}"),
        headers: {
          "Authorization": "$token",
        });

    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        message = 'success';
        isLoading = false;
      });
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ActiveListing();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 60),
                              primary: mobileButtonColor),
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
                        'Listing Promoted Successfully!',
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ActiveListing();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(500, 60),
                              primary: mobileButtonColor),
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
