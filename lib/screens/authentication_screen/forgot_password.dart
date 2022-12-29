import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/authentication_screen/change_password.dart';
import 'package:findcribs/widgets/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  int sendCount = 0;
  @override
  Widget build(BuildContext context) {
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BackArrow(),
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: mobileTextColor,
                      fontFamily: 'RedHatDisplay',
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'A code has been sent to your registered\nemail address',
                style: TextStyle(
                    color: mobileTextSmallColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 44,
              ),
              FormBuilder(
                key: _formKey,
                child: FormBuilderTextField(
                  name: 'otp',
                  // controller: emailController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
              ),
              mobileSizedBoxHeight,
              SizedBox(
                width: mobileWidth * 0.99,
                child: ElevatedButton(
                  // Connect EndPoint
                  onPressed: () {
                    handleVerifyOtp();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 60),
                      primary: mobileButtonColor),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          //  Connect EndPoint

                          'Verify Code',
                          style: TextStyle(
                              fontFamily: 'RedHatDisplay',
                              color: mobileButtonTextColor,
                              fontSize: 20),
                        ),
                ),
              ),
              mobileSizedBoxHeight,
              sendCount == 0
                  ? Container()
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
                    )
            ],
          ),
        ),
      ),
    );
  }

  handleVerifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        sendCount = sendCount + 1;
      });
      _formKey.currentState!.save();
      var formData = _formKey.currentState!.value;
      var otp = formData['otp'];
      final response = await http.post(
        Uri.parse("$baseUrl/auth/forgot-password/verify"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "otp": otp,
        }),
      );
      var responseData = jsonDecode(response.body);

      if (responseData['status'] == true) {
        setState(() {
          isLoading = false;
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
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ChangePasswordScreen(
                otp: otp,
              );
            }));
          },
        ).show();
      } else {
        setState(() {
          isLoading = false;
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
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ChangePasswordScreen(
                otp: otp,
              );
            }));
          },
        ).show();
      }
    }
  }

  handleResendOtp() async {
    setState(() {
      isLoading = true;
      sendCount = sendCount + 1;
    });
    var prefs = await SharedPreferences.getInstance();

    var email = prefs.getString('email');
    final response = await http.post(
      Uri.parse("$baseUrl/auth/forgot-password"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, String>{
        "email": email.toString(),
      }),
    );
    var responseData = jsonDecode(response.body);

    if (responseData['status'] == true) {
      setState(() {
        isLoading = false;
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
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const ForgotPasswordScreen();
          }));
        },
      ).show();
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
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
