import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart' as launchUrl;

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Get Help",
                    style: TextStyle(
                        fontFamily: "RedHatDisplay", fontSize: size.width / 22),
                  ),
                  const Text("           "),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  // ignore: deprecated_member_use
                  launchUrl.launch("tel:07026195346");
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
                            Text("Call Us",
                                style: TextStyle(
                                  fontFamily: "RedHatDisplay",
                                  fontSize: size.width / 26,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              "Contact our call center",
                              style: TextStyle(
                                  fontSize: size.width / 37,
                                  color: const Color(0XFF8A99B1)),
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
              // Container(
              //   padding: const EdgeInsets.only(
              //     top: 5,
              //     bottom: 5,
              //     right: 15,
              //     left: 15,
              //   ),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.grey.withOpacity(0.5),
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("Chat with us",
              //                 style: TextStyle(
              //                   fontFamily: "RedHatDisplay",
              //                   fontSize: size.width / 26,
              //                   fontWeight: FontWeight.bold,
              //                 )),
              //             Text(
              //               "Send an in-app chat",
              //               style: TextStyle(
              //                   fontSize: size.width / 37,
              //                   color: const Color(0XFF8A99B1)),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              InkWell(
                onTap: () async {
                  launchUrl.launch("mailto:FindCribs.ng@gmail.com");
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
                            Text("Send an Email",
                                style: TextStyle(
                                  fontFamily: "RedHatDisplay",
                                  fontSize: size.width / 26,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              "We'll reply you as soon as possible",
                              style: TextStyle(
                                  fontSize: size.width / 37,
                                  color: const Color(0XFF8A99B1)),
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
      ),
    );
  }
}
