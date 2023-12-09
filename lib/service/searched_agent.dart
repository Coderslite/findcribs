// import 'dart:convert';

// import 'package:findcribs/components/constants.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/unfavourite_agent.dart';

// class SearchedAgentController extends GetxController {
//   final _client = http.Client();
//   final _perPage = 4;
//   var isFiltering = false.obs;
//   final PagingController<int, UserUnFavouritedAgentModel>
//       agentPagingController = PagingController(firstPageKey: 1);
//   final _posts = <UserUnFavouritedAgentModel>[];
//   var searchQuery = ''.obs;

//   List<UserUnFavouritedAgentModel> get posts => _posts;

//   @override
//   void onInit() {
//     super.onInit();
//     agentPagingController.addPageRequestListener((pageKey) {});
//   }

//   handleReset() {
//     searchQuery.value = "";
//   }

//   Future<void> fetchAgents(
//     int pageKey,
//   ) async {
//     var prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString('token');
//     try {
//       final response = await _client.get(
//           Uri.parse(
//               "$baseUrl/agent/search?query=${searchQuery.value}&page=$pageKey&size=$_perPage"),
//           headers: {
//             "authorization": "$token",
//           });

//       if (response.statusCode == 200) {
//         isFiltering.value = false;
//         final data = jsonDecode(response.body);
//         List agents = data['data']['agents'];
//         print(agents);
//         final posts = List<UserUnFavouritedAgentModel>.from(
//             agents.map((post) => UserUnFavouritedAgentModel.fromJson(post)));
//         if (posts.isNotEmpty) {
//           if (pageKey == 1 && agentPagingController.itemList != null) {
//             print("already added");
//             // categoryPagingController.itemList!.fillRange(0, 1);
//             agentPagingController.itemList!.clear();

//             agentPagingController.appendPage(posts, pageKey + 2);
//           } else {
//             agentPagingController.appendPage(posts, pageKey + 1);
//           }
//         } else {
//           agentPagingController.appendLastPage(posts);
//         }
//         _posts.addAll(posts);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
