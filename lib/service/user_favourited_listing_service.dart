// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/user_favourite_listing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/house_list_model.dart';

Future<List<HouseListModel>> getUserFavouritedListing() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  var response =
      await http.get(Uri.parse("$baseUrl/listing/favourites"), headers: {
    "Authorization": "$token",
  });
  var userData = jsonDecode(response.body);
  if (userData['status'] == true) {
    List favouritedProperty = userData['data']['listingLikes'];
    return favouritedProperty
        .map((e) => HouseListModel.fromJson(e['listing']))
        .toList();
  } else {
    print(userData['message']);
    throw Exception(response.statusCode);
  }
}
