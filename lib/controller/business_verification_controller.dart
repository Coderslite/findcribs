import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';

class BusinessVerificationController extends GetxController {
  var isLoading = false.obs;

  handleVerifyAgent(File file, int id) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final request =
        http.MultipartRequest('PUT', Uri.parse("$baseUrl/agent/$id/verify"));
    request.fields['category'] = 'Agent';
    request.headers['Authorization'] = "$token";
    final httpImage = await http.MultipartFile.fromPath('document', file.path);
    request.files.add(httpImage);
    var response = await request.send();
    // final respStr = await response.stream.bytesToString();
    // var msg = jsonDecode(respStr);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
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
        title: "Successful",
        desc: "Please wait while we review your documents.",
        showCloseIcon: true,
        btnOkText: "Ok",
        btnOkOnPress: () {
          Navigator.pop(Get.context!);
        },
      ).show();
      // print("successfully sent");
    } else {
      isLoading.value = false;
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
        title: "Failed",
        desc: "Something went wrong",
        showCloseIcon: true,
        btnOkText: "Try Again",
        btnCancelOnPress: () {},
      ).show();
      // print("something went wrong");
    }
  }
}
