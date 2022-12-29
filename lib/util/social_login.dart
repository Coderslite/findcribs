import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/constants.dart';
import '../controller/login_controller.dart';
import '../screens/authentication_screen/sign_up_page.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var mobileWidth = MediaQuery.of(context).size.width;
    var mobileHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        height: 150,
        child: Column(children: [
          OutlinedButton(
            onPressed: () {
              loginController.handleGoogleSignin();
            },
            child: SizedBox(
              height: mobileHeight * .08,
              width: mobileWidth * 99,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/icons/goog_le.png',
                      height: 23,
                      width: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                            color: mobileTextColor,
                            fontFamily: 'RedHatDisplayLight',
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ]),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // OutlinedButton(
          //   onPressed: () {},
          //   child: SizedBox(
          //     height: mobileHeight * .08,
          //     width: mobileWidth * 99,
          //     child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             'lib/assets/icons/fb.png',
          //             height: 25,
          //             width: 30,
          //           ),
          //           const Padding(
          //             padding: EdgeInsets.only(left: 8),
          //             child: Text(
          //               'Continue with Facebook',
          //               style: TextStyle(
          //                   color: mobileTextColor,
          //                   fontFamily: 'RedHatDisplayLight',
          //                   fontWeight: FontWeight.w600),
          //             ),
          //           )
          //         ]),
          //   ),
          // ),

          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dont have an account?',
                style: TextStyle(color: mobileFormTextColor),
              ),
              InkWell(
                onTap: () {
                  // Connect EndPoint
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const EmailScreen();
                  }));
                },
                child: const Text(
                  ' Signup',
                  style: TextStyle(
                    color: mobileButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
