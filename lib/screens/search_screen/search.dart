// ignore_for_file: avoid_print
import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/screens/homepage/single_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../../components/constants.dart';
import '../../controller/load_state_lga_controller.dart';
import '../../service/property_by_category.dart';
import '../../widgets/loading_widget.dart';

// ignore: camel_case_types
class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

// ignore: camel_case_types
class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController textController = TextEditingController();
  LoadStateLgaController loadStateLgaController =
      Get.put(LoadStateLgaController());
  HouseByCategoryController houseController =
      Get.put(HouseByCategoryController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  int currentPropertyTypeIndex = 0;
  int currentStateIndex = 100;

  handleFilter() {
    houseController.isFiltering.value = true;
    houseController.categoryPagingController.itemList!.clear();
    houseController.fetchPosts(0);
  }

  @override
  void initState() {
    houseController.isFiltering.value = true;
    houseController.fetchPosts(0);
    super.initState();
  }

  @override
  void dispose() {
    houseController.categoryPagingController.itemList!.clear();
    houseController.handleReset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Obx(
      () => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                        // color: const Color(0xFFF0F7F8),
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
                // fillColor: const Color(0xFFF9F9F9),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15.67),
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
                          return StatefulBuilder(builder: ((context, setState) {
                            return AnimatedPadding(
                              padding: MediaQuery.of(context).viewInsets,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.decelerate,
                              child: Container(
                                // height: MediaQuery.of(context).size.height / 1.4,
                                decoration: BoxDecoration(
                                    color:
                                        context.theme.scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
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
                                                              .location.value ==
                                                          ''
                                                      ? FormBuilderDropdown(
                                                          name: 'location',
                                                          isExpanded: true,
                                                          onChanged: (value) {
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
                                                                .lga.value = '';
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
                                                              houseController
                                                                  .state.value,
                                                          onChanged: (value) {
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
                                                                .lga.value = '';
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
                                                            border: Border.all(
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(18.0),
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
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    fixedSize:
                                                        const Size(500, 60),
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
                  child: const Icon(
                    Icons.my_location_rounded,
                    color: Color(0xFF0072BA),
                  ),
                ),
                hintText: "Search Property by type or name"),
            onFieldSubmitted: (value) {
              handleFilter();
            },
            onChanged: (value) {
              setState(() {
                houseController.search.value = value.toString();
              });
            },
            scrollPadding: const EdgeInsets.all(0),
          ),
        ),
        Expanded(
          child: houseController.isFiltering.isTrue
              ? loadingWidget()
              : PagedListView<int, HouseListModel>(
                  pagingController: houseController.categoryPagingController,
                  // physics: NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<HouseListModel>(
                    itemBuilder: (context, post, index) {
                      int price = (post.rentalFee!.toInt());
                      var formatter = NumberFormat("#,###");
                      var formatedPrice = formatter.format(price);
                      return SingleProperty(
                        id: post.id,
                        image: post.image,
                        designType: post.designType,
                        currency: post.currency,
                        propertyType: post.propertyType,
                        propertyAddress: post.propertyAddress,
                        bedroom: post.bedroom,
                        propertyCategory: post.propertyCategory,
                        price: formatedPrice,
                        propertyName: post.propertyName.toString(),
                        comingFrom: 'Homescreen',
                        state: post.state!,
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) =>
                        const Center(child: Text('No property found.')),
                  ),
                ),
        )
      ]),
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
                  color: context.theme.scaffoldBackgroundColor),
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
