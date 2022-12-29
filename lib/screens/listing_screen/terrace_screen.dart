// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/service/filter_property_category.dart';
import 'package:findcribs/service/property_list_categoty_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../components/constants.dart';
import '../../controller/filter_terrace_controller.dart';
import 'package:http/http.dart' as http;

import '../homepage/single_property.dart';
import '../listing_process/get_started.dart';
import '../listing_process/listing/listing.dart';
import '../product_details/product_details.dart';

class TerraceScreen extends StatefulWidget {
  const TerraceScreen({Key? key}) : super(key: key);

  @override
  State<TerraceScreen> createState() => _TerraceScreenState();
}

class _TerraceScreenState extends State<TerraceScreen> {
  late Future<List<HouseListModel>> propertyList;
  List<HouseListModel> filteredList = [];
  List<HouseListModel> firstList = [];
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  bool isLoading = true;
  bool isChecking = false;
  final tooltipController = JustTheController();
  bool isToolTip = false;
  int page = 1;
  bool _hasNextPage = true;
  late ScrollController _controller;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  handleGetProperties() {
    propertyList = getPropertyListCategory('terrace', page);
    propertyList.then((value) {
      filteredList = [];

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

  void _loadMore() async {
    if (_hasNextPage == true &&
        isLoading == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 600) {
      setState(() {
        // Display a progress indicator at the bottom
        _isLoadMoreRunning = true;
        page += 1;
      });
      propertyList = getPropertyListCategory('terrace', page);
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
    } else {
      print("Nothing is loading");
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        _loadMore();
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
      });
    }
  }

  double _bedroomSize = 0.0;
  double _bathroomSize = 0.0;
  double _livingroomSize = 0.0;
  double _kitchenSize = 0.0;
  int currentStateIndex = 0;
  int currentPropertyTypeIndex = 0;

  FilterTerraceController filterTerraceController =
      Get.put(FilterTerraceController());

  int minPrice = 0;
  int maxPrice = 0;

  handleFilter() {
    print("filter");
    setState(() {
      isLoading = true;

      propertyList = filterPropertyCategory(
          filterTerraceController.propertyType.string == 'All'
              ? ''
              : filterTerraceController.propertyType.string,
          minPrice == 0 ? "" : minPrice.toString(),
          maxPrice == 0 ? "" : maxPrice.toString(),
          "terrace",
          _livingroomSize.toInt() == 0 ? "" : _livingroomSize.toString(),
          _bathroomSize.toInt() == 0 ? "" : _bathroomSize.toString(),
          _bedroomSize.toInt() == 0 ? "" : _bedroomSize.toString(),
          _kitchenSize.toInt() == 0 ? "" : _kitchenSize.toString(),
          filterTerraceController.state.toString() == 'Nigeria'
              ? ''
              : filterTerraceController.state.toString(),
          page);
      propertyList.then((value) {
        filteredList = [];

        // print(value);
        if (value.isEmpty) {
          print("empty");
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
    });
  }

  handleGetMoreSearchedProperties() {
    propertyList = filterPropertyCategory(
        filterTerraceController.propertyType.string == 'All'
            ? ""
            : filterTerraceController.propertyType.string,
        minPrice == 0 ? "" : minPrice.toString(),
        maxPrice == 0 ? "" : maxPrice.toString(),
        "terrace",
        _livingroomSize.toInt() == 0 ? "" : _livingroomSize.toString(),
        _bathroomSize.toInt() == 0 ? "" : _bathroomSize.toString(),
        _bedroomSize.toInt() == 0 ? "" : _bedroomSize.toString(),
        _kitchenSize.toInt() == 0 ? "" : _kitchenSize.toString(),
        filterTerraceController.state.toString() == 'Nigeria'
            ? ''
            : filterTerraceController.state.toString(),
        page);
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
        isLoading == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 600) {
      setState(() {
        // Display a progress indicator at the bottom
        _isLoadMoreRunning = true;
        page += 1;
      });
      propertyList = filterPropertyCategory(
          filterTerraceController.propertyType.string == 'All'
              ? ""
              : filterTerraceController.propertyType.string,
          minPrice == 0 ? "" : minPrice.toString(),
          maxPrice == 0 ? "" : maxPrice.toString(),
          "terrace",
          _livingroomSize.toInt() == 0 ? "" : _livingroomSize.toString(),
          _bathroomSize.toInt() == 0 ? "" : _bathroomSize.toString(),
          _bedroomSize.toInt() == 0 ? "" : _bedroomSize.toString(),
          _kitchenSize.toInt() == 0 ? "" : _kitchenSize.toString(),
          filterTerraceController.state.toString() == 'Nigeria'
              ? ''
              : filterTerraceController.state.toString(),
          page);
      propertyList.then((value) {
        // print(value);
        if (value.isEmpty) {
          setState(() {
            isLoading = false;
            _hasNextPage = false;
            _isLoadMoreRunning = true;
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

  @override
  void initState() {
    super.initState();
    handleGetProperties();
    _controller = ScrollController();
    _controller.addListener(filterTerraceController.propertyType.string == "All"
        ? _scrollListener
        : _searchedScrollListener);
  }

  @override
  void dispose() {
    filterTerraceController.handleResetInfo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: isChecking
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CollectionSlideTransition(
                      children: const <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 12,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 12,
                        ),
                      ],
                    ),
                    FadingText('Loading...'),
                  ],
                ),
              )
            : Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Row(
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
                                child: SvgPicture.asset(
                                    "assets/svgs/arrow_back.svg"),
                              ),
                            ),
                          ),
                          const Text(
                            "Terrace",
                            style: TextStyle(
                                fontFamily: 'RedHatDisplay',
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                            // child: SvgPicture.asset("assets/svgs/list.svg"),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: ListView.builder(
                                                itemCount:
                                                    eachPropertyType.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        currentPropertyTypeIndex =
                                                            index;
                                                        filterTerraceController
                                                                .propertyType
                                                                .value =
                                                            eachPropertyType[
                                                                index];
                                                        print("object");
                                                        handleFilter();
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                          eachPropertyType[
                                                              index]),
                                                      trailing:
                                                          currentPropertyTypeIndex ==
                                                                  index
                                                              ? const Icon(
                                                                  Icons.check)
                                                              : const Text(""),
                                                    ),
                                                  );
                                                }));
                                      }));
                                    });
                              },
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      filterTerraceController.propertyType
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10),
                                    ),
                                    const Icon(
                                      CupertinoIcons.arrow_up_down,
                                      size: 11,
                                      // color: Color(0XFFE5E5E5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Bedroom Size"),
                                                  SfSlider(
                                                    min: 0,
                                                    max: 10,
                                                    value: _bedroomSize,
                                                    stepSize: 1,
                                                    interval: 2,
                                                    showTicks: true,
                                                    showLabels: true,
                                                    enableTooltip: true,
                                                    minorTicksPerInterval: 10,
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        _bedroomSize = value;
                                                        handleFilter();
                                                      });
                                                    },
                                                  ),
                                                  const Text("Bathoom Size"),
                                                  SfSlider(
                                                    min: 0,
                                                    max: 10,
                                                    value: _bathroomSize,
                                                    stepSize: 1,
                                                    interval: 2,
                                                    showTicks: true,
                                                    showLabels: true,
                                                    enableTooltip: true,
                                                    minorTicksPerInterval: 10,
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        _bathroomSize = value;
                                                        handleFilter();
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      "Living Room Size"),
                                                  SfSlider(
                                                    min: 0,
                                                    max: 10,
                                                    value: _livingroomSize,
                                                    stepSize: 1,
                                                    interval: 2,
                                                    showTicks: true,
                                                    showLabels: true,
                                                    enableTooltip: true,
                                                    minorTicksPerInterval: 10,
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        _livingroomSize = value;
                                                        handleFilter();
                                                      });
                                                    },
                                                  ),
                                                  const Text("Kitchen Size"),
                                                  SfSlider(
                                                    min: 0,
                                                    max: 10,
                                                    value: _kitchenSize,
                                                    stepSize: 1,
                                                    interval: 2,
                                                    showTicks: true,
                                                    showLabels: true,
                                                    enableTooltip: true,
                                                    minorTicksPerInterval: 10,
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        _kitchenSize = value;
                                                        handleFilter();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }));
                                    });
                              },
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "Size",
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10),
                                    ),
                                    Icon(
                                      CupertinoIcons.arrow_up_down,
                                      size: 11,
                                      // color: Color(0XFFE5E5E5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
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
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Price"),
                                                    // SfRangeSlider(
                                                    //   min: 5000.0,
                                                    //   max: 5000000000.0,
                                                    //   values: _price,
                                                    //   interval: 2500000000,
                                                    //   showTicks: true,
                                                    //   showLabels: true,
                                                    //   enableTooltip: true,
                                                    //   stepSize: 1000,
                                                    //   onChanged:
                                                    //       (SfRangeValues values) {
                                                    //     setState(() {
                                                    //       _price = values;
                                                    //     });
                                                    //   },
                                                    // ),

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  minPrice
                                                                      .toString(),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                setState(
                                                                  () {
                                                                    if (value
                                                                        .isEmpty) {
                                                                      minPrice =
                                                                          0;
                                                                      // handleFilter();
                                                                    } else {
                                                                      minPrice =
                                                                          int.parse(
                                                                              value.toString());
                                                                      // handleFilter();
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "Min. Amount"),
                                                            )),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  maxPrice
                                                                      .toString(),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                setState(
                                                                  () {
                                                                    if (value
                                                                        .isEmpty) {
                                                                      maxPrice =
                                                                          0;
                                                                      // handleFilter();
                                                                    } else {
                                                                      maxPrice =
                                                                          int.parse(
                                                                              value.toString());
                                                                      // handleFilter();
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "Max. Amount"),
                                                            )),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Center(
                                                      child: SizedBox(
                                                        width:
                                                            mobileWidth * 0.69,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            handleFilter();

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  fixedSize:
                                                                      const Size(
                                                                          500,
                                                                          60),
                                                                  primary:
                                                                      mobileButtonColor),
                                                          child: const Text(
                                                            //  Connect EndPoint

                                                            'Done',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'RedHatDisplay',
                                                                color:
                                                                    mobileButtonTextColor,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }));
                                    });
                              },
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10),
                                    ),
                                    Icon(
                                      CupertinoIcons.arrow_up_down,
                                      size: 11,
                                      // color: Color(0XFFE5E5E5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.8,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: ListView.builder(
                                                itemCount: eachState.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        currentStateIndex =
                                                            index;
                                                        filterTerraceController
                                                                .state.value =
                                                            eachState[index];
                                                      });
                                                      handleFilter();
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                          eachState[index]),
                                                      trailing:
                                                          currentStateIndex ==
                                                                  index
                                                              ? const Icon(
                                                                  Icons.check)
                                                              : const Text(""),
                                                    ),
                                                  );
                                                }));
                                      }));
                                    });
                              },
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      filterTerraceController.state.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10),
                                    ),
                                    const Icon(
                                      CupertinoIcons.arrow_up_down,
                                      size: 11,
                                      // color: Color(0XFFE5E5E5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: isLoading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CollectionSlideTransition(
                                      children: const <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 12,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 12,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.yellow,
                                          radius: 12,
                                        ),
                                      ],
                                    ),
                                    FadingText('Loading...'),
                                  ],
                                ),
                              )
                            : firstList.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/opps.png"),
                                        const Text(
                                          "Opps!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text("No Item Available"),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    controller: _controller,
                                    shrinkWrap: true,
                                    itemCount: filteredList.length,
                                    itemBuilder: (context, x) {
                                      int price =
                                          (filteredList[x].rentalFee!.toInt());
                                      var formatter = NumberFormat("#,###");
                                      var formatedPrice =
                                          formatter.format(price);
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return ProductDetails(
                                                  id: filteredList[x].id,
                                                );
                                              }));
                                            },
                                            child: SingleProperty(
                                              id: filteredList[x].id,
                                              image: filteredList[x].image,
                                              designType:
                                                  filteredList[x].designType,
                                              currency:
                                                  filteredList[x].currency,
                                              propertyType:
                                                  filteredList[x].propertyType,
                                              propertyAddress: filteredList[x]
                                                  .propertyAddress,
                                              bedroom: filteredList[x].bedroom,
                                              propertyCategory: filteredList[x]
                                                  .propertyCategory,
                                              price: formatedPrice,
                                              isPromoted:
                                                  filteredList[x].isPromoted,
                                              propertyName: filteredList[x]
                                                  .propertyName
                                                  .toString(),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      );
                                    }),
                      ),
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
                    ],
                  ),
                ),
              ));
  }

  List eachPropertyType = [
    "All",
    "Rent",
    "Sale",
  ];

  List eachState = [
    "Nigeria",
    "Abia",
    "Adamawa",
    "Akwa-ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Kastina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nassarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
    "Abuja"
  ];

  handleGetStarted() async {
    setState(() {
      isChecking = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    var response = await http.get(Uri.parse("$baseUrl/profile"), headers: {
      "Authorization": "$token",
    });
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      setState(() {
        isChecking = false;
      });
      var responseData = jsonResponse['data']['profile'];
      if (responseData['agent'] != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ListPropertyScreen1(
            tab: 0,
          );
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const GetStarted();
        }));
      }
    } else {
      setState(() {
        isChecking = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }
}
