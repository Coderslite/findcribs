// ignore_for_file: avoid_print

import 'package:findcribs/models/house_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../components/constants.dart';
import '../../controller/load_state_lga_controller.dart';
import '../../service/property_by_category.dart';
import '../../widgets/loading_widget.dart';
import '../homepage/single_property.dart';

class DuplexScreen extends StatefulWidget {
  final String duplexType;
  const DuplexScreen({super.key, required this.duplexType});

  @override
  State<DuplexScreen> createState() => _DuplexScreenState();
}

class _DuplexScreenState extends State<DuplexScreen> {
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

  handleInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      houseController.category.value = widget.duplexType;
      houseController.isFiltering.value = true;
      houseController.categoryPagingController.itemList!.clear();
      houseController.fetchPosts(0);
    });
  }

  @override
  void initState() {
    handleInit();
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
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Obx(
      () => houseController.isFiltering.isTrue
          ? loadingWidget()
          : Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return HomePageRoot(navigateIndex: 0);
                          // }));
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
                            child:
                                SvgPicture.asset("assets/svgs/arrow_back.svg"),
                          ),
                        ),
                      ),
                      Text(
                        widget.duplexType,
                        style: const TextStyle(
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                            color: context
                                                .theme.scaffoldBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                        child: ListView.builder(
                                            itemCount: eachPropertyType.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    currentPropertyTypeIndex =
                                                        index;
                                                    houseController.propertyType
                                                            .value =
                                                        eachPropertyType[index];
                                                    print("object");
                                                    handleFilter();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                      eachPropertyType[index]),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  houseController.propertyType.toString(),
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                          color: context
                                              .theme.scaffoldBackgroundColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Bedroom Size"),
                                              SfSlider(
                                                min: 0,
                                                max: 10,
                                                value: houseController.bedroom
                                                    .toInt(),
                                                stepSize: 1,
                                                interval: 2,
                                                showTicks: true,
                                                showLabels: true,
                                                enableTooltip: true,
                                                minorTicksPerInterval: 10,
                                                onChanged: (dynamic value) {
                                                  setState(() {
                                                    houseController
                                                        .bedroom.value = value;
                                                    handleFilter();
                                                  });
                                                },
                                              ),
                                              const Text("Bathoom Size"),
                                              SfSlider(
                                                min: 0,
                                                max: 10,
                                                value: houseController.bathroom
                                                    .toInt(),
                                                stepSize: 1,
                                                interval: 2,
                                                showTicks: true,
                                                showLabels: true,
                                                enableTooltip: true,
                                                minorTicksPerInterval: 10,
                                                onChanged: (dynamic value) {
                                                  setState(() {
                                                    houseController
                                                        .bathroom.value = value;
                                                    handleFilter();
                                                  });
                                                },
                                              ),
                                              const Text("Living Room Size"),
                                              SfSlider(
                                                min: 0,
                                                max: 10,
                                                value: houseController
                                                    .livingRoom
                                                    .toInt(),
                                                stepSize: 1,
                                                interval: 2,
                                                showTicks: true,
                                                showLabels: true,
                                                enableTooltip: true,
                                                minorTicksPerInterval: 10,
                                                onChanged: (dynamic value) {
                                                  setState(() {
                                                    houseController.livingRoom
                                                        .value = value;
                                                    handleFilter();
                                                  });
                                                },
                                              ),
                                              const Text("Kitchen Size"),
                                              SfSlider(
                                                min: 0,
                                                max: 10,
                                                value: houseController.kitchen
                                                    .toInt(),
                                                stepSize: 1,
                                                interval: 2,
                                                showTicks: true,
                                                showLabels: true,
                                                enableTooltip: true,
                                                minorTicksPerInterval: 10,
                                                onChanged: (dynamic value) {
                                                  setState(() {
                                                    houseController
                                                        .kitchen.value = value;
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
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                            color: context
                                                .theme.scaffoldBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                        child: TextFormField(
                                                          initialValue:
                                                              houseController
                                                                  .minPrice
                                                                  .toString(),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (value) {
                                                            setState(
                                                              () {
                                                                if (value
                                                                    .isEmpty) {
                                                                  houseController
                                                                      .minPrice
                                                                      .value = '0';
                                                                  // handleFilter();
                                                                } else {
                                                                  houseController
                                                                          .minPrice
                                                                          .value =
                                                                      value
                                                                          .toString();
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
                                                        child: TextFormField(
                                                          initialValue:
                                                              houseController
                                                                  .maxPrice
                                                                  .toString(),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (value) {
                                                            setState(
                                                              () {
                                                                if (value
                                                                    .isEmpty) {
                                                                  houseController
                                                                      .maxPrice
                                                                      .value = '0';
                                                                  // handleFilter();
                                                                } else {
                                                                  houseController
                                                                          .maxPrice
                                                                          .value =
                                                                      value
                                                                          .toString();
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
                                                    width: mobileWidth * 0.69,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        handleFilter();

                                                        Navigator.pop(context);
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
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.8,
                                        decoration: BoxDecoration(
                                            color: context
                                                .theme.scaffoldBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                        child: ListView.builder(
                                            itemCount: loadStateLgaController
                                                .data.length,
                                            itemBuilder: (context, index) {
                                              var eachState =
                                                  loadStateLgaController
                                                      .data[index]['state'];
                                              return GestureDetector(
                                                onTap: () {
                                                  searchListingController
                                                      .location
                                                      .value = eachState;
                                                  loadStateLgaController
                                                      .handleSearchFetchLga();
                                                  setState(() {
                                                    currentStateIndex = index;
                                                    houseController.state
                                                        .value = eachState;
                                                    houseController.lga.value =
                                                        "";
                                                  });
                                                  handleFilter();
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                      eachState.toString()),
                                                  trailing: currentStateIndex ==
                                                          index
                                                      ? const Icon(Icons.check)
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  houseController.state.value == ''
                                      ? 'State'
                                      : houseController.state.toString(),
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.8,
                                        decoration: BoxDecoration(
                                            color: context
                                                .theme.scaffoldBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                        child: ListView.builder(
                                            itemCount: loadStateLgaController
                                                .lga.length,
                                            itemBuilder: (context, index) {
                                              var lga = loadStateLgaController
                                                  .lga[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // currentStateIndex =
                                                    //     index;
                                                    houseController.lga.value =
                                                        lga;
                                                  });
                                                  handleFilter();
                                                  Navigator.pop(context);
                                                },
                                                child: ListTile(
                                                  title: Text(lga.toString()),
                                                  trailing: houseController
                                                              .lga.string ==
                                                          lga.toString()
                                                      ? const Icon(Icons.check)
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  houseController.lga.value == ''
                                      ? 'LGA'
                                      : houseController.lga.toString(),
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
                  Expanded(
                    child: PagedListView<int, HouseListModel>(
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
                  )
                ],
              ),
            ),
    ));
  }

  // handleGetStarted() async {
  //   setState(() {
  //     isChecking = true;
  //   });
  //   final prefs = await SharedPreferences.getInstance();

  //   var token = prefs.getString('token');
  //   var response = await http.get(Uri.parse("$baseUrl/profile"), headers: {
  //     "Authorization": "$token",
  //   });
  //   var jsonResponse = jsonDecode(response.body);
  //   if (jsonResponse['status'] == true) {
  //     setState(() {
  //       isChecking = false;
  //     });
  //     var responseData = jsonResponse['data']['profile'];
  //     if (responseData['agent'] != null) {
  //       Navigator.push(context, MaterialPageRoute(builder: (_) {
  //         return ListPropertyScreen1(
  //           tab: 0,
  //         );
  //       }));
  //     } else {
  //       Navigator.push(context, MaterialPageRoute(builder: (_) {
  //         return const GetStarted();
  //       }));
  //     }
  //   } else {
  //     setState(() {
  //       isChecking = false;
  //     });
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception(response.statusCode);
  //   }
  // }

  List eachPropertyType = [
    "All",
    "Rent",
    "Sale",
  ];

  List eachDuplexType = [
    "Detached Duplex",
    "Semi Duplex",
    "Duplex Bungalow",
  ];

  // List eachState = [
  //   "Nigeria",
  //   "Abia",
  //   "Adamawa",
  //   "Akwa-ibom",
  //   "Anambra",
  //   "Bauchi",
  //   "Bayelsa",
  //   "Benue",
  //   "Borno",
  //   "Cross River",
  //   "Delta",
  //   "Ebonyi",
  //   "Edo",
  //   "Ekiti",
  //   "Enugu",
  //   "Gombe",
  //   "Imo",
  //   "Jigawa",
  //   "Kaduna",
  //   "Kano",
  //   "Kastina",
  //   "Kebbi",
  //   "Kogi",
  //   "Kwara",
  //   "Lagos",
  //   "Nassarawa",
  //   "Niger",
  //   "Ogun",
  //   "Ondo",
  //   "Osun",
  //   "Oyo",
  //   "Plateau",
  //   "Rivers",
  //   "Sokoto",
  //   "Taraba",
  //   "Yobe",
  //   "Zamfara",
  //   "Abuja"
  // ];
}
