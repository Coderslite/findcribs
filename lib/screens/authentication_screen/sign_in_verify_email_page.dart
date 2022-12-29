import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page.dart';
import 'package:findcribs/screens/authentication_screen/verified.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  var formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool resendingOtp = false;

  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const BackArrow(),
                const Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Text(
                    "Verify Account",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'A code has been sent to your registered email address',
                  style: TextStyle(color: mobileTextSmallColor, fontSize: 14),
                ),
                // mobileSizedBoxHeight,
                // mobileSizedBoxHeight,

                mobileSizedBoxHeight,
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  name: 'code',
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.maxLength(context, 4),
                    FormBuilderValidators.minLength(context, 4)
                  ]),
                  decoration: const InputDecoration(
                      hintText: 'Enter Code',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                      // Connect EndPoint
                      onPressed: () {
                        handleVerify();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 60),
                          primary: mobileButtonColor),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              //  Connect EndPoint

                              'Verify Account',
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  color: mobileButtonTextColor,
                                  fontSize: 20),
                            )),
                ),
                mobileSizedBoxHeight,
                resendingOtp
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Didn’t get code?',
                            style: TextStyle(
                                color: mobileColorForText,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplayLight'),
                          ),
                          InkWell(
                            onTap: () {
                              // Connect EndPoint
                              handleResendOtp();
                            },
                            child: const Text(' Resend',
                                style: TextStyle(
                                    color: mobileButtonColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const EmailScreen();
                          }));
                        },
                        child: const Text("create a new account ?")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleVerify() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final formData = formKey.currentState!.value;
      final code = formData['code'];
      final prefs = await SharedPreferences.getInstance();
      final response = await http
          .post(Uri.parse("$baseUrl/auth/verify-email"), body: <String, String>{
        "otp": code,
      });
      var userDetails = jsonDecode(response.body);
      if (userDetails['status'] == false) {
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
      } else {
        setState(() {
          isLoading = false;
        });
        var token = userDetails['data'];
        prefs.setString('action', 'LoggedIn');

        prefs.setString('token', token);
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const VerifiedScreen();
        }));
      }
    }
  }

  handleResendOtp() async {
    setState(() {
      resendingOtp = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    // ignore: avoid_print
    print(storedEmail);
    final response = await http
        .post(Uri.parse("$baseUrl/auth/resend-token"), body: <String, String>{
      "email":
          widget.email == '' ? storedEmail.toString() : widget.email.toString()
    });
    var userDetails = jsonDecode(response.body);
    if (userDetails['status'] == true) {
      setState(() {
        resendingOtp = false;
      });
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
        btnOkOnPress: () {},
      ).show();
    } else {
      print(userDetails['message']);
      setState(() {
        resendingOtp = false;
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
