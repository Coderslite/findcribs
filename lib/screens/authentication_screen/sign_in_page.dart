import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/authentication_screen/forgot_password_email_verify.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isVisible = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginController loginController = LoginController();


  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
    // double mobileHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                mobileSizedBoxHeight,
                const Text(
                  'Email Address',
                  style: TextStyle(
                      color: mobileFormTextColor,
                      fontFamily: 'RedHatDisplayLight',
                      fontSize: 12),
                ),
                mobileSizedBoxHeight2,
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
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
                  controller: passwordController,
                  obscureText: isVisible,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      // hintText: 'Enter Email Address',
                      border:
                          const OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const ForgetPasswordEmailVerifyScreen();
                        }));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: mobileButtonColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                mobileSizedBoxHeight2,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                    // Connect EndPoint
                    onPressed: () {
                      loginController.login(
                          emailController.text, passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(500, 60),
                        primary: mobileButtonColor),
                    // ignore: unrelated_type_equality_checks
                    child: loginController.isLoading == true
                        ? const CircularProgressIndicator()
                        : const Text(
                            //  Connect EndPoint

                            'Login',
                            style: TextStyle(
                                fontFamily: 'RedHatDisplay',
                                color: mobileButtonTextColor,
                                fontSize: 20),
                          ),
                  ),
                ),
                mobileSizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New Here?',
                      style: TextStyle(color: mobileFormTextColor),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const EmailScreen();
                        }));
                      },
                      child: const Text(' Sign Up',
                          style: TextStyle(
                              color: mobileButtonColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
