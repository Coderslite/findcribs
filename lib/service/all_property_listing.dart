import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/house_list_model.dart';

class AllPropertyListingController extends GetxController {
  final _client = http.Client();
  final _perPage = 4;
  var propertyType = 'All'.obs;
  var minPrice = ''.obs;
  var maxPrice = ''.obs;
  var category = ''.obs;
  var livingRoom = 0.0.obs;
  var bathroom = 0.0.obs;
  var bedroom = 0.0.obs;
  var kitchen = 0.0.obs;
  var state = ''.obs;
  var lga = ''.obs;
  var isFiltering = false.obs;
  final PagingController<int, HouseListModel> categoryPagingController =
      PagingController(firstPageKey: 1);
  final _posts = <HouseListModel>[];

  List<HouseListModel> get posts => _posts;

  @override
  void onInit() {
    super.onInit();
    categoryPagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
  }

  handleReset() {
    propertyType.value = 'All';
    minPrice.value = '';
    maxPrice.value = '';
    category.value = '';
    livingRoom.value = 0.0;
    bathroom.value = 0.0;
    bedroom.value = 0.0;
    kitchen.value = 0.0;
    state.value = '';
    lga.value = '';
  }

  Future<void> fetchPosts(int pageKey) async {
    var retryCount = 0;
    var type = propertyType.value == 'All' ? '' : propertyType.toString();
    var myLivingroom = livingRoom.value == 0.0 ? '' : livingRoom.toInt();
    var myKitchen = kitchen.value == 0.0 ? '' : kitchen.toInt();
    var myBathroom = bathroom.value == 0.0 ? '' : bathroom.toInt();
    var myBedroom = bedroom.value == 0.0 ? '' : bedroom.toInt();

    try {
      final response = await _client.get(Uri.parse(
          "$baseUrl/search-listing?type=$type&minPrice=$minPrice&maxPrice=$maxPrice&search=$category&livingroom=$myLivingroom&bathroom=$myBathroom&bedroom=$myBedroom&kitchen=$myKitchen&state=$state&lga=$lga&page=$pageKey&size=$_perPage"));

      if (response.statusCode == 200) {
        isFiltering.value = false;
        final data = jsonDecode(response.body);

        List houseData = data['data']['listing'];
        final posts = List<HouseListModel>.from(
            houseData.map((post) => HouseListModel.fromJson(post)));
        if (posts.isNotEmpty) {
          if (pageKey == 1 && categoryPagingController.itemList != null) {
            print("already added");
            // categoryPagingController.itemList!.fillRange(0, 1);
            categoryPagingController.itemList!.clear();

            categoryPagingController.appendPage(posts, pageKey + 2);
          } else {
            categoryPagingController.appendPage(posts, pageKey + 1);
          }
        } else {
          categoryPagingController.appendLastPage(posts);
        }
        _posts.addAll(posts);
      }
    } catch (e) {
      print(e);
    }
  }
}
