import 'dart:convert';

import 'package:findcribs/components/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/house_list_model.dart';

class HouseListingController extends GetxController {
  final _client = http.Client();
  final _perPage = 3;
  final PagingController<int, HouseListModel> pagingController =
      PagingController(firstPageKey: 0);
  final _posts = <HouseListModel>[];
  final error = "Nothing Found";

  List<HouseListModel> get posts => _posts;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final response = await _client.get(Uri.parse(
          "$baseUrl/listing?status=Active&page=$pageKey&size=$_perPage"));
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List houseData = data['data']['listing'];
        final posts = List<HouseListModel>.from(
           houseData.map((post) => HouseListModel.fromJson(post)));
        if (posts.isNotEmpty) {
          pagingController.appendPage(posts, pageKey + 1);
        } else {
          pagingController.appendLastPage(posts);
        }
        _posts.addAll(posts);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
