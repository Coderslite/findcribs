// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale4_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../controller/load_state_lga_controller.dart';
import '../../../../../controller/sale_listing_controller.dart';

class Sale3Stepper extends StatefulWidget {
  const Sale3Stepper({
    Key? key,
  }) : super(key: key);

  @override
  State<Sale3Stepper> createState() => _Sale3StepperState();
}

class _Sale3StepperState extends State<Sale3Stepper> {
  final _formKey3 = GlobalKey<FormBuilderState>();
  bool otherChargesIncluded = false;
  List facilities = [];
  SaleListingController saleListingController =
      Get.put(SaleListingController());
  LoadStateLgaController loadStateLgaController =
      Get.put(LoadStateLgaController());
  final _lgaForm = GlobalKey<FormBuilderState>();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _formKey3.currentState!.dispose();
  // }

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
                      "Sale Listing",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text("")
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
                        //   return Sale2();
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
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0XFF0072BA),
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
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) {
                        //   return Sale4();
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 0.0,
                    ),
                    child: FormBuilder(
                      key: _formKey3,
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
                                saleListingController.location.value == ''
                                    ? FormBuilderDropdown(
                                        name: 'location',
                                        isExpanded: true,
                                        onChanged: (value) {
                                          saleListingController.location.value =
                                              value.toString();
                                          loadStateLgaController
                                              .handleSaleFetchLga();
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
                                        initialValue: saleListingController
                                            .location.value,
                                        onChanged: (value) {
                                          saleListingController.location.value =
                                              value.toString();
                                          loadStateLgaController
                                              .handleSaleFetchLga();
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
                                  saleListingController.location.string == ''
                                      ? false
                                      : true,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(saleListingController
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
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Total area of land (sqm)"),
                          saleListingController.totalArea.value == ''
                              ? FormBuilderTextField(
                                  name: 'area',
                                  // maxLength: 300,
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context)
                                  ]),
                                  onChanged: (value) {
                                    saleListingController.totalArea.value =
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
                                  name: 'area',
                                  // maxLength: 300,
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context)
                                  ]),
                                  initialValue:
                                      saleListingController.totalArea.value,
                                  onChanged: (value) {
                                    saleListingController.totalArea.value =
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
                          const Text("Covered by property (sqm)"),
                          saleListingController.coveredBy.value == ''
                              ? FormBuilderTextField(
                                  name: 'covered',
                                  // maxLength: 300,
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context)
                                  ]),
                                  onChanged: (value) {
                                    saleListingController.coveredBy.value =
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
                                  name: 'covered',
                                  // maxLength: 300,
                                  keyboardType: TextInputType.number,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context)
                                  ]),
                                  initialValue:
                                      saleListingController.coveredBy.value,
                                  onChanged: (value) {
                                    saleListingController.coveredBy.value =
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
                          const Text("Availability of running water"),
                          saleListingController.water.value == ''
                              ? FormBuilderDropdown(
                                  name: 'water',
                                  isExpanded: true,
                                  items: [
                                    // "Excellent",
                                    // "Very Good",
                                    // "Good",
                                    "Yes",
                                    "No"
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    saleListingController.water.value =
                                        value.toString();
                                  },
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
                                  items: [
                                    // "Excellent",
                                    // "Very Good",
                                    // "Good",
                                    "Yes",
                                    "No"
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  initialValue:
                                      saleListingController.water.value,
                                  onChanged: (value) {
                                    saleListingController.water.value =
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
                          const Text("Availability of electricity"),
                          saleListingController.electricity.value == ''
                              ? FormBuilderDropdown(
                                  name: 'electricity',
                                  isExpanded: true,
                                  items: [
                                    "Yes",
                                    "No",
                                    // "Excellent",
                                    // "Very Good",
                                    // "Good",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    saleListingController.electricity.value =
                                        value.toString();
                                  },
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
                                  items: [
                                    "Yes",
                                    "No",
                                    // "Excellent",
                                    // "Very Good",
                                    // "Good",
                                  ].map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  initialValue:
                                      saleListingController.electricity.value,
                                  onChanged: (value) {
                                    saleListingController.electricity.value =
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
                          const Text("Facilities in the area? (tick)"),
                          MultiSelectDialogField(
                            selectedColor: const Color(0XFF0072BA),
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
                              setState(() {
                                facilities = selected;
                                saleListingController.facilities.value =
                                    facilities;
                              });
                            },
                            onSaved: (newValue) {
                              setState(() {
                                facilities = newValue!;
                                saleListingController.facilities.value =
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
                ))
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
                                saleListingController.lga.value =
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
    if (_formKey3.currentState!.validate()) {
      _formKey3.currentState!.save();
      var formData = _formKey3.currentState!.value;
      print(formData);
      // print(facilities);

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
          return const Sale4Stepper();
        }));
      }
    }
  }
}
