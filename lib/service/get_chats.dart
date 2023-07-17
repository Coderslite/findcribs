// import 'dart:convert';

// import 'package:findcribs/components/constants.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// import '../models/chat_list_model.dart';
// import '../models/house_list_model.dart';

// class HouseByCategoryController extends GetxController {
//   final _client = http.Client();
//   final _perPage = 4;

//   var isFiltering = false.obs;
//   final PagingController<int, ChatMessageModel> categoryPagingController =
//       PagingController(firstPageKey: 0);
//   final _chats = <ChatMessageModel>[];

//   List<ChatMessageModel> get posts => _chats;

//   @override
//   void onInit() {
//     super.onInit();
//     categoryPagingController.addPageRequestListener((pageKey) {
//       fetchPosts(pageKey);
//     });
//   }

//   Future<void> fetchPosts(int pageKey) async {
//     var retryCount = 0;
//     while (retryCount < 3) {
//       try {
//         final response = await _client.get(Uri.parse("$baseUrl/chat"));

//         if (response.statusCode == 200) {
//           isFiltering.value = false;
//           var jsonResponse = jsonDecode(response.body);
//           // print(jsonResponse);
//           List houseData = jsonResponse;
//           final posts = List<ChatMessageModel>.from(
//               houseData.map((post) => ChatMessageModel.fromJson(post)));
//           if (posts.isNotEmpty) {
//             categoryPagingController.appendPage(posts, pageKey + 1);
//           } else {
//             categoryPagingController.appendLastPage(posts);
//           }
//           _chats.addAll(posts);

//           // Break the loop if the response was successful
//           break;
//         } else {
//           throw Exception('Failed to fetch posts');
//         }
//       } catch (e) {
//         retryCount++;
//         if (retryCount == 3) {
//           throw Exception('Error: Failed to fetch posts after 3 retries');
//         }
//       }
//     }
//   }
// }
