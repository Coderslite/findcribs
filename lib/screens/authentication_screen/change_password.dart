// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../components/constants.dart';
import '../../widgets/back_arrow.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String otp;
  const ChangePasswordScreen({Key? key, required this.otp}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  bool isVisible1 = true;
  bool isVisible2 = true;

  var passwordController1 = TextEditingController();
  var passwordController2 = TextEditingController();
  bool isMatch = false;

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 10) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BackArrow(),
                const Padding(
                  padding: EdgeInsets.only(top: 110),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'New Password',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 14),
                ),
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  controller: passwordController1,
                  name: 'password1',
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    } else {
                      //call function to check password
                      bool result = validatePassword(value);
                      if (result) {
                        // create account event
                        return null;
                      } else {
                        return " Password should contain Capital, small letter & Number & Special";
                      }
                    }
                  },
                  // controller: emailController,
                  decoration: InputDecoration(
                      // hintText: 'Enter Email Address',
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible1 = !isVisible1;
                            });
                          },
                          child: Icon(isVisible1
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide())),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LinearProgressIndicator(
                    value: password_strength,
                    backgroundColor: Colors.grey[300],
                    minHeight: 5,
                    color: password_strength <= 1 / 4
                        ? Colors.red
                        : password_strength == 2 / 4
                            ? Colors.yellow
                            : password_strength == 3 / 4
                                ? Colors.blue
                                : Colors.green,
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Retype New Password',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 14),
                ),
                mobileSizedBoxHeight2,
                FormBuilderTextField(
                  name: 'password2',
                  controller: passwordController2,
                  validator: (value) {
                    if (passwordController1.text != value) {
                      setState(() {
                        isMatch = false;
                      });
                      return "Password do not match";
                    } else if (password_strength != 1) {
                      setState(() {
                        isMatch = false;
                      });
                      return " Password should contain Capital, small letter & Number & Special";
                    } else {
                      setState(() {
                        isMatch = true;
                      });
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  decoration: InputDecoration(
                      // hintText: 'Enter Email Address',
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible2 = !isVisible2;
                            });
                          },
                          child: Icon(isVisible2
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                mobileSizedBoxHeight2,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                      // Connect EndPoint
                      onPressed: () {
                        !isMatch
                            ? null
                            : handleChangePassword(passwordController1.text);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 60),
                          primary: !isMatch ? Colors.grey : mobileButtonColor),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              //  Connect EndPoint

                              'Reset Password',
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  color: mobileButtonTextColor,
                                  fontSize: 20),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleChangePassword(String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      var formData = _formKey.currentState!.value;
      var password1 = formData['password1'];
      var password2 = formData['password2'];

      if (password1 != password2) {
      } else {
        var prefs = await SharedPreferences.getInstance();
        var email = prefs.getString('email');

        final response = await http.post(
          Uri.parse("$baseUrl/auth/forgot-password/reset"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, String>{
            "email": email.toString(),
            "password": password,
            // "confirmPassword": password2,
            "otp": widget.otp,
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
            title: 'Password Reset Successfully',
            desc: "You have successfully reset your password, Login now",
            showCloseIcon: true,
            btnOkOnPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const LoginScreen();
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
            title: 'Failed',
            desc: responseData['message'],
            showCloseIcon: true,
            btnOkOnPress: () {},
          ).show();
        }
      }
    }
  }
}
