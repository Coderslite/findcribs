// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:findcribs/screens/listing_process/listing/edit_listing/rent_listing_edit/rent_listing_edit3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRent2 extends StatefulWidget {
  final String? propertyCategory;
  final String? houseType;
  final String? propertyAddress;
  final String? bedroom;
  final String? bathrooom;
  final String? livingroom;
  final String? kitchen;
  const EditRent2(
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
  State<EditRent2> createState() => _EditRent2State();
}

class _EditRent2State extends State<EditRent2> {
  static final _formKey2 = GlobalKey<FormBuilderState>();
  bool otherChargesIncluded = true;

  int? selecteRentLegalFee;
  int? selecteRentAgencyFee;
  // String cautionFee = '0';
  // String serviceCharge = '0';

  String? currency;
  String? rentalFrequency;
  String? otherCharge = 'No';
  int rentFee = 0;
  int cautionFee = 0;
  int legalFee = 0;
  int agencyFee = 0;
  int serviceCharge = 0;
  int? negiotable = 0;

  late SharedPreferences prefs;

  // @override
  @override
  void dispose() {
    _formKey2.currentState?.dispose();
    super.dispose();
  }

  handleGetLocalStorage() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      // currency = prefs.getString('currency');
      // rentalFrequency = prefs.getString('rentalFrequency');
      // rentFee = prefs.getString('rentFee');
      // otherCharge = prefs.getString('otherCharge');
      // negiotable = prefs.getString('negiotable');
      // cautionFee = prefs.getString('cautionFee');
      // serviceCharge = prefs.getString('serviceCharge');
      // legalFee = prefs.getString('legalFee');
      // agencyFee = prefs.getString('agencyFee');
      setState(() {
        // selecteRentAgencyFee =  prefs.getString('agencyFee');
        selecteRentLegalFee =
            legalFee == null ? 0 : int.parse(legalFee.toString());
        selecteRentAgencyFee =
            agencyFee == null ? 0 : int.parse(agencyFee.toString());
      });
    });
  }

  @override
  void initState() {
    handleGetLocalStorage();
    super.initState();
  }

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
                    "Edit Listing for Rent",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(""),
                ],
              ),
              const SizedBox(height: 20),
              
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
                    //   return const EditRent2Stepper();
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
                child: FormBuilder(
                  key: _formKey2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Currency Type"),
                        // currency == null
                        //     ?
                        FormBuilderDropdown(
                          name: 'currency',
                          isExpanded: true,
                          items: [
                            "Naira",
                            "Dollar",
                          ].map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            prefs.setString('currency', value.toString());
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                        // : FormBuilderDropdown(
                        //     name: 'currency',
                        //     isExpanded: true,
                        //     initialValue: currency,
                        //     items: [
                        //       "Naira",
                        //       "Dollar",
                        //     ].map((option) {
                        //       return DropdownMenuItem(
                        //         child: Text(option),
                        //         value: option,
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) {
                        //       prefs.setString('currency', value.toString());
                        //     },
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         borderSide: const BorderSide(),
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Rental Frequency"),
                        // rentalFrequency == null
                        //     ?
                        FormBuilderDropdown(
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
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            prefs.setString('rentalFequency', value.toString());
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                        // : FormBuilderDropdown(
                        //     name: 'rent',
                        //     isExpanded: true,
                        //     initialValue: rentalFrequency,
                        //     items: [
                        //       "Per Day",
                        //       "Per Week",
                        //       "Per 2weeks",
                        //       "Per Month",
                        //       "Per 3Months",
                        //       "Per 6Months",
                        //       "Per Year",
                        //       "For 2Years",
                        //       "For 5Years",
                        //       "For 8Years",
                        //       "For 10Years",
                        //     ].map((option) {
                        //       return DropdownMenuItem(
                        //         child: Text(option),
                        //         value: option,
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) {
                        //       prefs.setString(
                        //           'rentalFequency', value.toString());
                        //     },
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         borderSide: const BorderSide(),
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Rental fee"),
                        // rentFee == null
                        //     ?
                        FormBuilderTextField(
                          name: 'rentalFee',
                          // maxLength: 300,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onChanged: (value) {
                            // prefs.setString('rentFee', value.toString());
                            if (value!.isEmpty) {
                              setState(() {
                                rentFee = 0;
                              });
                            }
                            setState(() {
                              rentFee = int.parse(value.toString());
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                        // : FormBuilderTextField(
                        //     name: 'rentalFee',
                        //     initialValue: rentFee,
                        //     // maxLength: 300,
                        //     validator: FormBuilderValidators.compose([
                        //       FormBuilderValidators.required(context),
                        //     ]),
                        //     onChanged: (value) {
                        //       prefs.setString('rentFee', value.toString());
                        //     },
                        //     keyboardType: TextInputType.number,
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         borderSide: const BorderSide(),
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Other charges included Above?"),
                        // otherCharge == null
                        //     ?
                        FormBuilderDropdown(
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
                                otherCharge = 'Yes';
                              });
                            } else {
                              setState(() {
                                otherChargesIncluded = true;
                                otherCharge = 'No';
                                // cautionFee = 0;
                                // serviceCharge = 0;
                                // legalFee = 0;
                                // agencyFee = 0;
                              });
                            }
                            // prefs.setString('otherCharge', value.toString());
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                        // : FormBuilderDropdown(
                        //     name: 'charge',
                        //     isExpanded: true,
                        //     initialValue: otherCharge,
                        //     items: [
                        //       "Yes",
                        //       "No",
                        //     ].map((option) {
                        //       return DropdownMenuItem(
                        //         child: Text(option),
                        //         value: option,
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) {
                        //       if (value == 'Yes') {
                        //         setState(() {
                        //           otherChargesIncluded = false;
                        //         });
                        //       } else {
                        //         setState(() {
                        //           otherChargesIncluded = true;
                        //         });
                        //       }
                        //       prefs.setString(
                        //           'otherCharge', value.toString());
                        //     },
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         borderSide: const BorderSide(),
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(
                          height: 20,
                        ),
                        otherCharge != 'Yes'
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
                                  // cautionFee == null
                                  //     ?
                                  FormBuilderTextField(
                                    name: 'cautionFee',
                                    // maxLength: 300,
                                    // keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        cautionFee =
                                            int.parse(value.toString());
                                      });
                                    },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.number,

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                                  // : FormBuilderTextField(
                                  //     name: 'cautionFee',
                                  //     // maxLength: 300,
                                  //     // keyboardType: TextInputType.number,
                                  //     initialValue: cautionFee,
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         cautionFee = int.parse(value.toString());
                                  //       });
                                  //       prefs.setString(
                                  //           'cautionFee', value.toString());
                                  //     },
                                  //     validator:
                                  //         FormBuilderValidators.compose([
                                  //       FormBuilderValidators.required(
                                  //           context),
                                  //     ]),
                                  //     keyboardType: TextInputType.number,

                                  //     decoration: InputDecoration(
                                  //       border: OutlineInputBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(5),
                                  //         borderSide: const BorderSide(),
                                  //       ),
                                  //     ),
                                  //   ),
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
                                  FormBuilderTextField(
                                    name: 'serviceCharge',
                                    // maxLength: 300,
                                    // keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        serviceCharge =
                                            int.parse(value.toString());
                                      });
                                    },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.number,

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
                                ],
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Price"),
                            Text(
                              (rentFee + cautionFee + serviceCharge).toString(),
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
                          initialValue: "No",
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
                                    left: MediaQuery.of(context).size.width / 5,
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
    );
  }

  handleNextScreen() async {
    if (_formKey2.currentState!.validate()) {
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
        return EditRent3(
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
          cautionFee: cautionFee.toString(),
          serviceCharge: serviceCharge.toString(),
        );
      }));
    }
  }

  selectedRentLegalFee(index) {
    setState(() {
      selecteRentLegalFee = index;
      prefs.setString('legalFee', index.toString());
    });
  }

  selectedRentAgencyFee(index) {
    setState(() {
      selecteRentAgencyFee = index;
      prefs.setString('agencyFee', index.toString());
    });
  }
}
