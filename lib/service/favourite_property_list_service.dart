// import 'dart:convert';
// import 'package:findcribs/components/constants.dart';
// import 'package:findcribs/models/house_list_model.dart';
// import 'package:http/http.dart' as http;

// Future<List<HouseListModel>> getFavouritePropertyList() async {
//   final response = await http.get(
//     Uri.parse("$baseUrl/listing/get-listing-by-fav"),
//   );
//   var jsonResponse = jsonDecode(response.body);
//   if (jsonResponse['status'] == true) {
//     // return PropertyListModel.fromJson(jsonDecode(response.body));
//     List houseData = jsonResponse['data'];

//     return houseData.map((e) => HouseListModel.fromJson(e)).toList();
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception("No favourite agent yet");
//   }
// }
