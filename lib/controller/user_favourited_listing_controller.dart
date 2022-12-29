import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constants.dart';
import '../models/user_favourite_listing.dart';
import '../service/user_favourited_listing_service.dart';
import 'package:http/http.dart' as http;

class UserFavouritedListingController extends GetxController {
  late Future<List<UserFavouritedListingModel>> favouritePropertyList;
  var userFavouritedListing = [].obs;
  var favouritedListing = [].obs;
  var isLiked = false.obs;
  @override
  void onInit() {
    handleGetFavouritedListing();
    super.onInit();
  }

  handleGetFavouritedListing() async {
    favouritePropertyList = getUserFavouritedListing();
    favouritePropertyList.then((value) {
      favouritedListing.value = (value);
      for (int x = 0; x < value.length; x++) {
        if (userFavouritedListing.contains(value[x].listing)) {
          // print("already exist in favourited lising");
        } else {
          userFavouritedListing.add(value[x].listingId);
        }
      }
      // print("user favourited Listing : " + userFavouritedListing.toString());

      // print(value);
    });
  }

  handleCheckLike(id) {
    if (userFavouritedListing.contains(id)) {
      isLiked.value = true;
    } else {
      isLiked.value = false;
    }
  }

  handleLike(int? id) async {
    // handleGetFavouritedListing();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    List favouritedListing = userFavouritedListing;
    if (favouritedListing.contains(id)) {
      userFavouritedListing.removeWhere((element) => element == id);
      // favouritedListing.removeWhere((element) => element.listingId == id);
      like(id, token.toString());
    } else {
      userFavouritedListing.add(id);

      // favouritedListing.removeWhere((element) => element.listingId == id);
      like(id, token.toString());
    }
  }

  like(int? id, String token) async {
    await http.put(Uri.parse("$baseUrl/like-listing/$id"), headers: {
      "Authorization": token,
    });
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
