// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page_name.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../widgets/back_arrow.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  const PasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  // regular expression to check if string
  // ignore: non_constant_identifier_names
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  bool isVisible1 = true;
  bool isVisible2 = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  var passwordController1 = TextEditingController();
  var passwordController2 = TextEditingController();
  bool isMatch = false;

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
    // double mobileHeight = MediaQuery.of(context).size.height;
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
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    "Set Password",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Ensure your password is at least 10 '
                  'characters mixed with letters, numbers & special character',
                  style: TextStyle(color: mobileTextSmallColor, fontSize: 14),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Password',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                TextFormField(
                  controller: passwordController1,
                  obscureText: isVisible1,
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(context, 6),
                    ],
                  ),
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
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
                  'Retype password',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                TextFormField(
                  controller: passwordController2,
                  obscureText: isVisible2,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                    if (passwordController1.text == passwordController2.text) {
                      setState(() {
                        isMatch = true;
                      });
                    } else {
                      setState(() {
                        isMatch = false;
                      });
                    }
                  },
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(context, 6),
                      FormBuilderValidators.equal(
                          context, passwordController1.text),
                    ],
                  ),
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
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                      // Connect EndPoint
                      onPressed: () {
                        !isMatch
                            ? null
                            : handlePasswordValidate(passwordController1.text,
                                passwordController2.text, widget.email);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 60),
                          primary: !isMatch ? Colors.grey : mobileButtonColor),
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
                        Get.off(const EmailScreen());
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

  handlePasswordValidate(password1, password2, email) async {
    if (_formKey.currentState!.validate()) {
      if (password1 == password2) {
        setState(() {
          isLoading = true;
        });
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return NameScreen(
              email: email, password1: password1, password2: password2);
        }));
      } else {
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
          desc: 'Password do not match.',
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }
}
