// ignore_for_file: avoid_print
import 'package:findcribs/controller/get_property_listing_controller.dart';
import 'package:findcribs/controller/search_listing_controller.dart';
import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/screens/homepage/single_property.dart';
import 'package:findcribs/service/search_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../../components/constants.dart';
import '../../controller/load_state_lga_controller.dart';

// ignore: camel_case_types
class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

// ignore: camel_case_types
class _Search_ScreenState extends State<Search_Screen> {
  late Future<List<HouseListModel>> propertyList;
  // late Future<List<FavouriteStoryListModel>> storyList;
  List<HouseListModel> filteredList = [];
  List<HouseListModel> firstList = [];
  List<HouseListModel> searchfilteredList = [];
  List<HouseListModel> firstSearchList = [];
  String searchingText = '';
  final textController = TextEditingController();
  bool isLoading = false;
  bool isSearching = false;
  bool visible = true;
  String state = 'Nigeria';
  String area = '';
  String searchValue = '';

  int page = 1;
  bool _hasNextPage = true;
  late ScrollController _controller;
  String currency = 'Naira';

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool isSearched = false;
  var searchListingController = Get.put(SearchListingController());
  LoadStateLgaController loadStateLgaController =
      Get.put(LoadStateLgaController());
  GetPropertyListingController getPropertyListingController =
      Get.put(GetPropertyListingController());
  @override
  void initState() {
    _controller = ScrollController();

    _controller.addListener(_searchedScrollListener);

    super.initState();
  }

  handleGetMoreSearchedProperties() {
    propertyList = getSearchedProperty(state != 'Nigeria' ? state : '',
        area != '' ? area : '', searchValue != '' ? searchValue : '', page);
    propertyList.then((value) {
      // print(value);
      if (value.isEmpty) {
        setState(() {
          isLoading = false;
          _hasNextPage = false;
          _isLoadMoreRunning = false;
        });
      } else {
        setState(() {
          firstList = value;
          isLoading = false;
          for (int s = 0; s < value.length; s++) {
            filteredList.add(value[s]);
          }
        });
      }
    });
  }

