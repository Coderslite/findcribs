import 'package:findcribs/screens/listing_process/listing/components/rent/rent4_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../estate_market.dart';
import '../sale/sale1.dart';

// ignore: must_be_immutable
class Rent4 extends StatefulWidget {
  final String? propertyCategory;
  final String? houseType;
  final String? propertyAddress;
  final String? bedroom;
  final String? bathrooom;
  final String? livingroom;
  final String? kitchen;
  final String? currency;
  final String? rent;
  final String? rentalFee;
  final String? charge;
  final String? negotiable;
  final String? location;
  final String? area;
  final String? covered;
  final String? water;
  final String? interiorDesign;
  final String? space;
  final String? electricity;
  final String? cautionFee;
  final String? serviceCharge;
  final String? legalFee;
  final String? agencyFee;
  // final String? facilities;

  const Rent4({
    Key? key,
    this.propertyCategory,
    this.houseType,
    this.propertyAddress,
    this.bedroom,
    this.bathrooom,
    this.livingroom,
    this.kitchen,
    this.currency,
    this.rent,
    this.rentalFee,
    this.charge,
    this.negotiable,
    this.location,
    this.area,
    this.covered,
    this.interiorDesign,
    this.space,
    this.water,
    this.electricity,
    this.cautionFee,
    this.serviceCharge,
    this.legalFee,
    this.agencyFee,
  }) : super(key: key);

  @override
  State<Rent4> createState() => _Rent4State();
}

class _Rent4State extends State<Rent4> with SingleTickerProviderStateMixin {
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
                      Rent4Stepper(
                        propertyAddress: widget.propertyAddress,
                        houseType: widget.houseType,
                        propertyCategory: widget.propertyCategory,
                        bedroom: widget.bedroom,
                        bathrooom: widget.bathrooom,
                        livingroom: widget.livingroom,
                        kitchen: widget.kitchen,
                        charge: widget.charge,
                        currency: widget.currency,
                        rent: widget.rent,
                        rentalFee: widget.rentalFee,
                        negotiable: widget.negotiable,
                        location: widget.location,
                        area: widget.area,
                        covered: widget.covered,
                        interiorDesign: widget.interiorDesign,
                        water: widget.water,
                        space: widget.space,
                        electricity: widget.electricity,
                        cautionFee: widget.cautionFee,
                        legalFee: widget.legalFee,
                        serviceCharge: widget.serviceCharge,
                        agencyFee: widget.agencyFee,
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
