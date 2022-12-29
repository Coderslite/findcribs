import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:findcribs/screens/listing_process/listing/components/estate_market.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent1.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ListPropertyScreen1 extends StatefulWidget {
  int tab;
  ListPropertyScreen1({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<ListPropertyScreen1> createState() => _ListPropertyScreen1State();
}

class _ListPropertyScreen1State extends State<ListPropertyScreen1>
    with SingleTickerProviderStateMixin {
  bool cautionFeeActive = false;
  bool hide = true;

  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.tab)
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return HomePageRoot(navigateIndex: 0);
          }));
          return true;
        },
        child: SafeArea(
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
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomePageRoot(navigateIndex: 0);
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
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 1,
                    key: UniqueKey(),
                    child: TabBar(
                        key: UniqueKey(),
                        controller: _tabController,
                        // isScrollable: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        isScrollable: false,
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
              ),
              Expanded(
                // key: UniqueKey(),
                child: TabBarView(
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: const [Rent1(), Sale1(), EstateMarket()]),
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
