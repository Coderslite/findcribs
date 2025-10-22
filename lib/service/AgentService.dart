import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';
import '../models/most_favourited_model.dart';
import '../models/user_profile_information_model.dart';
import 'package:http/http.dart' as http;

class AgentService {
  Future<UserProfile> getUserById(int? id) async {
    try {
      print("agent id $id");
      final prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(
          "$baseUrl/profile/$id",
        ),
        headers: {
          "Authorization": "$token",
        },
      );
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        if (responseData['data']?['profile']?['subscriptionLogs'] is List &&
            (responseData['data']?['profile']?['subscriptionLogs'] as List)
                .isEmpty) {
          responseData['data']?['profile']?['subscriptionLogs'] = {};
        }
        return UserProfile.fromJson(responseData['data']['profile']);
      } else {
        print(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }

  Future<List<MostFavouritedModel>> getSuggestedAgents() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response =
        await http.get(Uri.parse("$baseUrl/agent/random-agents"), headers: {
      "Authorization": "$token",
    });
    var responseJson = jsonDecode(response.body);
    List agents = responseJson['data'];
    return agents.map((e) => MostFavouritedModel.fromJson(e)).toList();
  }
}
