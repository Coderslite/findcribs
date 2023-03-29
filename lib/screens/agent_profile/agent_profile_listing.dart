import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../models/house_list_model.dart';
import '../../service/get_agent_listings.dart';

class SalesScreen extends StatefulWidget {
  final int id;
  final String image;
  final String businessName;
  final String? isVerified;
  const SalesScreen(
      {Key? key,
      required this.id,
      required this.image,
      required this.businessName,
      required this.isVerified})
      : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late Future<List<HouseListModel>> propertyList;
  List<HouseListModel> filteredRentList = [];
  List<HouseListModel> filteredSaleList = [];
  List<HouseListModel> firstList = [];
  bool isLoading = true;

  handleGetAgentProperties() {
    setState(() {
      isLoading = true;
    });
    propertyList = getAgentListings(widget.id);
    propertyList.then((value) {
      setState(() {
        firstList = value;
        handleFilter();
      });
    });
  }

  handleFilter() {
    setState(() {
      isLoading = false;
      filteredRentList = firstList.where((element) {
        return element.propertyType!.toLowerCase().contains('rent');
      }).toList();
      filteredSaleList = firstList.where((element) {
        return element.propertyType!.toLowerCase().contains('sale');
      }).toList();
    });
  }

  @override
  void initState() {
    handleGetAgentProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: isLoading
            ? Center(
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
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF0F7F8),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.businessName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                // Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       SvgPicture.asset(
                                //           "assets/svgs/star_spur.svg"),
                                //       const SizedBox(
                                //         width: 5,
                                //       ),
                                //       const Text(
                                //         "4.4  Ratings",
                                //         style: TextStyle(
                                //             color: Colors.grey, fontSize: 10),
                                //       )
                                //     ])
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(widget.image),
                                ),
                              ),
                              Positioned(
                                  left: 35,
                                  right: 10,
                                  top: 0,
                                  child: widget.isVerified == 'verified'
                                      ? Image.asset("assets/images/tick.png")
                                      : Container())
                            ],
                          )
                        ],
                      ),
                      const TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 2.0, color: Colors.grey),
                            insets: EdgeInsets.symmetric(
                              horizontal: 5.0,
                            )),
                        indicatorPadding: EdgeInsets.only(bottom: 3),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.grey,
                        labelPadding: EdgeInsets.only(right: 90),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Rent',
                          ),
                          Tab(
                            text: 'Sales',
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          filteredRentList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 3,
                                          mainAxisSpacing: 3),
                                  itemCount: filteredRentList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ProductDetails(
                                            id: filteredRentList[index].id,
                                          );
                                        }));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: filteredRentList[index]
                                                .image!
                                                .isEmpty
                                            ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                                            : filteredRentList[index].image![0]
                                                ['url'],
                                        fit: BoxFit.cover,
                                        width: 1000,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                JumpingDotsProgressIndicator(
                                          fontSize: 20.0,
                                          color: Colors.blue,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );
                                  }),
                          filteredSaleList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 3,
                                          mainAxisSpacing: 3),
                                  itemCount: filteredSaleList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ProductDetails(
                                            id: filteredSaleList[index].id,
                                          );
                                        }));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: filteredSaleList[index]
                                                .image!
                                                .isEmpty
                                            ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                                            : filteredSaleList[index].image![0]
                                                ['url'],
                                        fit: BoxFit.cover,
                                        width: 1000,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                JumpingDotsProgressIndicator(
                                          fontSize: 20.0,
                                          color: Colors.blue,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );
                                  }),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
