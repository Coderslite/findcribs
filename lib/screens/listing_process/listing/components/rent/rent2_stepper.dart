// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:findcribs/screens/listing_process/listing/components/rent/rent3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../controller/rent_listing_controller.dart';

class Rent2Stepper extends StatefulWidget {
  final String? propertyCategory;
  final String? houseType;
  final String? propertyAddress;
  final String? bedroom;
  final String? bathrooom;
  final String? livingroom;
  final String? kitchen;
  const Rent2Stepper(
      {Key? key,
      this.propertyCategory,
      this.houseType,
      this.propertyAddress,
      this.bedroom,
      this.bathrooom,
      this.livingroom,
      this.kitchen})
      : super(key: key);

  @override
  State<Rent2Stepper> createState() => _Rent2StepperState();
}

class _Rent2StepperState extends State<Rent2Stepper> {
  static final _formKey2 = GlobalKey<FormBuilderState>();
  static final _rentFeeFormKey = GlobalKey<FormBuilderState>();
  static final _cautionFeeFormKey = GlobalKey<FormBuilderState>();
  static final _serviceChargeFormKey = GlobalKey<FormBuilderState>();
  bool? otherChargesIncluded;

  int? selecteRentLegalFee;
  int? selecteRentAgencyFee;

  RentListingController rentListingController =
      Get.put(RentListingController());

