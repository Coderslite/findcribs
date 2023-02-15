// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/controller/sale_listing_controller.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale2_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class Sale1 extends StatefulWidget {
  const Sale1({Key? key}) : super(key: key);

  @override
  State<Sale1> createState() => _Sale1State();
}

class _Sale1State extends State<Sale1> {
   final _formKey1 = GlobalKey<FormBuilderState>();
  bool hide = true;

  int? selecteRentBedroom;
  int? selecteRentBathroom;
  int? selecteRentLivingroom;
  int? selecteRentKitchen;
  int? selecteRentLegalFee;
  int? selecteRentAgencyFee;

  SaleListingController saleListingController =
      Get.put(SaleListingController());

  @override
  void initState() {
    selecteRentBedroom = saleListingController.bedroomIndex.toInt();
    selecteRentBathroom = saleListingController.bathroomIndex.toInt();
    selecteRentLivingroom = saleListingController.livingRoomIndex.toInt();
    selecteRentKitchen = saleListingController.kitchenIndex.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List rentBedroomItems = [
      selecteRentBedroom == 0
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentBedroom == 1
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 2
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 3
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 4
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 5
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 6
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 7
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 8
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBedroom == 9
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    List rentBathroomItems = [
      selecteRentBathroom == 0
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentBathroom == 1
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 2
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 3
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 4
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 5
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 6
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 7
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 8
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentBathroom == 9
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    List rentLivingRoomItems = [
      selecteRentLivingroom == 0
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentLivingroom == 1
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 2
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 3
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color( 0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 4
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 5
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 6
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 7
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 8
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color( 0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentLivingroom == 9
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    List rentKitchenItems = [
      selecteRentKitchen == 0
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentKitchen == 1
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "2",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 2
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 3
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "4",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 4
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "5",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 5
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "6",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 6
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: const Color(XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "7",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 7
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "8",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 8
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                // color: const Color(0XFF0072BA),
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(5),
                    // bottomLeft: Radius.circular(5),
                    ),
              ),
              child: const Center(
                child: Text(
                  "9",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteRentKitchen == 9
          ? Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF0072BA),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: const Center(
                child: Text(
                  "10+",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      "Sale Listing",
                      style: TextStyle(fontSize: 20),
                    ),
                  const  Text("")
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0XFF0072BA),
                    child: Text("1"),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: size.width / 5,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (_) {
                      //   return Sale2();
                      // }));
                    },
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: size.width / 5,
                  ),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                    width: size.width / 5,
                  ),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    child: Text(
                      "4",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: FormBuilder(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            const Text("Property Category"),
                            saleListingController.propertyCategory.value
                                        .toString() ==
                                    ''
                                ? FormBuilderDropdown(
                                    name: 'propertyCategory',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      saleListingController.propertyCategory
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Detached Duplex",
                                      "Semi Duplex",
                                      "Terrace",
                                      "Flats",
                                      "Self-Contained",
                                      "Duplex Bungalow",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderDropdown(
                                    name: 'propertyCategory',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    initialValue: saleListingController
                                        .propertyCategory.value,
                                    onChanged: (value) {
                                      saleListingController.propertyCategory
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Detached Duplex",
                                      "Semi Duplex",
                                      "Terrace",
                                      "Flats",
                                      "Self-Contained",
                                      "Duplex Bungalow",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("House Design Type"),
                            saleListingController.designType.value.toString() ==
                                    ''
                                ? FormBuilderDropdown(
                                    name: 'houseDesignType',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      saleListingController.designType.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Contemporary",
                                      "Modern",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderDropdown(
                                    name: 'houseDesignType',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    initialValue:
                                        saleListingController.designType.value,
                                    onChanged: (value) {
                                      saleListingController.designType.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Contemporary",
                                      "Modern",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Property Address"),
                            saleListingController.propertyAddress.value
                                        .toString() ==
                                    ''
                                ? FormBuilderTextField(
                                    name: 'address',
                                    keyboardType: TextInputType.streetAddress,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    maxLength: 30,
                                    onChanged: (value) {
                                      saleListingController.propertyAddress
                                          .value = value.toString();
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderTextField(
                                    name: 'address',
                                    keyboardType: TextInputType.streetAddress,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    maxLength: 30,
                                    initialValue: saleListingController
                                        .propertyAddress.value,
                                    onChanged: (value) {
                                      saleListingController.propertyAddress
                                          .value = value.toString();
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
      
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Interior design"),
                            saleListingController.interiorDesign.value == ''
                                ? FormBuilderDropdown(
                                    name: 'interiorDesign',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      saleListingController.interiorDesign.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Furnished",
                                      "Semi-Furnished",
                                      "Unfurnished"
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderDropdown(
                                    name: 'interiorDesign',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    initialValue: saleListingController
                                        .interiorDesign.value,
                                    onChanged: (value) {
                                      saleListingController.interiorDesign.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Furnished",
                                      "Semi-Furnished",
                                      "Unfurnished"
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Bedroom"),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  // style: BorderStyle.none,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentBedroomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedSaleBedroom(index);
                                      },
                                      child: SizedBox(
                                        width: size.width / 12,
                                        child: rentBedroomItems[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Bathroom"),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  // style: BorderStyle.none,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentBathroomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedSaleBathroom(index);
                                      },
                                      child: SizedBox(
                                        width: size.width / 12,
                                        child: rentBathroomItems[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Living Room"),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  // style: BorderStyle.none,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentLivingRoomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedSaleLivingroom(index);
                                      },
                                      child: SizedBox(
                                        width: size.width / 12,
                                        child: rentLivingRoomItems[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Kitchen"),
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  // style: BorderStyle.none,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentKitchenItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedSaleKitchen(index);
                                      },
                                      child: SizedBox(
                                        width: size.width / 12,
                                        child: rentKitchenItems[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  color: const Color(0XFF0072BA),
                                  borderRadius: BorderRadius.circular(5),
                                  child: MaterialButton(
                                    onPressed: () {
                                      handleNextScreen();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width / 5,
                                        right:
                                            MediaQuery.of(context).size.width / 5,
                                        top: 4.5,
                                        bottom: 4.5,
                                      ),
                                      child: const Text(
                                        "Save & Continue",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "RedHatDisplay",
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleNextScreen() {
    if (_formKey1.currentState!.validate()) {
      _formKey1.currentState!.save();
      if (saleListingController.bedroomIndex > 9) {
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
          desc: "Bedroom not selected",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else if (saleListingController.bathroomIndex > 9) {
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
          desc: "Bathroom not selected",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else if (saleListingController.livingRoomIndex > 9) {
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
          desc: "Living room not selected",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else if (saleListingController.kitchenIndex > 9) {
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
          desc: "Kitchen not selected",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Sale2Stepper();
        }));
      }
    }
  }

  selectedSaleBedroom(index) {
    var bedroom = index == 0
        ? '1'
        : index == 1
            ? '2'
            : index == 2
                ? '3'
                : index == 3
                    ? '4'
                    : index == 4
                        ? '5'
                        : index == 5
                            ? '6'
                            : index == 6
                                ? '7'
                                : index == 7
                                    ? '8'
                                    : index == 8
                                        ? '9'
                                        : '10+';
    setState(() {
      selecteRentBedroom = index;
      saleListingController.bedroom.value = bedroom.toString();
      saleListingController.bedroomIndex.value = index;
      // prefs.setString('bedroom', index.toString());
      // print(bedroom);
    });
  }

  selectedSaleBathroom(index) {
    var bathroom = index == 0
        ? '1'
        : index == 1
            ? '2'
            : index == 2
                ? '3'
                : index == 3
                    ? '4'
                    : index == 4
                        ? '5'
                        : index == 5
                            ? '6'
                            : index == 6
                                ? '7'
                                : index == 7
                                    ? '8'
                                    : index == 8
                                        ? '9'
                                        : '10+';
    setState(() {
      selecteRentBathroom = index;
      saleListingController.bathroomIndex.value = index;
      saleListingController.bathroom.value = bathroom;
    });
  }

  selectedSaleLivingroom(index) {
    var livingRoom = index == 0
        ? '1'
        : index == 1
            ? '2'
            : index == 2
                ? '3'
                : index == 3
                    ? '4'
                    : index == 4
                        ? '5'
                        : index == 5
                            ? '6'
                            : index == 6
                                ? '7'
                                : index == 7
                                    ? '8'
                                    : index == 8
                                        ? '9'
                                        : '10+';
    setState(() {
      selecteRentLivingroom = index;
      saleListingController.livingRoomIndex.value = index;
      saleListingController.livingRoom.value = livingRoom;
    });
  }

  selectedSaleKitchen(index) {
    var kitchenRoom = index == 0
        ? '1'
        : index == 1
            ? '2'
            : index == 2
                ? '3'
                : index == 3
                    ? '4'
                    : index == 4
                        ? '5'
                        : index == 5
                            ? '6'
                            : index == 6
                                ? '7'
                                : index == 7
                                    ? '8'
                                    : index == 8
                                        ? '9'
                                        : '10+';
    setState(() {
      selecteRentKitchen = index;
      saleListingController.kitchen.value = kitchenRoom.toString();
      saleListingController.kitchenIndex.value = index;
    });
  }
}
