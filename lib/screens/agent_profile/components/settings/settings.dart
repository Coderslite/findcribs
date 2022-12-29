import 'package:findcribs/screens/agent_profile/components/settings/components/settings_change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoginCheck = false;
  bool isEmailNotificationCheck = false;
  bool isNotificationCheck = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
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
                  "Settings",
                  style: TextStyle(
                      fontFamily: "RedHatDisplay", fontSize: size.width / 22),
                ),
                const Text("            "),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const ChangePasswordSettings();
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
                          Text("Security",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: size.width / 26,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            "Change your password",
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
            // const SizedBox(
            //   height: 10,
            // ),
            // // Container(
            // //   padding: const EdgeInsets.only(
            // //     top: 5,
            // //     bottom: 5,
            // //     right: 15,
            // //     left: 15,
            // //   ),
            // //   decoration: BoxDecoration(
            // //     border: Border.all(
            // //       color: Colors.grey.withOpacity(0.5),
            // //       width: 1,
            // //     ),
            // //     borderRadius: BorderRadius.circular(10),
            // //   ),
            // //   child: Row(
            // //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // //     children: [
            // //       Padding(
            // //         padding: const EdgeInsets.all(8.0),
            // //         child: Column(
            // //           crossAxisAlignment: CrossAxisAlignment.start,
            // //           children: [
            // //             Text("Login",
            // //                 style: TextStyle(
            // //                   fontFamily: "RedHatDisplay",
            // //                   fontSize: size.width / 26,
            // //                   fontWeight: FontWeight.bold,
            // //                 )),
            // //             Text(
            // //               "Always login before accessing app content",
            // //               style: TextStyle(
            // //                   fontSize: size.width / 37,
            // //                   color: const Color(0XFF8A99B1)),
            // //             ),
            // //           ],
            // //         ),
            // //       ),
            // //       // Icon(
            // //       //   Icons.arrow_forward_ios_outlined,
            // //       //   size: size.width / 26,
            // //       FlutterSwitch(
            // //         width: 55.0,
            // //         height: 28.0,
            // //         // valueFontSize: 15.0,
            // //         toggleSize: 22.0,
            // //         value: isLoginCheck,
            // //         inactiveColor: const Color(0XFFEBEBEB),
            // //         borderRadius: 40.0,
            // //         // padding: 8.0,
            // //         // showOnOff: true,
            // //         onToggle: (val) {
            // //           setState(() {
            // //             isLoginCheck = val;
            // //           });
            // //         },
            // //       ),
            // //     ],
            // //   ),
            // // ),
            // // const SizedBox(
            // //   height: 10,
            // // ),
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
            //             Text("Notifications",
            //                 style: TextStyle(
            //                   fontFamily: "RedHatDisplay",
            //                   fontSize: size.width / 26,
            //                   fontWeight: FontWeight.bold,
            //                 )),
            //             Text(
            //               "Turn your notification on",
            //               style: TextStyle(
            //                   fontSize: size.width / 37,
            //                   color: const Color(0XFF8A99B1)),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Icon(
            //       //   Icons.arrow_forward_ios_outlined,
            //       //   size: size.width / 26,
            //       FlutterSwitch(
            //         width: 55.0,
            //         height: 28.0,
            //         // valueFontSize: 15.0,
            //         toggleSize: 22.0,
            //         value: isNotificationCheck,
            //         inactiveColor: const Color(0XFFEBEBEB),
            //         borderRadius: 40.0,
            //         // padding: 8.0,
            //         // showOnOff: true,
            //         onToggle: (val) {
            //           setState(() {
            //             isNotificationCheck = val;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
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
            //             Text("Emails",
            //                 style: TextStyle(
            //                   fontFamily: "RedHatDisplay",
            //                   fontSize: size.width / 26,
            //                   fontWeight: FontWeight.bold,
            //                 )),
            //             Text(
            //               "Receive email alerts for every notifications",
            //               style: TextStyle(
            //                   fontSize: size.width / 37,
            //                   color: const Color(0XFF8A99B1)),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Icon(
            //       //   Icons.arrow_forward_ios_outlined,
            //       //   size: size.width / 26,
            //       FlutterSwitch(
            //         width: 55.0,
            //         height: 28.0,
            //         // valueFontSize: 15.0,
            //         toggleSize: 22.0,
            //         value: isEmailNotificationCheck,
            //         inactiveColor: const Color(0XFFEBEBEB),
            //         borderRadius: 40.0,
            //         // padding: 8.0,
            //         // showOnOff: true,
            //         onToggle: (val) {
            //           setState(() {
            //             isEmailNotificationCheck = val;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      )),
    );
  }
}
