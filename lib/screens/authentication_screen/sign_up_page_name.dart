import 'dart:convert';

// import 'package:find_cribs/favourite_screen/favourite_agent.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_verify_email_page.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:findcribs/widgets/back_arrow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';

class NameScreen extends StatefulWidget {
  final String email;
  final String password1;
  final String password2;
  const NameScreen(
      {Key? key,
      required this.email,
      required this.password1,
      required this.password2})
      : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
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
                const BackArrow(),
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    "Your Name",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Let us know who we are dealing with',
                  style: TextStyle(color: mobileTextSmallColor, fontSize: 14),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'First Name',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  name: 'fName',
                  controller: firstNameController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Last Name',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  name: 'lName',
                  controller: lastNameController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight2,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                      // Connect EndPoint
                      onPressed: () {
                        registerUser(
                          widget.email,
                          widget.password1,
                          widget.password2,
                          firstNameController.text,
                          lastNameController.text,
                        );
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
                            )),
                ),
                mobileSizedBoxHeight,
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
                        Get.off(const LoginScreen());
                        if (kDebugMode) {
                          print('Hello Baby');
                        }
                      },
                      child: const Text(' Login',
                          style: TextStyle(
                              color: mobileButtonColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                mobileBigHeight,
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
                            color: mobileButtonColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(
    String email,
    String password1,
    String password2,
    String firstName,
    String lastName,
  ) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      var deviceToken = prefs.getString('fcmToken');

      final response = await http
          .post(Uri.parse("$baseUrl/auth/register"), body: <String, String>{
        "email": email,
        "password": password1,
        "first_name": firstName,
        "last_name": lastName,
        "deviceToken": deviceToken.toString(),
      });
      var userDetails = jsonDecode(response.body);
      if (userDetails['status'] == true) {
        setState(() {
          isLoading = false;
        });
        final pref = await SharedPreferences.getInstance();
        pref.setString('action', 'Verify');
        pref.setString('email', email);
        pref.setString('password', password1);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          borderSide: const BorderSide(
            color: Colors.green,
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
          desc: userDetails['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.of(context).popUntil((route) => route.isFirst);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return  VerifyEmailScreen(email: email,);
                },
              ),
            );
          },
        ).show();
      } else if (response.statusCode == 500) {
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
          title: "Failed",
          desc: "Something went wrong",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
        setState(() {
          isLoading = false;
        });
        // return
      } else {
        setState(() {
          isLoading = false;
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
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          desc: userDetails['message'],
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }
}
