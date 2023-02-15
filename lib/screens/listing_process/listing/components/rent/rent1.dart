// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent2_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../controller/rent_listing_controller.dart';

class Rent1 extends StatefulWidget {
  const Rent1({Key? key}) : super(key: key);

  @override
  State<Rent1> createState() => _Rent1State();
}

class _Rent1State extends State<Rent1> {
  bool stepRentTwo = false;
  bool stepRentThird = false;
  bool stepRentFour = false;
  bool hide = true;

  int? selecteRentBedroom;
  int? selecteRentBathroom;
  int? selecteRentLivingroom;
  int? selecteRentKitchen;
  int? selecteRentLegalFee;
  int? selecteRentAgencyFee;

  // String? propertyCategory;
  // String? houseDesignType;
  // String? propertyAddress;
  // String? bedroom;
  // String? bathroom;
  // String? livingRoom;
  // String? kitchen;

  @override
  void initState() {
    selecteRentBedroom = rentListingController.bedroomIndex.toInt();
    selecteRentBathroom = rentListingController.bathroomIndex.toInt();
    selecteRentLivingroom = rentListingController.livingRoomIndex.toInt();
    selecteRentKitchen = rentListingController.kitchenIndex.toInt();
    selecteRentLegalFee = rentListingController.legalFee.toInt();
    selecteRentAgencyFee = rentListingController.agencyFee.toInt();
    super.initState();
  }

  RentListingController rentListingController =
      Get.put(RentListingController());
  final GlobalKey<FormBuilderState> formKey1 = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    formKey1.currentState?.dispose();
    super.dispose();
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
          child: Obx(
            () => Column(
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
                      "Rent Listing",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("")
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
                        //   return const Rent2();
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: FormBuilder(
                        key: formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            const Text("Property Category"),
                            rentListingController.propertyCategory.toString() ==
                                    ''
                                ? FormBuilderDropdown(
                                    name: 'propertyCategory',
                                    key: rentListingController
                                        .propertyCategoryKey,
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      rentListingController.propertyCategory
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Detached Duplex",
                                      "Semi Duplex",
                                      "Terrace",
                                      "Flats",
                                      "Shortlet",
                                      "Service Apartment",
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
                                    initialValue: rentListingController
                                        .propertyCategory.value,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      rentListingController.propertyCategory
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Detached Duplex",
                                      "Semi Duplex",
                                      "Terrace",
                                      "Flats",
                                      "Shortlet",
                                      "Service Apartment",
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
                            rentListingController.designType.toString() == ''
                                ? FormBuilderDropdown(
                                    name: 'houseDesignType',
                                    isExpanded: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      rentListingController.designType.value =
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
                                    onChanged: (value) {
                                      rentListingController.designType.value =
                                          value.toString();
                                    },
                                    initialValue:
                                        rentListingController.designType.value,
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
                            const Text("Property Address)"),
                            rentListingController.propertyAddress.value == ''
                                ? FormBuilderTextField(
                                    name: 'address',
                                    keyboardType: TextInputType.streetAddress,
                                    maxLength: 30,
                                    onChanged: (value) {
                                      rentListingController.propertyAddress
                                          .value = value.toString();
                                    },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
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
                                    maxLength: 30,
                                    initialValue: rentListingController
                                        .propertyAddress.value,
                                    onChanged: (value) {
                                      rentListingController.propertyAddress
                                          .value = value.toString();
                                    },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentBedroomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedRentBedroom(index);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentBathroomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedRentBathroom(index);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentLivingRoomItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedRentLivingroom(index);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  rentKitchenItems.length,
                                  (index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedRentKitchen(index);
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
                                            MediaQuery.of(context).size.width /
                                                5,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                5,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleNextScreen() {
    if (formKey1.currentState!.validate()) {
      if (rentListingController.bedroomIndex > 9) {
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
      } else if (rentListingController.bathroomIndex > 9) {
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
      } else if (rentListingController.livingRoomIndex > 9) {
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
      } else if (rentListingController.kitchenIndex > 9) {
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
        print(rentListingController.bedroom.value);
        print(rentListingController.bathroom.value);
        print(rentListingController.livingRoom.value);
        print(rentListingController.kitchen.value);
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const Rent2Stepper();
        }));
      }
    }
  }

  selectedRentBedroom(index) {
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
      rentListingController.bedroom.value = bedroom.toString();
      rentListingController.bedroomIndex.value = index;
      // prefs.setString('bedroom', index.toString());
      // print(bedroom);
    });
  }

  selectedRentBathroom(index) {
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
      rentListingController.bathroomIndex.value = index;
      rentListingController.bathroom.value = bathroom;
    });
  }

  selectedRentLivingroom(index) {
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
      rentListingController.livingRoomIndex.value = index;
      rentListingController.livingRoom.value = livingRoom;
    });
  }

  selectedRentKitchen(index) {
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
      rentListingController.kitchen.value = kitchenRoom.toString();
      rentListingController.kitchenIndex.value = index;
    });
  }
}
