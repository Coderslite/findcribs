// ignore_for_file: avoid_print

import 'package:findcribs/controller/sale_listing_controller.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale3.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale3_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Sale2Stepper extends StatefulWidget {
  const Sale2Stepper({
    Key? key,
  }) : super(key: key);

  @override
  State<Sale2Stepper> createState() => _Sale2StepperState();
}

class _Sale2StepperState extends State<Sale2Stepper> {
   final _formKey2 = GlobalKey<FormBuilderState>();
   final _saleFeeFormKey = GlobalKey<FormBuilderState>();
  bool? otherChargesIncluded;

  int? selecteSaleFee;
  String rentalFee = '0';
  int cauFee = 0;
  int serCharge = 0;
  int rentFee = 0;
  int totalPrice = 0;
  var formatter = NumberFormat("#,###");

  SaleListingController saleListingController =
      Get.put(SaleListingController());

  @override
  void initState() {
    otherChargesIncluded =
        saleListingController.otherCharges.value == 'Yes' ? true : false;
    selecteSaleFee = saleListingController.saleCommissionIndex.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List salesFee = [
      selecteSaleFee == 0
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
                  "2",
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
                  "2",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteSaleFee == 1
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
      selecteSaleFee == 2
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
                  "10",
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
                  "10",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteSaleFee == 3
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
                  "15",
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
                  "15",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteSaleFee == 4
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
                  "20",
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
                  "20",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                  const Text(
                      "Sale Listing",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) {
                        //   return ListPropertyScreen1(
                        //     tab: 1,
                        //   );
                        // }));
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0XFF0072BA),
                        child: Text("1"),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: size.width / 5,
                    ),
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0XFF0072BA),
                      child: Text("2"),
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
                        //   return Sale3();
                        // }));
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey,
                        child: Text(
                          "3",
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
                        "4",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Parking space"),
                            saleListingController.parkingSpace.value == ''
                                ? FormBuilderDropdown(
                                    name: 'space',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      saleListingController.parkingSpace.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Yes",
                                      "No",
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
                                    name: 'space',
                                    isExpanded: true,
                                    initialValue:
                                        saleListingController.parkingSpace.value,
                                    onChanged: (value) {
                                      saleListingController.parkingSpace.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Yes",
                                      "No",
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
                            const Text("Property Document Available ?"),
                            saleListingController.propertyDocument.value == ''
                                ? FormBuilderDropdown(
                                    name: 'propertyDoc',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      saleListingController.propertyDocument
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Yes",
                                      "No",
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
                                    name: 'propertyDoc',
                                    isExpanded: true,
                                    initialValue: saleListingController
                                        .propertyDocument.value,
                                    onChanged: (value) {
                                      saleListingController.propertyDocument
                                          .value = value.toString();
                                    },
                                    items: [
                                      "Yes",
                                      "No",
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
                            const Text("Currency Type"),
                            saleListingController.currency.value == ''
                                ? FormBuilderDropdown(
                                    name: 'currency',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      saleListingController.currency.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Naira",
                                      "Dollar",
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
                                    name: 'currency',
                                    isExpanded: true,
                                    initialValue:
                                        saleListingController.currency.value,
                                    onChanged: (value) {
                                      saleListingController.currency.value =
                                          value.toString();
                                    },
                                    items: [
                                      "Naira",
                                      "Dollar",
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Sale Price"),
                            saleListingController.saleFee.value == ''
                                ? FormBuilder(
                                    key: _saleFeeFormKey,
                                    child: FormBuilderTextField(
                                      name: 'salesPrice',
                                      // maxLength: 300,
                                      keyboardType: TextInputType.number,
      
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.numeric(context),
                                        FormBuilderValidators.integer(context)
                                      ]),
                                      onChanged: (value) {
                                        if (value!.isEmpty) {
                                          saleListingController.saleFee.value =
                                              0.toString();
                                        } else if (_saleFeeFormKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            saleListingController.saleFee.value =
                                                value.toString();
                                          });
                                        }
                                      },
      
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  )
                                : FormBuilder(
                                    key: _saleFeeFormKey,
                                    child: FormBuilderTextField(
                                      name: 'salesPrice',
                                      // maxLength: 300,
                                      keyboardType: TextInputType.number,
      
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.numeric(context),
                                        FormBuilderValidators.integer(context)
                                      ]),
                                      onChanged: (value) {
                                        if (value!.isEmpty) {
                                          saleListingController.saleFee.value =
                                              0.toString();
                                        } else if (_saleFeeFormKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            saleListingController.saleFee.value =
                                                value.toString();
                                          });
                                        }
                                      },
      
                                      initialValue:
                                          saleListingController.saleFee.value,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Negotiable"),
                            FormBuilderDropdown(
                              name: 'negotiable',
                              isExpanded: true,
                              initialValue:
                                  saleListingController.negotiable.value == 1
                                      ? "Yes"
                                      : "No",
                              onChanged: (value) {
                                if (value == 'Yes') {
                                  setState(() {
                                    saleListingController.negotiable.value = 1;
                                  });
                                } else {
                                  setState(() {
                                    saleListingController.negotiable.value = 0;
                                  });
                                }
                              },
                              items: [
                                "Yes",
                                "No",
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
                            const Text("Other charges included Above?"),
                            saleListingController.otherCharges.value == ''
                                ? FormBuilderDropdown(
                                    name: 'charge',
                                    isExpanded: true,
                                    initialValue: "No",
                                    items: [
                                      "Yes",
                                      "No",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value == 'Yes') {
                                        setState(() {
                                          otherChargesIncluded = false;
                                          saleListingController.otherCharges
                                              .value = value.toString();
                                        });
                                      } else {
                                        setState(() {
                                          otherChargesIncluded = true;
                                          saleListingController.otherCharges
                                              .value = value.toString();
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderDropdown(
                                    name: 'charge',
                                    isExpanded: true,
                                    initialValue:
                                        saleListingController.otherCharges.value,
                                    items: [
                                      "Yes",
                                      "No",
                                    ].map((option) {
                                      return DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value == 'Yes') {
                                        setState(() {
                                          otherChargesIncluded = true;
                                          saleListingController.otherCharges
                                              .value = value.toString();
                                        });
                                      } else {
                                        setState(() {
                                          otherChargesIncluded = false;
                                          saleListingController.otherCharges
                                              .value = value.toString();
                                        });
                                      }
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
                            Visibility(
                              visible: saleListingController.otherCharges.value ==
                                      'Yes'
                                  ? false
                                  : true,
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text("Seller's commission (%)"),
                                      Icon(
                                        Icons.info,
                                        color: Color(0XFF8A99B1),
                                      )
                                    ],
                                  ),
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
                                        salesFee.length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              selectedSaleFee(index);
                                            },
                                            child: SizedBox(
                                              width: size.width / 12,
                                              child: salesFee[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Row(
                                  //   children: const [
                                  //     Text("Agency fee (%)"),
                                  //     Icon(
                                  //       Icons.info,
                                  //       color: Color(0XFF8A99B1),
                                  //     )
                                  //   ],
                                  // ),
                                  // Container(
                                  //   height: 32,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(5),
                                  //     border: Border.all(
                                  //       // style: BorderStyle.none,
                                  //       color: Colors.grey,
                                  //     ),
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: List.generate(
                                  //       rentAgencyFees.length,
                                  //       (index) {
                                  //         return InkWell(
                                  //           onTap: () {
                                  //             selectedRentAgencyFee(index);
                                  //           },
                                  //           child: SizedBox(
                                  //             width: size.width / 12,
                                  //             child: rentAgencyFees[index],
                                  //           ),
                                  //         );
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   children: const [
                                  //     Text("Service Charge"),
                                  //     Icon(
                                  //       Icons.info,
                                  //       color: Color(0XFF8A99B1),
                                  //     )
                                  //   ],
                                  // ),
                                  // FormBuilderTextField(
                                  //   // maxLength: 300,
                                  //   name: 'serviceCharge',
                                  //   validator: FormBuilderValidators.compose([
                                  //     FormBuilderValidators.required(context),
                                  //     FormBuilderValidators.numeric(context)
                                  //   ]),
                                  //   // maxLength: 300,
                                  //   keyboardType: TextInputType.number,
                                  //   onChanged: (value) {
                                  //     if (value!.isEmpty) {
                                  //       setState(() {
                                  //         serCharge = 0;
                                  //       });
                                  //     } else {
                                  //       setState(() {
                                  //         serCharge = int.parse(value);
                                  //         serviceCharge = value;
                                  //       });
                                  //     }
                                  //   },
                                  //   decoration: InputDecoration(
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       borderSide: const BorderSide(),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                ],
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Total Price"),
                            //     Text(
                            //       "N" +
                            //           ((cauFee + serCharge + rentFee) +
                            //                   (rentFee *
                            //                       selecteRentLegalFee /
                            //                       100) +
                            //                   (rentFee * selecteRentAgencyFee))
                            //               .toString(),
                            //       style: TextStyle(
                            //         color: Color(0XFF0072BA),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Detailed description of property"),
                            saleListingController.description.value == ''
                                ? FormBuilderTextField(
                                    name: 'description',
                                    maxLines: 5,
                                    minLines: 3,
                                    maxLength: 250,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    onChanged: (value) {
                                      saleListingController.description.value =
                                          value.toString();
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderTextField(
                                    name: 'description',
                                    maxLines: 5,
                                    minLines: 3,
                                    maxLength: 250,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    initialValue:
                                        saleListingController.description.value,
                                    onChanged: (value) {
                                      saleListingController.description.value =
                                          value.toString();
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total Price"),
                                saleListingController.otherCharges.value == 'Yes'
                                    ? Text(
                                        formatter.format(
                                            saleListingController.saleFee.value ==
                                                    ''
                                                ? 0
                                                : int.parse(saleListingController
                                                    .saleFee.value)),
                                        style: const TextStyle(
                                          color: Color(0XFF0072BA),
                                        ),
                                      )
                                    : Text(
                                        formatter.format(saleListingController
                                                    .saleFee.value ==
                                                ''
                                            ? 0
                                            : int.parse(saleListingController
                                                    .saleFee.value) +
                                                (int.parse(saleListingController
                                                            .saleFee.value) *
                                                        saleListingController
                                                            .saleCommission
                                                            .value) /
                                                    100),
                                        style: const TextStyle(
                                          color: Color(0XFF0072BA),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleNextScreen() async {
    if (_formKey2.currentState!.validate()) {
      _formKey2.currentState!.save();
      print("clicked");
      var formData = _formKey2.currentState!.value;
      // String agencyFee = selecteRentAgencyFee == 0
      //     ? '5'
      //     : selecteRentAgencyFee == 1
      //         ? '10'
      //         : selecteRentAgencyFee == 2
      //             ? '15'
      //             : selecteRentAgencyFee == 3
      //                 ? '20'
      //                 : '25';

      String saleFee = selecteSaleFee == 0
          ? '2'
          : selecteSaleFee == 1
              ? '5'
              : selecteSaleFee == 2
                  ? '10'
                  : selecteSaleFee == 3
                      ? '15'
                      : '20';

      print(formData);
      print("saleFee$saleFee");

      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const Sale3Stepper();
      }));
    }
  }

  selectedSaleFee(index) {
    setState(() {
      selecteSaleFee = index;
      var commission = index == 0
          ? 2
          : index == 1
              ? 5
              : index == 2
                  ? 10
                  : index == 3
                      ? 15
                      : 20;
      saleListingController.saleCommissionIndex.value = index;
      saleListingController.saleCommission.value = commission;
    });
  }
}
