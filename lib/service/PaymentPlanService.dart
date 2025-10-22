import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/payment_plan_model.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class PaymentplanService {
  Future<List<PaymentPlanModel>> getPlans() async {
    List<PaymentPlanModel> plans = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var res = await http.get(
      Uri.parse("$baseUrl/subscriptions"),
      headers: {
        "Authorization": token,
      },
    );
    var resBody = jsonDecode(res.body);
    List data = resBody['data'];
    plans = data.map((plan) => PaymentPlanModel.fromJson(plan)).toList();
    return plans;
  }
}
