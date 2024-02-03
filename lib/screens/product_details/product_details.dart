import 'dart:async';

import 'package:findcribs/controller/get_single_property_listing.dart';
import 'package:findcribs/screens/product_details/product_main_details.dart';
import 'package:findcribs/screens/product_details/product_more_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controller/panel_controller.dart';

class ProductDetails extends StatefulWidget {
  final bool? isDeepLinking;
  final int? id;
  const ProductDetails({
    Key? key,
    required this.id,
    this.isDeepLinking,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  MyPanelController pageController = Get.put(MyPanelController());
  final _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  Timer? _timer;
  bool end = false;
  GetSinglePropertyController getSinglePropertyController =
      Get.put(GetSinglePropertyController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSinglePropertyController.handlePropertyClicked(widget.id!);
      _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
        if (_controller.hasClients) {
          if (_currentPage == 3) {
            end = true;
          } else if (_currentPage == 0) {
            end = false;
          }

          if (end == false) {
            _currentPage++;
          } else {
            _currentPage--;
          }
          _controller.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (pageController.panelOpened == false) {
            return true;
          } else {
            setState(() {
              pageController.panelOpened = false;
              pageController.panelController.close();
            });
            return false;
          }
        },
        child: SlidingUpPanel(
          controller: pageController.panelController,
          onPanelOpened: () {
            setState(() {
              pageController.panelOpened = true;
            });
          },
          onPanelClosed: () {
            setState(() {
              pageController.panelOpened = false;
            });
          },
          parallaxEnabled: false,
          minHeight: 70,
          maxHeight: MediaQuery.of(context).size.height / 1.12,
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 8.0,
          //     color: Color.fromARGB(14, 0, 0, 0),
          //   ),
          // ],
          collapsed: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SvgPicture.asset("assets/svgs/arrow_up.svg"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "View More",
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0XFF8A99B1),
                  ),
                )
              ],
            ),
          ),
          //// product more details start ////
          panel: ProductMoreDetails(id: widget.id),
          //// product more details ends ////

          /// product main details start ///
          body: ProductMainDetails(
            panelOpened: pageController.panelOpened,
            id: widget.id,
            isDeepLinking:
                widget.isDeepLinking.toString() == 'true' ? true : false,
          ),
          //// product main details ends ////
        ),
      ),
    );
  }
}
