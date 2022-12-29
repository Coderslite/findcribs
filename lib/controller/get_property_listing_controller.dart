// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../models/house_list_model.dart';
// import '../service/property_list_service.dart';

// class GetPropertyListingController extends GetxController {
//   var page = 0.obs;
//   var isLoading = true.obs;
//   var isLoadMoreRunning = false.obs;
//   var hasNextPage = true.obs;
//   var firstList = [].obs;
//   var filteredList = [].obs;
//   late Future<List<HouseListModel>> propertyList;

//   handleGetProperties(int page) {
//     propertyList = getPropertyList(
//       page,
//     );
//     // storyList = getFavouriteStoryList();
//     propertyList.then((value) {
//       // print(value);
//       if (value.isEmpty) {
//         isLoading.value = false;
//         hasNextPage.value = false;
//         isLoadMoreRunning.value = false;
//       } else {
//         firstList.value = value;
//         isLoading.value = false;
//         for (int s = 0; s < value.length; s++) {
//           filteredList.add(value[s]);
//         }
//       }
//     });
//   }

//   void loadMore() async {
//     if (hasNextPage == true &&
//         isLoading == false &&
//         isLoadMoreRunning == false ) {
//       // Display a progress indicator at the bottom
//       isLoadMoreRunning.value = true;
//       page.value += 1;
//       propertyList = getPropertyList(
//         page.value,
//       );
//       // storyList = getFavouriteStoryList();
//       propertyList.then((value) {
//         // print(value);
//         if (value.isEmpty) {
//           isLoading.value = false;
//           hasNextPage.value = false;
//           isLoadMoreRunning.value = true;
//         } else {
//           firstList.value = value;
//           isLoading.value = false;
//           for (int s = 0; s < value.length; s++) {
//             filteredList.add(value[s]);
//           }
//         }
//       });
//     } else {
//       print("Nothing is loading");

//       isLoadMoreRunning.value = false;
//     }
//   }

//   handleFilter(String value) {
//     if (value == "All") {
//       // print(value);
//       filteredList = firstList;
//     } else {
//       filteredList.value = firstList.where((element) {
//         return element.propertyType!
//             .toLowerCase()
//             .contains(value.toLowerCase());
//       }).toList();
//     }
//   }



//   @override
//   void onInit() {
//     handleGetProperties(page.value);

//     super.onInit();
//   }

//   @override
//   void onClose() {
 
//     super.onClose();
//   }
// }