  void _loadMoreSearched() async {
    if (_hasNextPage == true &&
        isSearching == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 600) {
      setState(() {
        // Display a progress indicator at the bottom
        _isLoadMoreRunning = true;
        page += 1;
      });
      propertyList = getSearchedProperty(state != 'Nigeria' ? state : '',
          area != '' ? area : '', searchValue != '' ? searchValue : '', page);
      propertyList.then((value) {
        // print(value);
        if (value.isEmpty) {
          setState(() {
            isSearching = false;
            _hasNextPage = false;
            _isLoadMoreRunning = true;
          });
        } else {
          setState(() {
            firstList = value;
            isSearching = false;
            for (int s = 0; s < value.length; s++) {
              filteredList.add(value[s]);
            }
          });
        }
      });
    } else {
      // print("Nothing is loading");
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  _searchedScrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        _loadMoreSearched();
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
      });
    }
  }

  handleSearchProperty(bool isBottomSheet) {
    isBottomSheet ? Navigator.pop(context) : () {};
    setState(() {
      filteredList = [];
      getPropertyListingController.searchedPropertyList.value = [];
      isSearching = true;
      visible = false;
    });

    propertyList = getSearchedProperty(
        searchListingController.location.string,
        searchListingController.lga.string,
        searchValue != '' ? searchValue : '',
        page);

    propertyList.then((value) {
      setState(() {
        for (int s = 0; s < value.length; s++) {
          filteredList.add(value[s]);
          getPropertyListingController.searchedPropertyList.add(value[s]);
        }
        searchfilteredList = filteredList;
        isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF0F7F8),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.arrow_back_ios)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF9F9F9),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 15.67),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFB1B1B1),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: ((context, setState) {
                              return AnimatedPadding(
                                padding: MediaQuery.of(context).viewInsets,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.decelerate,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 25),
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              const Text("Search By Location"),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Obx(
                                                () => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Location (State)"),
                                                    searchListingController
                                                                .location
                                                                .value ==
                                                            ''
                                                        ? FormBuilderDropdown(
                                                            name: 'location',
                                                            isExpanded: true,
                                                            onChanged: (value) {
                                                              searchListingController
                                                                      .location
                                                                      .value =
                                                                  value
                                                                      .toString();
                                                              loadStateLgaController
                                                                  .handleSearchFetchLga();
                                                            },
                                                            items:
                                                                loadStateLgaController
                                                                    .data
                                                                    .map(
                                                                        (option) {
                                                              return DropdownMenuItem(
                                                                value: option[
                                                                        'state']
                                                                    .toString(),
                                                                child: Text(option[
                                                                        'state']
                                                                    .toString()),
                                                              );
                                                            }).toList(),
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide:
                                                                    const BorderSide(),
                                                              ),
                                                            ),
                                                          )
                                                        : FormBuilderDropdown(
                                                            name: 'State',
                                                            isExpanded: true,
                                                            initialValue:
                                                                searchListingController
                                                                    .location
                                                                    .value,
                                                            onChanged: (value) {
                                                              searchListingController
                                                                      .location
                                                                      .value =
                                                                  value
                                                                      .toString();
                                                              loadStateLgaController
                                                                  .handleSearchFetchLga();
                                                            },
                                                            items:
                                                                loadStateLgaController
                                                                    .data
                                                                    .map(
                                                                        (option) {
                                                              return DropdownMenuItem(
                                                                value: option[
                                                                        'state']
                                                                    .toString(),
                                                                child: Text(option[
                                                                        'state']
                                                                    .toString()),
                                                              );
                                                            }).toList(),
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide:
                                                                    const BorderSide(),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Obx(
                                                () => Visibility(
                                                  visible:
                                                      searchListingController
                                                                  .location
                                                                  .string ==
                                                              ''
                                                          ? false
                                                          : true,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text("LGA"),
                                                        InkWell(
                                                          onTap: () {
                                                            showLga();
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      18.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(searchListingController
                                                                      .lga
                                                                      .string),
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .arrowtriangle_down_fill,
                                                                    size: 12,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.99,
                                                child: ElevatedButton(
                                                  // Connect EndPoint
                                                  onPressed: () {
                                                    handleSearchProperty(true);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          fixedSize: const Size(
                                                              500, 60),
                                                          primary:
                                                              mobileButtonColor),
                                                  child: isLoading
                                                      ? const CircularProgressIndicator()
                                                      : const Text(
                                                          //  Connect EndPoint

                                                          'Filter',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'RedHatDisplay',
                                                              color:
                                                                  mobileButtonTextColor,
                                                              fontSize: 20),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                          });
                    },
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Color(0xFF0072BA),
                    ),
                  ),
                  hintText: "Search Property by type or name"),
              onChanged: (value) {
                setState(() {
                  if (searchValue.isEmpty) {
                    searchValue = '';
                  } else {
                    searchValue = value;
                  }
                });
              },
              onFieldSubmitted: (value) {
                setState(() {
                  searchValue = value;
                });
                handleSearchProperty(false);
              },
              scrollPadding: const EdgeInsets.all(0),
            ),
          ),

          // Container(
          //   margin: const EdgeInsets.only(left: 15),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: [
          //         _buildOptions(context,
          //             label: "Sale", options: ['Sale', "Not Sale"]),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         _buildOptions(context,
          //             label: "Type", options: ['Type', "Not Type"]),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         _buildOptions(context,
          //             label: "Sort", options: ['Sort', "Not Sort"]),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         _buildOptions(context,
          //             label: "Price", options: ['Price', "Not Price"]),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         _buildOptions(context,
          //             label: "Location", options: ['Location', "Not Location"]),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
              child: isLoading == true || isSearching == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchfilteredList.isEmpty
                      ? const Center(child: Text("No result"))
                      : ListView.builder(
                          controller: _controller,
                          shrinkWrap: true,
                          itemCount: searchfilteredList.length,
                          itemBuilder: ((context, index) {
                            int price =
                                (searchfilteredList[index].rentalFee!.toInt());
                            var formatter = NumberFormat("#,###");
                            var formatedPrice = formatter.format(price);
                            return SingleProperty(
                              comingFrom: 'Search',
                              id: searchfilteredList[index].id,
                              image: searchfilteredList[index].image,
                              designType: searchfilteredList[index].designType,
                              currency: searchfilteredList[index].currency,
                              propertyType:
                                  searchfilteredList[index].propertyType,
                              propertyAddress:
                                  searchfilteredList[index].propertyAddress,
                              bedroom: searchfilteredList[index].bedroom,
                              propertyCategory:
                                  searchfilteredList[index].propertyCategory,
                              price: formatedPrice,
                              propertyName: searchfilteredList[index]
                                  .propertyName
                                  .toString(),
                            );
                          }))),
          if (_isLoadMoreRunning == true)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CollectionSlideTransition(
                      children: const <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 6,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 6,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 6,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ]));
  }

  showLga() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: loadStateLgaController.lga.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                searchListingController.lga.value =
                                    loadStateLgaController.lga[index];
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(loadStateLgaController.lga[index]),
                              ),
                            );
                          })),
                ],
              ),
            );
          });
        });
  }
}
