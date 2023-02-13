import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/listing_process/listing/edit_listing/estate_market_edit/estate_market_edit.dart';
import 'package:findcribs/screens/listing_process/listing/edit_listing/rent_listing_edit/rent_listing_edit1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../models/property_option_model.dart';
import '../../../../../../listing_process/listing/edit_listing/sale_listing_edit/sale_listing_edit1.dart';
import '../../disabled_listing/disabled_listing.dart';
import '../../promotion page/promote_listing.dart';
import '../../saved_listing/saved_listing.dart';
import '../active_listing.dart';
import 'package:http/http.dart' as http;

class SinglePropertyStatus extends StatefulWidget {
  final List? image;
  final String? currency;
  final String? propertyAddress;
  final String propertyName;
  final String? propertyLocation;
  final String? id;
  final String? formattedPrice;
  final String? status;
  final String likeCOunt;
  final String viewCount;
  final bool? isPromoted;
  final String? category;
  const SinglePropertyStatus({
    Key? key,
    required this.image,
    required this.currency,
    required this.propertyAddress,
    required this.id,
    required this.formattedPrice,
    required this.status,
    required this.likeCOunt,
    required this.viewCount,
    required this.isPromoted,
    required this.propertyLocation,
    this.category,
    required this.propertyName,
  }) : super(key: key);

  @override
  State<SinglePropertyStatus> createState() => _SinglePropertyStatusState();
}

