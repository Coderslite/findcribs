// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../../../components/constants.dart';

class ChangePasswordSettings extends StatefulWidget {
  const ChangePasswordSettings({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSettings> createState() => _ChangePasswordSettingsState();
}

class _ChangePasswordSettingsState extends State<ChangePasswordSettings> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  bool isVisible1 = true;
  bool isVisible2 = true;

  String oldPassword = '';
  String newPassword1 = '';
  String newpassword2 = '';

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
    var size = MediaQuery.of(context).size;
    double mobileWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Change Password",
                      style: TextStyle(
                          fontFamily: "RedHatDisplay",
                          fontSize: size.width / 22),
                    ),
                    const Text("            "),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mobileSizedBoxHeight,
                      const Text(
                        'Old Password',
                        style: TextStyle(
                            color: mobileFormTextColor,
                            fontFamily: 'RedHatDisplayLight',
                            fontSize: 14),
                      ),
                      FormBuilderTextField(
                        name: 'oldPassword',
                        onChanged: (value) {
                          setState(() {
                            oldPassword = value.toString();
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
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
                            border: const OutlineInputBorder(
                                borderSide: BorderSide())),
                      ),
                      mobileSizedBoxHeight2,
                      const Text(
                        'New Password',
                        style: TextStyle(
                            color: mobileFormTextColor,
                            fontFamily: 'RedHatDisplayLight',
                            fontSize: 14),
                      ),
                      mobileSizedBoxHeight2,
                      FormBuilderTextField(
                        name: 'password1',
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                          setState(() {
                            newPassword1 = value.toString();
                          });
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
                            border: const OutlineInputBorder(
                                borderSide: BorderSide())),
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
                        validator: (value) {
                          if (newPassword1 != value) {
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
                          setState(() {
                            newpassword2 = value.toString();
                          });
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
                            border: const OutlineInputBorder(
                                borderSide: BorderSide())),
                      ),
                      mobileSizedBoxHeight,
                      mobileSizedBoxHeight2,
                      SizedBox(
                        width: mobileWidth * 0.99,
                        child: ElevatedButton(
                            // Connect EndPoint
                            onPressed: () {
                              !isMatch ? null : handleChangePassword();
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(500, 60),
                                primary:
                                    !isMatch ? Colors.grey : mobileButtonColor),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    //  Connect EndPoint

                                    'Change Password',
                                    style: TextStyle(
                                        fontFamily: 'RedHatDisplay',
                                        color: mobileButtonTextColor,
                                        fontSize: 20),
                                  )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleChangePassword() async {
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
        var token = prefs.getString('token');
        final response = await http.put(
          Uri.parse("$baseUrl/auth/change-password"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$token",
          },
          body: jsonEncode(
            <String, String>{
              "oldPassword": oldPassword,
              "newPassword": newPassword1,
              // "confirmPassword": password2,
              // "otp": widget.otp,
            },
          ),
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
              Navigator.pop(context);
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
  }
}
