import 'package:findcribs/screens/listing_process/listing/components/estate_market.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent2_stepper.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Rent2 extends StatefulWidget {
  final String? propertyCategory;
  final String? houseType;
  final String? propertyAddress;
  final String? bedroom;
  final String? bathrooom;
  final String? livingroom;
  final String? kitchen;
  const Rent2({
    Key? key,
    this.propertyCategory,
    this.houseType,
    this.propertyAddress,
    this.bedroom,
    this.bathrooom,
    this.livingroom,
    this.kitchen,
  }) : super(key: key);

  @override
  State<Rent2> createState() => _Rent2State();
}

class _Rent2State extends State<Rent2> with SingleTickerProviderStateMixin {
  bool cautionFeeActive = false;
  bool hide = true;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 1,
          key: UniqueKey(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: const Color(0XFFF0F7F8),
                        ),
                        child: SvgPicture.asset(
                          "assets/svgs/arrow_back.svg",
                        ),
                      ),
                    ),
                    const Text(
                      "List Property",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(""),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  constraints: const BoxConstraints.expand(height: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: TabBar(
                      key: UniqueKey(),
                      controller: _tabController,
                      // physics: const NeverScrollableScrollPhysics(),
                      // isScrollable: false,
                      unselectedLabelColor: Colors.black,
                      // indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          color: const Color(0xFF0072BA),
                          borderRadius: BorderRadius.circular(5)),
                      indicatorWeight: 1,
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints.expand(
                                width: MediaQuery.of(context).size.width / 4),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Text(
                              "For Rent",
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints.expand(
                                width: MediaQuery.of(context).size.width / 4),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // bottomLeft: Radius.circular(10),
                                  ),
                            ),
                            child: Text(
                              "For Sale",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints.expand(
                                width: MediaQuery.of(context).size.width / 4),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Estate Market",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(
                // key: UniqueKey(),
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Rent2Stepper(
                        propertyAddress: widget.propertyAddress,
                        houseType: widget.houseType,
                        propertyCategory: widget.propertyCategory,
                        bedroom: widget.bedroom,
                        bathrooom: widget.bathrooom,
                        livingroom: widget.livingroom,
                        kitchen: widget.kitchen,
                      ),
                      const Sale1(),
                      const EstateMarket(),
                    ]),
              )
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //     // bottom:
      //     ),
    );
  }

// || Tab one for Rent ||

// || Tab two for sales ||

}