class _SinglePropertyStatusState extends State<SinglePropertyStatus> {
  bool isDeleting = false;
  late CustomPopupMenuController _controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _controller = CustomPopupMenuController();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: .3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isDeleting
                  ? const CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : widget.image!.isEmpty
                      ? Image.asset(
                          'assets/images/property_image.png',
                          height: 100,
                          width: 126,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.image!.isEmpty
                              ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                              : widget.image![0]['url'],
                          fit: BoxFit.cover,
                          width: 126,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  JumpingDotsProgressIndicator(
                            fontSize: 20.0,
                            color: Colors.blue,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
              const SizedBox(width: 24.06),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.6,
                        child: Text(
                          widget.currency.toString() == 'Naira'
                              ? "NGN ${widget.formattedPrice}"
                              : "\$ ${widget.formattedPrice}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF09172D)),
                        ),
                      ),
                      CustomPopupMenu(
                        showArrow: false,
                        menuBuilder: () => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            key: UniqueKey(),
                            color: const Color(0xFFFFFFFF),
                            child: IntrinsicWidth(
                              child: widget.status == 'Active'
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ItemModel(
                                            'Edit',
                                            Image.asset(
                                                'assets/images/edit.png'),
                                            const Color(0XFF8A99B1)),
                                        ItemModel(
                                          'Disable',
                                          Image.asset(
                                              'assets/images/delete.png'),
                                          const Color(0XFFC62E3D),
                                        ),
                                        ItemModel(
                                          'Promote',
                                          Image.asset(
                                              'assets/images/promote.png'),
                                          const Color(0XFFFEC121),
                                        ),
                                        ItemModel(
                                          'Delete',
                                          Image.asset(
                                              'assets/images/delete.png'),
                                          const Color(0XFFC62E3D),
                                        ),
                                      ]
                                          .map(
                                            (item) => GestureDetector(
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onTap: () {
                                                // print("onTap");
                                                // _controller.hideMenu();
                                                item.title == 'Edit'
                                                    ? handleEditListing()
                                                    : item.title == 'Promote'
                                                        ? handlePromoteListing()
                                                        : item.title ==
                                                                'Disabled'
                                                            ? handleDisableListing(
                                                                widget.id
                                                                    .toString())
                                                            : handleDeleteActiveListing(
                                                                widget.id
                                                                    .toString());
                                              },
                                              child: Container(
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  children: <Widget>[
                                                    item.icon,
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          item.title,
                                                          style: TextStyle(
                                                            color: item.color,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : widget.status == 'Saved'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ItemModel(
                                                'Edit',
                                                Image.asset(
                                                    'assets/images/edit.png'),
                                                const Color(0XFF8A99B1)),
                                            ItemModel(
                                              'Publish',
                                              Image.asset(
                                                  'assets/images/publish.png'),
                                              const Color(0XFF168912),
                                            ),
                                            ItemModel(
                                              'Delete',
                                              Image.asset(
                                                  'assets/images/delete.png'),
                                              const Color(0XFFC62E3D),
                                            ),
                                          ]
                                              .map(
                                                (item) => GestureDetector(
                                                  // behavior: HitTestBehavior.translucent,
                                                  onTap: () {
                                                    // print("onTap");
                                                    // _controller.hideMenu();
                                                    item.title == 'Edit'
                                                        ? handleEditListing()
                                                        : item.title ==
                                                                'Publish'
                                                            ? handlePublishListing(
                                                                widget.id
                                                                    .toString())
                                                            : item.title ==
                                                                    'Delete'
                                                                ? handleDeleteListing(
                                                                    widget.id
                                                                        .toString())
                                                                : handleEnableListing(
                                                                    widget.id
                                                                        .toString());
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Row(
                                                      children: <Widget>[
                                                        item.icon,
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                              item.title,
                                                              style: TextStyle(
                                                                color:
                                                                    item.color,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ItemModel(
                                                'Enable',
                                                Image.asset(
                                                    'assets/images/enable.png'),
                                                const Color(0XFF168912)),
                                            ItemModel(
                                              'Delete',
                                              Image.asset(
                                                  'assets/images/delete.png'),
                                              const Color(0XFFC62E3D),
                                            ),
                                          ]
                                              .map(
                                                (item) => GestureDetector(
                                                  behavior: HitTestBehavior
                                                      .translucent,
                                                  onTap: () {
                                                    // print("onTap");
                                                    // _controller.hideMenu();
                                                    item.title == 'Enable'
                                                        ? handleEnableListing(
                                                            widget.id
                                                                .toString())
                                                        : handleDeleteListing(
                                                            widget.id
                                                                .toString());
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Row(
                                                      children: <Widget>[
                                                        item.icon,
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                              item.title,
                                                              style: TextStyle(
                                                                color:
                                                                    item.color,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                            ),
                          ),
                        ),
                        pressType: PressType.singleClick,
                        verticalMargin: -10,
                        controller: _controller,
                        // enablePassEvent: false,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child:
                              Image.asset("assets/images/horizontal_line.png"),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.propertyAddress.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF304059)),
                  ),
                  Text(
                    widget.propertyLocation.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8A99B1)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8FEFF),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Color(0xFF8A99B1),
                              size: 9,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.viewCount,
                              style: const TextStyle(
                                  color: Color(0xFF8A99B1),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 9,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.likeCOunt,
                              style: const TextStyle(
                                  color: Color(0xFF8A99B1),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        widget.isPromoted == true
                            ? Image.asset(
                                "assets/images/promote.png",
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        )
      ],
    );
  }

  handleEditListing() {
    _controller.hideMenu();
    if (widget.category == 'rent') {
      Get.to(EditRent1(
        propertyId: int.parse(widget.id.toString()),
      ));
    } else if (widget.category == 'sale') {
      Get.to(const EditSale1());
    } else {
      Get.to(const EditEstateMarket());
    }
  }

  handleDisableListing(String id) async {
    setState(() {
      isDeleting = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.put(Uri.parse("$baseUrl/listing/"), headers: {
      "Authorization": "$token",
    }, body: {
      "id": id,
      "status": "Disabled"
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Listing Disabled',
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const ActiveListing();
          }));
        },
      ).show();
    } else {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }

  handleAddToStory() {}
  handlePublishListing(String id) async {
    setState(() {
      isDeleting = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.put(Uri.parse("$baseUrl/listing/"), headers: {
      "Authorization": "$token",
    }, body: {
      "id": id,
      "status": "Active"
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Listing Published',
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const SavedListing();
          }));
        },
      ).show();
    } else {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }

  handleEnableListing(String id) async {
    setState(() {
      isDeleting = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.put(Uri.parse("$baseUrl/listing/"), headers: {
      "Authorization": "$token",
    }, body: {
      "id": id,
      "status": "Active"
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Listing Enabled',
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const DisabledListing();
          }));
        },
      ).show();
    } else {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }

  handleDeleteListing(String id) async {
    setState(() {
      isDeleting = true;
    });

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response =
        await http.delete(Uri.parse("$baseUrl/listing/$id"), headers: {
      "Authorization": "$token",
    }, body: {
      "id": id,
      "status": "Active"
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        _controller.hideMenu();
        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Listing Deleted',
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const DisabledListing();
          }));
        },
      ).show();
    } else {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }

  handleDeleteActiveListing(String id) async {
    setState(() {
      isDeleting = true;
    });

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response =
        await http.delete(Uri.parse("$baseUrl/listing/$id"), headers: {
      "Authorization": "$token",
    }, body: {
      "id": id,
      "status": "Active"
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      setState(() {
        _controller.hideMenu();
        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Listing Deleted',
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const ActiveListing();
          }));
        },
      ).show();
    } else {
      setState(() {
        _controller.hideMenu();

        isDeleting = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: responseData['message'],
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }

  handlePromoteListing() {
    setState(() {
      _controller.hideMenu();
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return PromoteListingScreen(
          id: widget.id.toString(),
          image: widget.image![0]['url'],
          currency: widget.currency.toString(),
          propertyAddress: widget.propertyAddress.toString(),
          price: widget.formattedPrice.toString(),
          viewCount: widget.viewCount,
          likeCount: widget.likeCOunt,
          formattedPrice: widget.formattedPrice.toString(),
        );
      }));
    });
  }
}
