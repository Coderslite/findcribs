// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/login_controller.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page_password.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:progress_indicators/progress_indicators.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   serverClientId:
  //       '82498358652-u740omqt5f4lc9cvhfdsarhqd8b293ck.apps.googleusercontent.com',
  // );

  bool isLoading = false;
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
    double mobileHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Register or sign in to FindCribs to customise your searches and see your account details.',
                  style: TextStyle(color: mobileTextSmallColor, fontSize: 14),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Email Address',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  name: 'email',
                  controller: emailController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context),
                    FormBuilderValidators.required(context),
                  ]),
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                    // Connect EndPoint
                    onPressed: () {
                      // // Get X Navigation
                      // Get.to(const PasswordScreen(),
                      //     transition: Transition.fadeIn);
                      registerUser(emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(500, 60),
                        primary: mobileButtonColor),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            //  Connect EndPoint

                            'Continue',
                            style: TextStyle(
                                fontFamily: 'RedHatDisplay',
                                color: mobileButtonTextColor,
                                fontSize: 20),
                          ),
                  ),
                ),
                mobileSizedBoxHeight,
                Row(children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(
                          thickness: 0.2,
                          color: mobileTextSmallColor,
                          // height: 5,
                        )),
                  ),
                  const Text(
                    "Or",
                    style: TextStyle(
                        fontFamily: 'RedHatDisplayLight',
                        color: mobileTextSmallColor),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: const Divider(
                          thickness: 0.2,
                          color: mobileTextSmallColor,
                          // height: 5,
                        )),
                  ),
                ]),
                mobileSizedBoxHeight,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: loginController.isLoading.isTrue
                                ? JumpingDotsProgressIndicator()
                                : const Text(
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
                // mobileSizedBoxHeight2,
                // OutlinedButton(
                //   onPressed: () {
                //     handleFacebookSignin();
                //   },
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
                mobileTopHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an Account?',
                      style: TextStyle(color: mobileFormTextColor),
                    ),
                    InkWell(
                      onTap: () {
                        // Connect EndPoint
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const LoginScreen();
                        }));
                      },
                      child: const Text(' Login',
                          style: TextStyle(
                              color: mobileButtonColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                mobileTopHeight,
                const Center(
                  child: Text(
                    'Not ready to register?',
                    style: TextStyle(
                        fontFamily: 'RedHatDisplay',
                        color: mobileTextSmallColor),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageRoot(
                                    navigateIndex: 0,
                                  )));
                    },
                    child: const Text('Skip',
                        style: TextStyle(
                            fontFamily: 'RedHatDisplay',
                            color: mobileButtonColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(String email) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final response = await http
          .post(Uri.parse("$baseUrl/auth/register"), body: <String, String>{
        'email': email,
      });
      var userDetails = jsonDecode(response.body);
      // print(userDetails);

      var emailErrorMessage = "User already exist";
      if (userDetails['message'] == emailErrorMessage) {
        _errorEmail();
        setState(() {
          isLoading = false;
        });
        // return
      } else {
        setState(() {
          isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PasswordScreen(email: email);
        }));
      }
    }
  }

  void _errorEmail() {
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
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      desc: 'Email already exist.',
      showCloseIcon: true,
      btnOkOnPress: () {},
    ).show();
  }

//   handleFacebookSignin() async {
//     final LoginResult result = await FacebookAuth.instance
//         .login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//     if (result.status == LoginStatus.success) {
//       // you are logged
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//   }
}
