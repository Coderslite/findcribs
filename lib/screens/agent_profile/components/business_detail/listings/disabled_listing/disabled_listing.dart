import 'package:findcribs/screens/agent_profile/components/business_detail/listings/disabled_listing/category/disabled_listing_for_estate_market.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/disabled_listing/category/disabled_listing_for_rent.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/disabled_listing/category/disabled_listing_for_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../listings.dart';

class DisabledListing extends StatefulWidget {
  const DisabledListing({Key? key}) : super(key: key);

  @override
  State<DisabledListing> createState() => _DisabledListingState();
}

class _DisabledListingState extends State<DisabledListing>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return WillPopScope(
            onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const UserListing();
        }));
        return true;
      },
      child: Scaffold(
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
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return const UserListing();
                          }));
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
                        "Disabled Listings",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(""),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
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
                          borderRadius: BorderRadius.circular(30)),
                      indicatorWeight: 0.4,
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Text(
                              "For Rent",
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // constraints: BoxConstraints.expand(
                            //     width: MediaQuery.of(context).size.width / 4),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // bottomLeft: Radius.circular(10),
                                  ),
                            ),
                            child: Text(
                              "For Sale",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            // constraints: BoxConstraints.expand(
                            //     width: MediaQuery.of(context).size.width / 4),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Estate Market",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 33,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  // key: UniqueKey(),
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        DisabledListingForRent(),
                        DisabledListingForSale(),
                        DisabledListingForEstateMarket()
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
