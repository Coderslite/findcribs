import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../components/constants.dart';
import '../screens/agent_profile/components/business_detail/listings/promotion page/pay_webview.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var isClicked = false.obs;

  Future<Map<String, dynamic>> getAccessCode(int id) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("$baseUrl/subscribe"),
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, int>{
          "subscriptionId": id,
        }),
      );
      print(response.body);
      var resData = jsonDecode(response.body);
      Map<String, dynamic> url = resData['data'];
      return url;
    } finally {
      isLoading.value = false;
    }
  }

  handlePay(int id, StatefulWidget returnUrl) async {
    try {
      isClicked.value = true;
      var res = await getAccessCode(id);
      // print(accessCode);
      // final response = await _paystack.launch(accessCode['authorization_url']);

      await WebViewExample(
        referenceId: res['reference'],
        webLink: res['authorization_url'],
        returnUrl: returnUrl,
      ).launch(Get.context!);
      // if (response.status == "success") {
      //   Get.snackbar(
      //     "Payment Successful",
      //     "your payment was successful",
      //     backgroundColor: mediumSeaGreen,
      //     colorText: white,
      //   );
      // } else if (response.status == "cancelled") {
      //   Get.snackbar(
      //     "Payment Cancelled",
      //     "your payment was not successful",
      //     backgroundColor: fireBrick,
      //     colorText: white,
      //   );
      // } else {}
    } finally {
      isLoading.value = false;
      isClicked.value = false;
    }
  }

  Future confirmPayment(String reference) async {
    var res = await http
        .post(Uri.parse("$baseUrl/confirm-payment-status/$reference"));
    var body = res.body;
    var resData = jsonDecode(body);
    print(resData);
  }
}
