// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/previous_message_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<PreviousMessageModel>> getPreviousChat(id) async {
  final prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  final response = await http.get(
    Uri.parse("$baseUrl/chat/previous-chat-messages/2"),
    headers: {
      "Authorization": "Bearer $token",
    },
  );
  if (response.statusCode == 201) {
    var jsonResponse = jsonDecode(response.body);
    List previousMessageList = jsonResponse['data'];
    // print(previousMessageList);

    return previousMessageList
        .map((e) => PreviousMessageModel.fromJson(e))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
