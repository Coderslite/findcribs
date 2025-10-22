import 'package:findcribs/models/house_list_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';
import '../service/user_favourited_listing_service.dart';
import 'package:http/http.dart' as http;

class UserFavouritedListingController extends GetxController {
  var favouritedListing = [].obs;
  var isLiked = false.obs;
  @override
  void onInit() {
    handleGetFavouritedListing();
    super.onInit();
  }

  handleGetFavouritedListing() async {
    // favouritedListing.clear();
    var result = await getUserFavouritedListing();
    for (int x = 0; x < result.length; x++) {
      if (favouritedListing.contains(result[x].id)) {
      } else {
        favouritedListing.add(result[x]);
      }
    }
    // print("user favourited Listing : " + userFavouritedListing.toString());

    // print(value);
  }

  handleCheckLike(id) {
    if (favouritedListing.contains(id)) {
      isLiked.value = true;
    } else {
      isLiked.value = false;
    }
  }

  handleLike(HouseListModel listing) async {
    // handleGetFavouritedListing();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    favouritedListing.add(listing);
    await like(listing.id, token.toString());
    if (favouritedListing
        .where((e) => e.id == listing.id)
        .toList()
        .isNotEmpty) {
      favouritedListing.removeWhere((e) => e.id == listing.id);
    }
    await handleGetFavouritedListing();
  }

  like(int? id, String token) async {
    var res = await http.put(Uri.parse("$baseUrl/like-listing/$id"), headers: {
      "Authorization": token,
    });
    print(res.body);
    return;
  }

  //   handleGetLikedProperties() {
  //   favouritePropertyList = getUserFavouritedListing();
  //   favouritePropertyList.then((value) {
  //     // print(value);
  //     if (mounted) {
  //       setState(() {
  //         firstFavouritePropertyList = filteredFavouritePropertyList = value;
  //         handleFilter(widget.id.toString());
  //       });
  //       print(firstFavouritePropertyList);
  //     }
  //   });
  // }

  @override
  void onClose() {
    handleGetFavouritedListing();
    super.onClose();
  }
}
