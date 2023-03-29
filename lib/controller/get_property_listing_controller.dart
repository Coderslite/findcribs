import 'package:findcribs/service/property_list_service.dart';
import 'package:get/get.dart';
import '../models/house_list_model.dart';

class GetPropertyListingController extends GetxController {
  late Future<List<HouseListModel>> propertyList;

  var page = 1.obs;
  var isLoading = false.obs;
  var hasNextPage = true.obs;
  var isLoadingMore = false.obs;
  var isLoadMoreRunning = false.obs;
  var firstList = [].obs;
  var filteredList = [].obs;
  var searchedPropertyList = [].obs;

  handleGetProperties(int page) {
    isLoading.value = true;
    propertyList = getPropertyList(
      page,
    );
    // storyList = getFavouriteStoryList();
    propertyList.then((value) {
      // print(value);
      if (value.isEmpty) {
        isLoading.value = false;
        hasNextPage.value = false;
        isLoadMoreRunning.value = false;
      } else {
        firstList.value = value;
        isLoading.value = false;
        for (int s = 0; s < value.length; s++) {
          filteredList.add(value[s]);
        }
      }
    });
  }

  void loadMore() async {
    if (hasNextPage.isTrue && isLoading.isFalse && isLoadMoreRunning.isFalse) {
      isLoadMoreRunning.value = true;
      page += 1;
      propertyList = getPropertyList(
        page.value,
      );
      // storyList = getFavouriteStoryList();
      propertyList.then((value) {
        // print(value);
        if (value.isEmpty) {
          isLoading.value = false;
          hasNextPage.value = false;
          isLoadMoreRunning.value = true;
        } else {
          firstList.value = value;
          isLoading.value = false;
          for (int s = 0; s < value.length; s++) {
            filteredList.add(value[s]);
          }
        }
      });
    } else {
      print("Nothing is loading");
      isLoadMoreRunning.value = false;
    }
  }

  // generateList() {
  //  allProperties = List.generate(
  //       page, (index) => Model(name: (index + 1).toString()));
  // }

  @override
  void onInit() {
    // generateList();
    handleGetProperties(page.value);
    super.onInit();
  }
}
