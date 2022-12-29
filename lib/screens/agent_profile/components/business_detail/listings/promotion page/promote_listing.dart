// ignore_for_file: unused_import

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/promotion%20page/pay_webview.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/promotion%20page/verify_promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PromoteListingScreen extends StatefulWidget {
  final String id;
  final String image;
  final String currency;
  final String propertyAddress;
  final String price;
  final String viewCount;
  final String likeCount;
  final String formattedPrice;
  const PromoteListingScreen({
    Key? key,
    required this.id,
    required this.image,
    required this.currency,
    required this.propertyAddress,
    required this.price,
    required this.viewCount,
    required this.likeCount,
    required this.formattedPrice,
  }) : super(key: key);

  @override
  State<PromoteListingScreen> createState() => _PromoteListingScreenState();
}

class _PromoteListingScreenState extends State<PromoteListingScreen> {
  bool isPromoting = false;
  int days = 1;
  @override
  Widget build(BuildContext context) {
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
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: const Color(0XFFF0F7F8),
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/arrow_back.svg",
                      ),
                    ),
                  ),
                  const Text(
                    "Promote",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(""),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Boost your ads - reach clients faster!",
                style: TextStyle(
                  color: Color(0xFF455A64),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                    height: 110,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: .3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.image.isEmpty
                            ? Image.asset(
                                'assets/images/property_image.png',
                                height: 100,
                                width: 126,
                              )
                            : CachedNetworkImage(
                                // ignore: unnecessary_null_comparison
                                imageUrl: widget.image == null
                                    ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                                    : widget.image.toString(),
                                fit: BoxFit.cover,
                                width: 126,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        JumpingDotsProgressIndicator(
                                  fontSize: 20.0,
                                  color: Colors.blue,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                        const SizedBox(width: 24.06),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.currency.toString() +
                                  widget.formattedPrice.toString(),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF09172D)),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              widget.propertyAddress.toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF304059)),
                            ),
                            const Text(
                              "Wuse, Abuja",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF8A99B1)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF8FEFF),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.visibility,
                                    color: Color(0xFF8A99B1),
                                    size: 9,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.viewCount,
                                    style: const TextStyle(
                                        color: Color(0xFF8A99B1),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 9,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.likeCount,
                                    style: const TextStyle(
                                        color: Color(0xFF8A99B1),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFE6E6E6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Select days"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              width: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormBuilderDropdown(
                                      name: 'validity',
                                      isExpanded: true,
                                      initialValue: "1",
                                      alignment: Alignment.center,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                      onChanged: (value) {
                                        setState(() {
                                          days = int.parse(value.toString());
                                        });
                                      },
                                      items: [
                                        "1",
                                        "2",
                                        "3",
                                        "4",
                                        "5",
                                        "6",
                                        "7",
                                        "8",
                                        "9",
                                        "10",
                                        "11",
                                        "12",
                                        "13",
                                        "14",
                                        "15",
                                        "16",
                                        "17",
                                        "18",
                                        "19",
                                        "20",
                                        "21",
                                        "22",
                                        "23",
                                        "24",
                                        "25",
                                        "26",
                                        "27",
                                        "28",
                                        "29",
                                        "30",
                                      ].map((option) {
                                        return DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        constraints:
                                            const BoxConstraints(maxHeight: 60),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("N200 per day"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (200 * days).toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Material(
                  color: const Color(0xFF0072BA),
                  borderRadius: BorderRadius.circular(5),
                  child: MaterialButton(
                    onPressed: () {
                      handlePromotion(int.parse(widget.id));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isPromoting
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Buy and Activate",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  (200 * days).toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handlePromotion(int id) async {
    setState(() {
      isPromoting = true;
    });

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response =
        await http.post(Uri.parse("$baseUrl/promotions/$id"), headers: {
      "Authorization": "$token",
      "Accept": "application/json",
    }, body: {
      "validity": days.toString(),
    });
    var responseData = jsonDecode(response.body);
    // print(days);
    if (responseData['status'] == true) {
      setState(() {
        isPromoting = false;
      });
      // print(responseData['data']['authorization_url']);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return WebViewExample(
          webLink: responseData['data']['authorization_url'],
          referenceId: responseData['data']['reference'],
        );
      }));
      // print(responseData);
    } else {
      setState(() {
        isPromoting = false;
      });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          width: 280,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          onDismissCallback: (type) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Dismissed by $type'),
              ),
            );
          },
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Promotion Failed',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();

      // print(responseData);
    }
  }
}
