// import 'dart:convert';
// import 'package:find_cribs/components/constants.dart';
// import 'package:find_cribs/models/favourite_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// Future<List<FavouriteStoryListModel>> getFavouriteStoryList() async {
//   final prefs = await SharedPreferences.getInstance();

//   var token = prefs.getString('token');
//   final response = await http.get(
//       Uri.parse(
//         "$baseUrl/moment/moments-by-user",
//       ),);
//   if (response.statusCode == 200) {
//     // return PropertyListModel.fromJson(jsonDecode(response.body));
//     var jsonResponse = jsonDecode(response.body);
//     List favouriteData = jsonResponse['data'];
//     // print(favouriteData);

//     return favouriteData
//         .map((e) => FavouriteStoryListModel.fromJson(e))
//         .toList();
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.

//     throw Exception(response.statusCode);
//   }
// }
