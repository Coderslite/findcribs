import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ChatMessageModel>> getMessageList() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  var response = await http.get(Uri.parse("$baseUrl/chats"), headers: {
    "Authorization": "$token",
  });
  if (response.statusCode == 200) {
    // return PropertyListModel.fromJson(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    List houseData = jsonResponse;
    // prefs.setString('chats', jsonEncode(jsonResponse));
    return houseData.map((e) => ChatMessageModel.fromJson(e)).toList();
  } else {
    // var chat = prefs.getString('chats');
    // var chatJson = jsonDecode(chat!);
    // List houseData = chatJson;
    // // print(houseData);
    // return houseData.map((e) => ChatMessageModel.fromJson(e)).toList();
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(response.statusCode);
  }
}