  // @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    otherChargesIncluded =
        rentListingController.otherCharges.value == 'Yes' ? true : false;
    selecteRentAgencyFee = rentListingController.agencyFeeIndex.value;
    selecteRentLegalFee = rentListingController.legalFeeIndex.value;
  }

  var formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List rentLegalFees = [
      selecteRentLegalFee == 0
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
                  "0",
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
                  "0",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentLegalFee == 1
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
      selecteRentLegalFee == 2
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
      selecteRentLegalFee == 3
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
      selecteRentLegalFee == 4
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

    List rentAgencyFees = [
      selecteRentAgencyFee == 0
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
                  "0",
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
                  "0",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteRentAgencyFee == 1
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
      selecteRentAgencyFee == 2
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
      selecteRentAgencyFee == 3
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
      selecteRentAgencyFee == 4
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
                  // color: Colors.blue,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (_) {
                    //   return ListPropertyScreen1(
                    //     tab: 0,
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
                InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (_) {
                    //   return const Rent2Stepper();
                    // }));
                  },
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0XFF0072BA),
                    child: Text("2"),
                  ),
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
                    //   return const Rent3();
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
                child: Obx(
                  () => FormBuilder(
                    key: _formKey2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Currency Type"),
                          rentListingController.currency.value == ''
                              ? FormBuilderDropdown(
                                  name: 'currency',
                                  isExpanded: true,
                                  items: [
                                    "Naira",
                                    "Dollar",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    rentListingController.currency.value =
                                        value.toString();
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
                              : FormBuilderDropdown(
                                  name: 'currency',
                                  isExpanded: true,
                                  initialValue:
                                      rentListingController.currency.value,
                                  items: [
                                    "Naira",
                                    "Dollar",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  onChanged: (value) {
                                    rentListingController.currency.value =
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
                            height: 20,
                          ),
                          const Text("Rental Frequency"),
                          rentListingController.rentFrequency.value == ''
                              ? FormBuilderDropdown(
                                  name: 'rent',
                                  isExpanded: true,
                                  items: [
                                    "Per Day",
                                    "Per Week",
                                    "Per 2weeks",
                                    "Per Month",
                                    "Per 3Months",
                                    "Per 6Months",
                                    "Per Year",
                                    "For 2Years",
                                    "For 5Years",
                                    "For 8Years",
                                    "For 10Years",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    rentListingController.rentFrequency.value =
                                        value.toString();
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
                              : FormBuilderDropdown(
                                  name: 'rent',
                                  isExpanded: true,
                                  initialValue:
                                      rentListingController.rentFrequency.value,
                                  items: [
                                    "Per Day",
                                    "Per Week",
                                    "Per 2weeks",
                                    "Per Month",
                                    "Per 3Months",
                                    "Per 6Months",
                                    "Per Year",
                                    "For 2Years",
                                    "For 5Years",
                                    "For 8Years",
                                    "For 10Years",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    rentListingController.rentFrequency.value =
                                        value.toString();
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
                          const Text("Rental fee"),
                          rentListingController.rentFee.value == '0'
                              ? FormBuilder(
                                  key: _rentFeeFormKey,
                                  child: FormBuilderTextField(
                                    name: 'rentalFee',
                                    // maxLength: 300,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.numeric(context),
                                      FormBuilderValidators.integer(context)
                                    ]),
                                    onChanged: (value) {
                                      if (value!.isEmpty) {
                                        rentListingController.rentFee.value =
                                            0.toString();
                                      } else if (_rentFeeFormKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          rentListingController.rentFee.value =
                                              value.toString();
                                        });
                                      }
                                    },

                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                                )
                              : FormBuilder(
                                  key: _rentFeeFormKey,
                                  child: FormBuilderTextField(
                                    name: 'rentalFee',
                                    initialValue:
                                        rentListingController.rentFee.value,
                                    // maxLength: 300,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.numeric(context),
                                      FormBuilderValidators.integer(context)
                                    ]),
                                    onChanged: (value) {
                                      if (value!.isEmpty) {
                                        rentListingController.rentFee.value =
                                            0.toString();
                                      } else if (_rentFeeFormKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          rentListingController.rentFee.value =
                                              value.toString();
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
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
                          const Text("Other charges included Above?"),
                          rentListingController.otherCharges.value == ''
                              ? FormBuilderDropdown(
                                  name: 'charge',
                                  isExpanded: true,
                                  initialValue: "No",
                                  items: [
                                    "Yes",
                                    "No",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == 'Yes') {
                                      setState(() {
                                        otherChargesIncluded = true;
                                        rentListingController
                                            .otherCharges.value = 'Yes';
                                      });
                                    } else {
                                      setState(() {
                                        otherChargesIncluded = false;
                                        rentListingController
                                            .otherCharges.value = 'No';
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
                                      rentListingController.otherCharges.value,
                                  items: [
                                    "Yes",
                                    "No",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == 'Yes') {
                                      setState(() {
                                        otherChargesIncluded = true;
                                        rentListingController
                                            .otherCharges.value = 'Yes';
                                      });
                                    } else {
                                      setState(() {
                                        otherChargesIncluded = false;
                                        rentListingController
                                            .otherCharges.value = 'No';
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
                          otherChargesIncluded == false
                              ? Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text("Caution fee"),
                                        Icon(
                                          Icons.info,
                                          color: Color(0XFF8A99B1),
                                        )
                                      ],
                                    ),
                                    rentListingController.cautionFee.value == ''
                                        ? Visibility(
                                            visible:
                                                otherChargesIncluded == true
                                                    ? false
                                                    : true,
                                            child: FormBuilder(
                                              key: _cautionFeeFormKey,
                                              child: FormBuilderTextField(
                                                name: 'cautionFee',
                                                // maxLength: 300,
                                                // keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  if (value!.isEmpty) {
                                                    rentListingController
                                                        .cautionFee
                                                        .value = 0.toString();
                                                  } else if (_cautionFeeFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      rentListingController
                                                              .cautionFee
                                                              .value =
                                                          value.toString();
                                                    });
                                                  }
                                                },

                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                  FormBuilderValidators.numeric(
                                                      context),
                                                  FormBuilderValidators.integer(
                                                      context)
                                                ]),
                                                keyboardType:
                                                    TextInputType.number,

                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Visibility(
                                            visible:
                                                otherChargesIncluded == true
                                                    ? false
                                                    : true,
                                            child: FormBuilder(
                                              key: _cautionFeeFormKey,
                                              child: FormBuilderTextField(
                                                name: 'cautionFee',
                                                initialValue:
                                                    rentListingController
                                                        .cautionFee.value,
                                                onChanged: (value) {
                                                  if (value!.isEmpty) {
                                                    rentListingController
                                                        .cautionFee
                                                        .value = 0.toString();
                                                  } else if (_cautionFeeFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      rentListingController
                                                              .cautionFee
                                                              .value =
                                                          value.toString();
                                                    });
                                                  }
                                                },
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                  FormBuilderValidators.numeric(
                                                      context),
                                                  FormBuilderValidators.integer(
                                                      context)
                                                ]),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: const [
                                        Text("Legal fee (%)"),
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
                                          rentLegalFees.length,
                                          (index) {
                                            return InkWell(
                                              onTap: () {
                                                selectedRentLegalFee(index);
                                              },
                                              child: SizedBox(
                                                width: size.width / 12,
                                                child: rentLegalFees[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: const [
                                        Text("Agency fee (%)"),
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
                                          rentAgencyFees.length,
                                          (index) {
                                            return InkWell(
                                              onTap: () {
                                                selectedRentAgencyFee(index);
                                              },
                                              child: SizedBox(
                                                width: size.width / 12,
                                                child: rentAgencyFees[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: const [
                                        Text("Service Charge"),
                                        Icon(
                                          Icons.info,
                                          color: Color(0XFF8A99B1),
                                        )
                                      ],
                                    ),
                                    rentListingController.serviceCharge.value ==
                                            ''
                                        ? Visibility(
                                            visible:
                                                otherChargesIncluded == true
                                                    ? false
                                                    : true,
                                            child: FormBuilder(
                                              key: _serviceChargeFormKey,
                                              child: FormBuilderTextField(
                                                name: 'serviceCharge',
                                                // maxLength: 300,
                                                // keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  if (value!.isEmpty) {
                                                    rentListingController
                                                        .serviceCharge
                                                        .value = 0.toString();
                                                  } else if (_serviceChargeFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      rentListingController
                                                              .serviceCharge
                                                              .value =
                                                          value.toString();
                                                    });
                                                  }
                                                },
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                  FormBuilderValidators.numeric(
                                                      context),
                                                  FormBuilderValidators.integer(
                                                      context)
                                                ]),
                                                keyboardType:
                                                    TextInputType.number,

                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Visibility(
                                            visible:
                                                otherChargesIncluded == true
                                                    ? false
                                                    : true,
                                            child: FormBuilder(
                                              key: _serviceChargeFormKey,
                                              child: FormBuilderTextField(
                                                name: 'serviceCharge',
                                                // maxLength: 300,
                                                // keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  if (value!.isEmpty) {
                                                    rentListingController
                                                        .serviceCharge
                                                        .value = 0.toString();
                                                  } else if (_serviceChargeFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      rentListingController
                                                              .serviceCharge
                                                              .value =
                                                          value.toString();
                                                    });
                                                  }
                                                },

                                                initialValue:
                                                    rentListingController
                                                        .serviceCharge.value,
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                  FormBuilderValidators.numeric(
                                                      context),
                                                  FormBuilderValidators.integer(
                                                      context)
                                                ]),
                                                keyboardType:
                                                    TextInputType.number,

                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Price"),
                              otherChargesIncluded == true
                                  ? Text(
                                      formatter
                                          .format((rentListingController
                                                      .rentFee.value ==
                                                  ''
                                              ? 0
                                              : int.parse(rentListingController
                                                  .rentFee.value)))
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0XFF0072BA),
                                      ),
                                    )
                                  : Text(
                                      formatter
                                          .format((rentListingController.rentFee.value == ''
                                              ? 0
                                              : (int.parse(rentListingController.rentFee.value.toString())) +
                                                  (rentListingController.cautionFee.value == ''
                                                      ? 0
                                                      : (int.parse(rentListingController
                                                          .cautionFee.value
                                                          .toString()))) +
                                                  (rentListingController.serviceCharge.value == ''
                                                      ? 0
                                                      : (int.parse(rentListingController
                                                          .serviceCharge.value
                                                          .toString()))) +
                                                  (rentListingController.rentFee.value == ''
                                                      ? 0
                                                      : ((int.parse(rentListingController.rentFee.value.toString())) *
                                                              rentListingController
                                                                  .agencyFee
                                                                  .value) /
                                                          100) +
                                                  (rentListingController.rentFee.value == ''
                                                      ? 0
                                                      : ((int.parse(rentListingController.rentFee.value.toString()) * rentListingController.legalFee.value) / 100))))
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0XFF0072BA),
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Negotiable?"),
                          FormBuilderRadioGroup(
                            name: "negotiable",
                            initialValue:
                                rentListingController.negotiable.value == 1
                                    ? "Yes"
                                    : "No",
                            onChanged: (value) {
                              if (value == 'Yes') {
                                setState(() {
                                  rentListingController.negotiable.value = 1;
                                });
                              } else {
                                setState(() {
                                  rentListingController.negotiable.value = 0;
                                });
                              }
                            },
                            activeColor: const Color(0XFF0072BA),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: const [
                              FormBuilderFieldOption(value: "Yes"),
                              FormBuilderFieldOption(value: "No"),
                            ],
                            // initialValue: _person.role,
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
            )
          ],
        ),
      ),
    );
  }

  handleNextScreen() async {
    if (_formKey2.currentState!.validate() &&
        _rentFeeFormKey.currentState!.validate() &&
        _cautionFeeFormKey.currentState!.validate() &&
        _serviceChargeFormKey.currentState!.validate()) {
      _formKey2.currentState!.save();
      var formData = _formKey2.currentState!.value;
      String agencyFee = selecteRentAgencyFee == 0
          ? '0'
          : selecteRentAgencyFee == 1
              ? '5'
              : selecteRentAgencyFee == 2
                  ? '10'
                  : selecteRentAgencyFee == 3
                      ? '15'
                      : '20';

      String legalFee = selecteRentLegalFee == 0
          ? '0'
          : selecteRentLegalFee == 1
              ? '5'
              : selecteRentLegalFee == 2
                  ? '10'
                  : selecteRentLegalFee == 3
                      ? '15'
                      : '20';

      print(formData);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Rent3(
          propertyAddress: widget.propertyAddress,
          houseType: widget.houseType,
          propertyCategory: widget.propertyCategory,
          bedroom: widget.bedroom,
          bathrooom: widget.bathrooom,
          livingroom: widget.livingroom,
          kitchen: widget.kitchen,
          charge: formData['charge'],
          currency: formData['currency'],
          rent: formData['rent'],
          rentalFee: formData['rentalFee'],
          negotiable: formData['negotiable'],
          legalFee: legalFee,
          agencyFee: agencyFee,
          cautionFee: rentListingController.serviceCharge.toString(),
          serviceCharge: rentListingController.serviceCharge.toString(),
        );
      }));
    }
  }

  selectedRentLegalFee(index) {
    setState(() {
      selecteRentLegalFee = index;
      int legalFee = index == 0
          ? 0
          : index == 1
              ? 5
              : index == 2
                  ? 10
                  : index == 3
                      ? 15
                      : 20;
      rentListingController.legalFee.value = legalFee;
      rentListingController.legalFeeIndex.value = index;
    });
  }

  selectedRentAgencyFee(index) {
    int agencyFee = index == 0
        ? 0
        : index == 1
            ? 5
            : index == 2
                ? 10
                : index == 3
                    ? 15
                    : 20;
    setState(() {
      selecteRentAgencyFee = index;
      rentListingController.agencyFee.value = agencyFee;
      rentListingController.agencyFeeIndex.value = index;
    });
  }
}
