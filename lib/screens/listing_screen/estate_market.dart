import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../components/constants.dart';
import '../../models/house_list_model.dart';
import '../../service/property_list_categoty_service.dart';
import '../../service/search_property.dart';
import '../homepage/single_property.dart';
import '../product_details/product_details.dart';

class EstateMarketScreen extends StatefulWidget {
  const EstateMarketScreen({Key? key}) : super(key: key);

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
  bool isLoading = true;
  bool isSearching = false;
  bool visible = true;
  String state = 'Nigeria';
  String area = '';
  String searchValue = '';
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  bool isChecking = false;
  bool isToolTip = false;
  int page = 1;
  bool _hasNextPage = true;
  late ScrollController _controller;
  String currency = 'Naira';

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool isSearched = false;

  @override
  void initState() {
    super.initState();
    handleGetProperties();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _controller.addListener(_searchedScrollListener);
  }

  handleGetProperties() {
    propertyList = getPropertyListCategory('Estate Market', page);
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
      propertyList = getPropertyListCategory('Estate Market', page);
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
        isLoading == false &&
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

  handleSearchProperty(bool isBottomSheet) {
    // Navigator.pop(context);
    setState(() {
      isSearching = true;
      visible = false;
    });

    propertyList = getSearchedProperty(state != 'Nigeria' ? state : '',
        area != '' ? area : '', searchValue != '' ? searchValue : '', page);
    propertyList.then((value) {
      setState(() {
        filteredList = [];
        for (int s = 0; s < value.length; s++) {
          filteredList.add(value[s]);
        }
        isSearching = false;
        isBottomSheet ? Navigator.pop(context) : () {};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                    color: const Color(0XFFF0F7F8),
                    borderRadius: BorderRadius.circular(13)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svgs/blank.svg"),
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
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
                                    height:
                                        MediaQuery.of(context).size.height / 2,
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
                                                const Text(
                                                    "Search By Location"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: const [
                                                    Text("State"),
                                                  ],
                                                ),
                                                FormBuilderDropdown(
                                                  name: 'location',
                                                  initialValue: state,
                                                  isExpanded: true,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      state = value.toString();
                                                    });
                                                  },
                                                  items: [
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
                                                  ].map((option) {
                                                    return DropdownMenuItem(
                                                      value: option,
                                                      child: Text(option),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: const [
                                                    Text("Area"),
                                                  ],
                                                ),
                                                TextFormField(
                                                  initialValue: area,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      area = value.toString();
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Enter Your area e.g Ikoyi",
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFF9F9F9),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            BorderSide.none),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 14,
                                                            horizontal: 15.67),
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
                                                      handleSearchProperty(
                                                          true);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            fixedSize:
                                                                const Size(
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
                      child: SvgPicture.asset(
                        "assets/svgs/list.svg",
                        color: const Color(0XFF0072BA),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: isLoading || isSearching
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/opps.png"),
                            const Text(
                              "Opps!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
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
                          int price = (filteredList[x].rentalFee!.toInt());
                          var formatter = NumberFormat("#,###");
                          var formatedPrice = formatter.format(price);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return ProductDetails(
                                      id: filteredList[x].id,
                                    );
                                  }));
                                },
                                child: SingleProperty(
                                  id: filteredList[x].id,
                                  image: filteredList[x].image,
                                  designType: filteredList[x].designType,
                                  currency: filteredList[x].currency,
                                  propertyType: filteredList[x].propertyType,
                                  propertyAddress:
                                      filteredList[x].propertyAddress,
                                  bedroom: filteredList[x].bedroom,
                                  propertyCategory:
                                      filteredList[x].propertyCategory,
                                  price: formatedPrice,
                                  isPromoted: filteredList[x].isPromoted,
                                  propertyName:
                                      filteredList[x].propertyName.toString(),
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
    ));
  }
}
