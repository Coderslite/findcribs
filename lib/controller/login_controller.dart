import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_verify_email_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_up_page.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isLogin = false.obs;
  GoogleSignInAccount? _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "email",
      "profile",
      "openid"
      // "https://www.googleapis.com/auth/userinfo.email",
    ],
  );

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('fcmToken');

    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
        "deviceToken": "$token",
      }),
    );
    var userDetails = jsonDecode(response.body);

    if (userDetails['status'] == true) {
      var token = userDetails['data']['token'];

      isLoading.value = false;
      isLogin.value = true;

      prefs.setString('token', token.toString());
      prefs.setString('email', email.toString());

      prefs.setString('action', 'LoggedIn');
      Get.off(HomePageRoot(navigateIndex: 0));
      // return ;
    } else {
      isLoading.value = false;

      if (userDetails['message'] == 'Email is unverified') {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          width: 280,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          desc: userDetails['message'],
          showCloseIcon: true,
          btnOkText: "Verify Now",
          btnOkOnPress: () {
            Get.to(VerifyEmailScreen(
              email: email,
            ));
          },
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          width: 280,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          desc: userDetails['message'],
          showCloseIcon: true,
          btnOkText: "Try again",
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  handleLoginApi(String token) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    var deviceToken = prefs.getString('fcmToken');
    var response = await http.post(
        Uri.parse("http://18.233.168.44:5000/google-auth/oauth/verify"),
        headers: {
          "Authorization": "Bearer $token",
        },
        body: {
          "deviceToken": deviceToken.toString(),
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      isLogin.value = true;
      var jsonData = jsonDecode(response.body);
      var token = jsonData['token'];
      prefs.setString('token', token);
      prefs.setString('action', 'LoggedIn');
      Get.off(HomePageRoot(navigateIndex: 0));
    } else {
      isLoading.value = false;

      Fluttertoast.showToast(msg: "Email already in the database")
          .then((value) => handleGoogleLogout());
    }
  }

  handleSilentLogin() async {
    final googleUser2 = await _googleSignIn.signInSilently();
    if (googleUser2 != null) {
      final googleAuth = await googleUser2.authentication;
      var myToken = googleAuth.idToken!;
      handleLoginApi(myToken);
    } else {
      isLoading.value = false;
      handleGoogleLogout();
      Fluttertoast.showToast(msg: "Fail to sign in, please retry");
      isLogin.value = false;
    }
  }

  handleNormalSigniin() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      var myToken = googleAuth.idToken!;
      handleLoginApi(myToken);
    } else {
      isLoading.value = false;
      handleGoogleLogout();
      Fluttertoast.showToast(msg: "Fail to sign in, please retry");

      isLogin.value = false;
    }
  }

  handleGoogleSignin() async {
    isLoading.value = true;

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
    });
    if (_currentUser != null) {
      handleSilentLogin();
    } else {
      handleNormalSigniin();
    }
  }

  handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('action', '');
    prefs.remove('token');
    prefs.remove('email');
    _googleSignIn.signOut().then((value) => Get.off(const LoginScreen()));
  }

  handleGoogleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('action', '');
    prefs.remove('token');
    prefs.remove('email');

    _googleSignIn.signOut().then((value) => Get.off(const EmailScreen()));
  }
}
