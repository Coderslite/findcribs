import 'package:findcribs/components/constants.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PropertyViewController extends GetxController {
  handlePropertyView(int propertyId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var response = await http
          .post(Uri.parse("$baseUrl/listing/$propertyId/view"), headers: {
        "authorization": "$token",
      });
      print(response.body);
    } catch (err) {
      print(err);
    }
  }
}
