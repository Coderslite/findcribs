// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:findcribs/models/house_list_model.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../components/constants.dart';
import '../../controller/load_state_lga_controller.dart';
import '../../service/property_by_category.dart';
import '../../widgets/loading_widget.dart';
import '../homepage/single_property.dart';

class ApartmentScreen extends StatefulWidget {
  final String apartmentType;
  const ApartmentScreen({super.key, required this.apartmentType});

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      houseController.isFiltering.value = true;
      houseController.categoryPagingController.itemList!.clear();
      houseController.category.value = widget.apartmentType;
      houseController.fetchPosts(0);
    });
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
    var size = MediaQuery.of(context).size;
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
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return const HomePageRoot(navigateIndex: 0);
                          }));
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
                      SizedBox(
                        width: size.width / 1.5,
                        child: Text(
                          widget.apartmentType,
                          style: const TextStyle(
                              fontFamily: 'RedHatDisplay',
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
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
                                                    houseController.isFiltering
                                                        .value = true;
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
                                          child: Obx(
                                            () => Column(
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
                                                  onChanged: (value) {
                                                    setState(() {
                                                      houseController.bedroom
                                                          .value = value;
                                                      handleFilter();
                                                    });
                                                  },
                                                ),
                                                const Text("Bathoom Size"),
                                                SfSlider(
                                                  min: 0,
                                                  max: 10,
                                                  value: houseController
                                                      .bathroom
                                                      .toInt(),
                                                  stepSize: 1,
                                                  interval: 2,
                                                  showTicks: true,
                                                  showLabels: true,
                                                  enableTooltip: true,
                                                  minorTicksPerInterval: 10,
                                                  onChanged: (dynamic value) {
                                                    setState(() {
                                                      houseController.bathroom
                                                          .value = value;
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
                                                      houseController.kitchen
                                                          .value = value;
                                                      handleFilter();
                                                    });
                                                  },
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
                                                                  //handleGetProperties();
                                                                } else {
                                                                  houseController
                                                                          .minPrice
                                                                          .value =
                                                                      value
                                                                          .toString();
                                                                  //handleGetProperties();
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
                                                                  //handleGetProperties();
                                                                } else {
                                                                  houseController
                                                                          .maxPrice
                                                                          .value =
                                                                      value
                                                                          .toString();
                                                                  //handleGetProperties();
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
                                  houseController.state.toString() == ''
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
                                                  title: Text(
                                                    lga.toString(),
                                                  ),
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
                                  houseController.lga.toString() == ''
                                      ? 'LGA'
                                      : houseController.lga.toString(),
                                  overflow: TextOverflow.ellipsis,
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
                    child: PagedListView<int, HouseListModel>(
                      pagingController:
                          houseController.categoryPagingController,
                      // physics: NeverScrollableScrollPhysics(),
                      primary: true,
                      builderDelegate:
                          PagedChildBuilderDelegate<HouseListModel>(
                        noMoreItemsIndicatorBuilder: (context) {
                          Fluttertoast.showToast(msg: "No more items to load");
                          return Container();
                        },
                        animateTransitions: true,
                        itemBuilder: (context, post, index) {
                          int price = int.parse(post.rentalFee.toString());
                          var formatter = NumberFormat("#,###");
                          var formatedPrice = formatter.format(price);
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
}
