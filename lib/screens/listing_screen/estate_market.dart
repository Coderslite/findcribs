import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';
import '../../controller/load_state_lga_controller.dart';
import '../../models/house_list_model.dart';
import '../../service/property_by_category.dart';
import '../../widgets/loading_widget.dart';
import '../homepage/single_property.dart';

class EstateMarketScreen extends StatefulWidget {
  const EstateMarketScreen({super.key});

  @override
  State<EstateMarketScreen> createState() => _EstateMarketScreenState();
}

class _EstateMarketScreenState extends State<EstateMarketScreen> {
  late Future<List<HouseListModel>> propertyList;
  List<HouseListModel> filteredList = [];
  List<HouseListModel> firstList = [];
  List<HouseListModel> searchfilteredList = [];
  List<HouseListModel> firstSearchList = [];
  String searchingText = '';
  final textController = TextEditingController();
  HouseByCategoryController houseController =
      Get.put(HouseByCategoryController());
  LoadStateLgaController loadStateLgaController =
      Get.put(LoadStateLgaController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  handleFilter() {
    houseController.isFiltering.value = true;
    houseController.categoryPagingController.itemList!.clear();
    houseController.fetchPosts(0);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      houseController.category.value = 'Estate Market';
      houseController.fetchPosts(0);
      houseController.isFiltering.value = true;
      houseController.categoryPagingController.itemList!.clear();
    });
    super.initState();
  }

  @override
  void dispose() {
    houseController.handleReset();
    houseController.categoryPagingController.itemList!.clear();
    houseController.fetchPosts(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0XFFF0F7F8),
                        borderRadius: BorderRadius.circular(13)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset("assets/svgs/arrow_back.svg"),
                    ),
                  ),
                ),
                const Text(
                  "Estate Market",
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      // color: const Color(0XFFF0F7F8),
                      borderRadius: BorderRadius.circular(13)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset("assets/svgs/blank.svg"),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            height: 45,
            decoration: BoxDecoration(
                // color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText:
                            "search for properties, malls, shop, schools...",
                        hintStyle: TextStyle(color: Color(0XFFB1B1B1)),
                        prefixStyle: TextStyle(color: Color(0xFF7C7C7C)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIconColor: Colors.blue,
                      ),
                      onChanged: (value) {
                        houseController.search.value = value.toString();
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          handleFilter();
                        });
                      },
                    ),
                  ),
                  // isSearched
                  //     ? const Icon(Icons.search)
                  //     :
                  GestureDetector(
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
                                    height: MediaQuery.of(context).size.height /
                                        1.4,
                                    decoration: BoxDecoration(
                                        color: context
                                            .theme.scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.only(
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
                                                const Text(
                                                    "Search By Location"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Obx(
                                                  () => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              onChanged:
                                                                  (value) {
                                                                houseController
                                                                        .state
                                                                        .value =
                                                                    value
                                                                        .toString();
                                                                searchListingController
                                                                        .location
                                                                        .value =
                                                                    value
                                                                        .toString();
                                                                loadStateLgaController
                                                                    .handleSearchFetchLga();
                                                                houseController
                                                                    .lga
                                                                    .value = '';
                                                              },
                                                              items: loadStateLgaController
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
                                                                  houseController
                                                                      .state
                                                                      .value,
                                                              onChanged:
                                                                  (value) {
                                                                houseController
                                                                        .state
                                                                        .value =
                                                                    value
                                                                        .toString();
                                                                searchListingController
                                                                        .location
                                                                        .value =
                                                                    value
                                                                        .toString();
                                                                loadStateLgaController
                                                                    .handleSearchFetchLga();
                                                                houseController
                                                                    .lga
                                                                    .value = '';
                                                              },
                                                              items: loadStateLgaController
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
                                                    visible: houseController
                                                                .state.string ==
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
                                                                        width:
                                                                            1),
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
                                                                    Text(houseController
                                                                        .lga
                                                                        .string),
                                                                    const Icon(
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
                                                      handleFilter();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    500, 60),
                                                            backgroundColor:
                                                                mobileButtonColor),
                                                    child: const Text(
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
                      child: SvgPicture.asset(
                        "assets/svgs/list.svg",
                        color: const Color(0XFF0072BA),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => houseController.isFiltering.isTrue
                  ? loadingWidget()
                  : PagedListView<int, HouseListModel>(
                      pagingController:
                          houseController.categoryPagingController,
                      // physics: NeverScrollableScrollPhysics(),
                      builderDelegate:
                          PagedChildBuilderDelegate<HouseListModel>(
                        itemBuilder: (context, post, index) {
                     
                          return SingleProperty(
                            listing: post,
                            comingFrom: 'Homescreen',
                          );
                        },
                        noItemsFoundIndicatorBuilder: (context) =>
                            const Center(child: Text('No property found.')),
                      ),
                    ),
            ),
          ),
        ],
      ),
    ));
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
                borderRadius: BorderRadius.circular(20),
                color: context.theme.scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: context.iconColor!),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: loadStateLgaController.lga.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  houseController.lga.value =
                                      loadStateLgaController.lga[index];
                                });
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
