// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent4_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../controller/load_state_lga_controller.dart';
import '../../../../../controller/rent_listing_controller.dart';

class Rent3Stepper extends StatefulWidget {
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
  final String? cautionFee;
  final String? serviceCharge;
  final String? legalFee;
  final String? agencyFee;
  const Rent3Stepper(
      {Key? key,
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
      this.cautionFee,
      this.serviceCharge,
      this.legalFee,
      this.agencyFee})
      : super(key: key);

  @override
  State<Rent3Stepper> createState() => _Rent3StepperState();
}

class _Rent3StepperState extends State<Rent3Stepper> {
  final formKey3 = GlobalKey<FormBuilderState>();

  List facilities = [];
  String totalAreaOfLand = "0";
  String coveredByProperty = "0";

  RentListingController rentListingController =
      Get.put(RentListingController());
  LoadStateLgaController loadStateLgaController =
      Get.put(LoadStateLgaController());
  @override
  void dispose() {
    formKey3.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Padding(
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
                      "Rent Listing",
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
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) {
                        //   return Rent2();
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
                        //   return Rent3();
                        // }));
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0XFF0072BA),
                        child: Text("3"),
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
                        //   return Rent4();
                        // }));
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey,
                        child: Text(
                          "4",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: formKey3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Location (State)"),
                                  rentListingController.location.value == ''
                                      ? FormBuilderDropdown(
                                          name: 'location',
                                          isExpanded: true,
                                          onChanged: (value) {
                                            rentListingController.location
                                                .value = value.toString();
                                            loadStateLgaController
                                                .handleRentFetchLga();
                                          },
                                          items: loadStateLgaController.data
                                              .map((option) {
                                            return DropdownMenuItem(
                                              value: option['state'].toString(),
                                              child: Text(
                                                  option['state'].toString()),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(),
                                            ),
                                          ),
                                        )
                                      : FormBuilderDropdown(
                                          name: 'State',
                                          isExpanded: true,
                                          initialValue: rentListingController
                                              .location.value,
                                          onChanged: (value) {
                                            rentListingController.location
                                                .value = value.toString();
                                            loadStateLgaController
                                                .handleRentFetchLga();
                                          },
                                          items: loadStateLgaController.data
                                              .map((option) {
                                            return DropdownMenuItem(
                                              value: option['state'].toString(),
                                              child: Text(
                                                  option['state'].toString()),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    rentListingController.location.string == ''
                                        ? false
                                        : true,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("LGA"),
                                      InkWell(
                                        onTap: () {
                                          showLga();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(rentListingController
                                                    .lga.string),
                                                Icon(
                                                  CupertinoIcons
                                                      .arrowtriangle_down_fill,
                                                  size: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Interior design"),
                            rentListingController.interiorDesign.value == ''
                                ? FormBuilderDropdown(
                                    name: 'interiorDesign',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      rentListingController.interiorDesign
                                          .value = value.toString();
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
                                    initialValue: rentListingController
                                        .interiorDesign.value,
                                    onChanged: (value) {
                                      rentListingController.interiorDesign
                                          .value = value.toString();
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
                            const Text("Parking space"),
                            rentListingController.parkingSpace.value == ''
                                ? FormBuilderDropdown(
                                    name: 'space',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      rentListingController.parkingSpace.value =
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
                                    initialValue: rentListingController
                                        .parkingSpace.value,
                                    onChanged: (value) {
                                      rentListingController.parkingSpace.value =
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
                            const Text("Availability of running water"),
                            rentListingController.water.value == ''
                                ? FormBuilderDropdown(
                                    name: 'water',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      rentListingController.water.value =
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
                                    name: 'water',
                                    isExpanded: true,
                                    initialValue:
                                        rentListingController.water.value,
                                    onChanged: (value) {
                                      rentListingController.water.value =
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
                            const Text("Availability of electricity"),
                            rentListingController.water.value == ''
                                ? FormBuilderDropdown(
                                    name: 'electricity',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      rentListingController.electricity.value =
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
                                    name: 'electricity',
                                    isExpanded: true,
                                    initialValue:
                                        rentListingController.electricity.value,
                                    onChanged: (value) {
                                      rentListingController.electricity.value =
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
                            const Text("Facilities in the area(tick)"),
                            MultiSelectDialogField(
                              selectedColor: const Color(0XFF0072BA),
                              searchable: true,
                              dialogWidth: MediaQuery.of(context).size.width,
                              buttonIcon: const Icon(
                                Icons.check_box,
                                color: Color(0XFF0072BA),
                                size: 15,
                              ),
                              items: [
                                "Schools",
                                "Food",
                                "Market",
                                "Restaurant",
                                "Grocery Stores",
                                "Church",
                                "Cinema",
                                "Free Wifi",
                                "Swimming Pool",
                                "Gym Center",
                                "Recreational Centers",
                                "SPA",
                                "Saloon Centers",
                                "Security",
                                "Good Internet",
                                "Air-Conditioning",
                                "Furnished Interior",
                                "Secured Parking Space",
                                "Lounge",
                                "Walldrobe",
                                "Microwave",
                                "Trash Collection"
                              ].map((e) => MultiSelectItem(e, e)).toList(),
                              onConfirm: (List<String> selected) {
                                // print(selected);
                                setState(() {
                                  facilities = selected;
                                  rentListingController.facilities.value =
                                      facilities;
                                });
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  facilities = newValue!;
                                  rentListingController.facilities.value =
                                      newValue;
                                });
                              },
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  )),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLga() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: loadStateLgaController.lga.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                rentListingController.lga.value =
                                    loadStateLgaController.lga[index];
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(loadStateLgaController.lga[index]),
                              ),
                            );
                          })),
                ],
              ),
            );
          });
        });
  }

  handleNextScreen() async {
    if (formKey3.currentState!.validate()) {
      var formData = formKey3.currentState!.value;
      print(formData);
      print(facilities);
      if (facilities.isEmpty) {
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
          desc: "Please select the facilities in the area",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const Rent4Stepper();
        }));
      }
    }
  }
}
