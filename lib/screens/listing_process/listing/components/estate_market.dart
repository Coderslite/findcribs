// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/controller/estate_listing_controller.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../components/constants.dart';
import '../../../homepage/home_root.dart';
import '../select_listing_type.dart';

class EstateMarket extends StatefulWidget {
  const EstateMarket({Key? key}) : super(key: key);

  @override
  State<EstateMarket> createState() => _EstateMarketState();
}

class _EstateMarketState extends State<EstateMarket> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  List images = [];
  List<File> files = [];
  List myImages = [];
  List<File> newfiles = [];

  bool isLoading = false;
  bool isSaving = false;

  bool? forRent;

  EstateListingController estateListingController =
      Get.put(EstateListingController());

  @override
  void initState() {
    forRent =
        estateListingController.propertyType.value == 'rent' ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Estate Market Listing",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Property Type"),
                  estateListingController.propertyType.value == ''
                      ? FormBuilderDropdown(
                          name: 'propertyType',
                          isExpanded: true,
                          initialValue: "sale",
                          items: [
                            "rent",
                            "sale",
                          ].map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == "rent") {
                              setState(() {
                                forRent = true;
                                estateListingController.propertyType.value =
                                    value.toString();
                              });
                            } else {
                              setState(() {
                                forRent = false;
                                estateListingController.propertyType.value =
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
                        )
                      : FormBuilderDropdown(
                          name: 'propertyType',
                          isExpanded: true,
                          initialValue:
                              estateListingController.propertyType.value,
                          items: [
                            "rent",
                            "sale",
                          ].map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == "rent") {
                              setState(() {
                                forRent = true;
                                estateListingController.propertyType.value =
                                    value.toString();
                              });
                            } else {
                              setState(() {
                                forRent = false;
                                estateListingController.propertyType.value =
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Property Name"),
                  estateListingController.propertyName.value == ''
                      ? FormBuilderTextField(
                          name: 'propertyName',
                          maxLength: 20,
                          // maxLength: 300,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onChanged: (value) {
                            estateListingController.propertyName.value =
                                value.toString();
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                            hintText: "e.g  malls, shop, schools...",
                            hintStyle:
                                const TextStyle(color: Color(0XFFB1B1B1)),
                          ),
                        )
                      : FormBuilderTextField(
                          name: 'propertyName',
                          maxLength: 20,
                          // maxLength: 300,
                          initialValue:
                              estateListingController.propertyName.value,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onChanged: (value) {
                            estateListingController.propertyName.value =
                                value.toString();
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(),
                            ),
                            hintText: "e.g  malls, shop, schools...",
                            hintStyle:
                                const TextStyle(color: Color(0XFFB1B1B1)),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Price"),
                  estateListingController.price.value == ''
                      ? FormBuilderTextField(
                          name: 'price',
                          // maxLength: 300,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                estateListingController.price.value =
                                    0.toString();
                              });
                            }
                            setState(() {
                              if (value!.length <= 1) {
                                if (value == ',' || value == '.') {
                                  setState(() {
                                    estateListingController.price.value =
                                        0.toString();
                                  });
                                }
                              } else {
                                value = value!.replaceAll(",", "");
                                value = value!.replaceAll(".", "");
                                estateListingController.price.value =
                                    value.toString();
                              }
                            });
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
                          name: 'price',
                          // maxLength: 300,
                          onChanged: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                estateListingController.price.value =
                                    0.toString();
                              });
                            }
                            setState(() {
                              if (value!.length <= 1) {
                                if (value == ',' || value == '.') {
                                  setState(() {
                                    estateListingController.price.value =
                                        0.toString();
                                  });
                                }
                              } else {
                                value = value!.replaceAll(",", "");
                                value = value!.replaceAll(".", "");
                                estateListingController.price.value =
                                    value.toString();
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          initialValue: estateListingController.price.value,
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
                  forRent == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Rental Frequency"),
                            estateListingController.rentFrequency.value == ''
                                ? FormBuilderDropdown(
                                    name: 'rentFrequency',
                                    isExpanded: true,
                                    onChanged: (value) {
                                      estateListingController.rentFrequency
                                          .value = value.toString();
                                    },
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
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  )
                                : FormBuilderDropdown(
                                    name: 'rentFrequency',
                                    isExpanded: true,
                                    initialValue: estateListingController
                                        .rentFrequency.value,
                                    onChanged: (value) {
                                      estateListingController.rentFrequency
                                          .value = value.toString();
                                    },
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
                  const Text("Negotiable ?"),
                  FormBuilderDropdown(
                    name: 'negotiable',
                    isExpanded: true,
                    initialValue: estateListingController.negotiable.value == 1
                        ? "Yes"
                        : "No",
                    onChanged: (value) {
                      setState(() {
                        if (value == 'Yes') {
                          estateListingController.negotiable.value = 1;
                        } else {
                          estateListingController.negotiable.value = 0;
                        }
                      });
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
                  const Text("Location (State)"),
                  estateListingController.location.value == ''
                      ? FormBuilderDropdown(
                          name: 'location',
                          isExpanded: true,
                          onChanged: (value) {
                            estateListingController.location.value =
                                value.toString();
                          },
                          items: [
                            "Abia",
                            "Adamawa",
                            "Akwa-ibom",
                            "Anambra",
                            "Bauchi",
                            "Bayelsa",
                            "Benue",
                            "Borno",
                            "Cross River",
                            "Delta",
                            "Ebonyi",
                            "Edo",
                            "Ekiti",
                            "Enugu",
                            "Gombe",
                            "Imo",
                            "Jigawa",
                            "Kaduna",
                            "Kano",
                            "Kastina",
                            "Kebbi",
                            "Kogi",
                            "Kwara",
                            "Lagos",
                            "Nassarawa",
                            "Niger",
                            "Ogun",
                            "Ondo",
                            "Osun",
                            "Oyo",
                            "Plateau",
                            "Rivers",
                            "Sokoto",
                            "Taraba",
                            "Yobe",
                            "Zamfara",
                            "Abuja"
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
                          name: 'location',
                          isExpanded: true,
                          initialValue: estateListingController.location.value,
                          onChanged: (value) {
                            estateListingController.location.value =
                                value.toString();
                          },
                          items: [
                            "Abia",
                            "Adamawa",
                            "Akwa-ibom",
                            "Anambra",
                            "Bauchi",
                            "Bayelsa",
                            "Benue",
                            "Borno",
                            "Cross River",
                            "Delta",
                            "Ebonyi",
                            "Edo",
                            "Ekiti",
                            "Enugu",
                            "Gombe",
                            "Imo",
                            "Jigawa",
                            "Kaduna",
                            "Kano",
                            "Kastina",
                            "Kebbi",
                            "Kogi",
                            "Kwara",
                            "Lagos",
                            "Nassarawa",
                            "Niger",
                            "Ogun",
                            "Ondo",
                            "Osun",
                            "Oyo",
                            "Plateau",
                            "Rivers",
                            "Sokoto",
                            "Taraba",
                            "Yobe",
                            "Zamfara",
                            "Abuja"
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
                  FormBuilderTextField(
                    name: 'propertyAddress',
                    maxLength: 30,
                    keyboardType: TextInputType.streetAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        estateListingController.propertyAddress.value =
                            value.toString();
                      });
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
                  const Text("Detail Description of Property"),
                  estateListingController.description.value == ''
                      ? FormBuilderTextField(
                          name: 'description',
                          minLines: 3,
                          maxLines: 5,
                          maxLength: 250,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onChanged: (value) {
                            estateListingController.description.value =
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
                          minLines: 3,
                          maxLines: 5,
                          maxLength: 250,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          initialValue:
                              estateListingController.description.value,
                          onChanged: (value) {
                            estateListingController.description.value =
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
                  const Text("Property Condition"),
                  estateListingController.propertyCondition.value == ''
                      ? FormBuilderDropdown(
                          name: 'propertyCondition',
                          isExpanded: true,
                          onChanged: (value) {
                            estateListingController.propertyCondition.value =
                                value.toString();
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          items: [
                            "Newly Built",
                            "Fairly Used",
                            "Old",
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
                          name: 'propertyCondition',
                          isExpanded: true,
                          initialValue:
                              estateListingController.propertyCondition,
                          onChanged: (value) {
                            estateListingController.propertyCondition.value =
                                value.toString();
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          items: [
                            "Newly Built",
                            "Fairly Used",
                            "Old",
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
                  // currency == null
                  //     ?
                  estateListingController.currency.value == ''
                      ? FormBuilderDropdown(
                          name: 'currency',
                          isExpanded: true,
                          onChanged: (value) {
                            estateListingController.currency.value =
                                value.toString();
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
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
                          initialValue: estateListingController.currency.value,
                          onChanged: (value) {
                            estateListingController.currency.value =
                                value.toString();
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
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
                    onConfirm: (List<String> selected) {},
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    onSaved: (newValue) {
                      setState(() {
                        estateListingController.facilities.value = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Property Media"),
                  // ignore: duplicate_ignore

                  InkWell(
                    onTap: () {
                      // handleGetImage();
                      setState(() {
                        getImage();
                      });
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(8),
                      height: estateListingController.newfiles.isEmpty
                          ? 50
                          : newfiles.length > 3
                              ? 600
                              : 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color(0XFF0072BA),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  // files == null
                                  //     ? const Text("select photo")
                                  //     : const Text("image Available now"),
                                ],
                              ),
                              // files.isEmpty
                              //     ? Image.asset("assets/images/avatar.png")
                              //     : CircleAvatar(
                              //         child: Image.file(
                              //         files[0],
                              //         fit: BoxFit.fitHeight,
                              //       ))
                            ],
                          ),
                          estateListingController.newfiles.isEmpty
                              ? Container()
                              : SizedBox(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: estateListingController
                                          .newfiles.length,
                                      physics: const ScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemBuilder: (context, index) => Stack(
                                            children: [
                                              Image.file(estateListingController
                                                  .newfiles[index]),
                                              Positioned(
                                                  child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    estateListingController
                                                        .newfiles
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ],
                                          )),
                                ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          handleSave();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color(0XFF0072BA),
                              )),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 35,
                              bottom: MediaQuery.of(context).size.width / 35,
                              left: MediaQuery.of(context).size.width / 11,
                              right: MediaQuery.of(context).size.width / 11,
                            ),
                            child: isSaving
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Color(0XFF0072BA),
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Material(
                        color: const Color(0XFF0072BA),
                        borderRadius: BorderRadius.circular(5),
                        child: MaterialButton(
                          onPressed: () {
                            handlePublish();
                            // print(newfiles.length);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 35,
                              bottom: MediaQuery.of(context).size.width / 35,
                              left: MediaQuery.of(context).size.width / 9,
                              right: MediaQuery.of(context).size.width / 9,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Publish",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getImage() async {
    final List<XFile> image = (await _picker.pickMultiImage());

    if (mounted) {
      if (mounted) {
        setState(() {
          for (var img in image) {
            newfiles.add(File(img.path));
            estateListingController.newfiles.add(File(img.path));
          }
        });
      }
    }
  }

  Future handlePublish() async {
    if (_formKey.currentState!.validate()) {
      if (estateListingController.newfiles.isEmpty ||
          estateListingController.newfiles.length < 3) {
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
          title: 'Listing Failed',
          desc: "Require a minimum of 3 images",
          showCloseIcon: true,
          btnCancelOnPress: () {},
        ).show();
      } else if (estateListingController.newfiles.length > 5) {
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
          title: 'Listing Failed',
          desc: "You can only upload a maximum of 5 images",
          showCloseIcon: true,
          btnCancelOnPress: () {},
        ).show();
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          _formKey.currentState!.save();

          final prefs = await SharedPreferences.getInstance();

          var token = prefs.getString('token');
          final request =
              http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));

          request.fields['property_name'] =
              estateListingController.propertyName.value;
          request.fields['facilities'] =
              jsonEncode(estateListingController.facilities);
          request.fields['age_restriction'] = '0';
          request.fields['design_type'] = 'Modern';
          request.fields['bathroom'] = "0";
          request.fields['bedroom'] = "0";
          request.fields['living_room'] = "0";
          request.fields['currency'] = estateListingController.currency.value;
          request.fields['kitchen'] = "0";
          request.fields['rental_frequency'] = forRent == true
              ? estateListingController.rentFrequency.value
              : 'Per year';
          request.fields['rental_fee'] = estateListingController.price.value;
          request.fields['other_charges'] = '0';
          request.fields['caution_fee'] = '0';
          request.fields['legal_fee'] = '0';
          request.fields['covered_by_property'] = '0';
          request.fields['agency_fee'] = '0';
          request.fields['state'] = estateListingController.location.value;
          request.fields['total_area_of_land'] = '0';
          request.fields['interior_design'] = 'Furnished';
          request.fields['parking_space'] = '0';

          request.fields['availability_of_water'] = '0';

          request.fields['availability_of_electricity'] = '0';

          request.fields['description'] =
              estateListingController.description.value;
          request.fields['property_category'] = 'Estate Market';
          request.fields['property_type'] =
              estateListingController.propertyType.value;
          request.fields['property_condition'] =
              estateListingController.propertyCondition.value;
          request.fields['status'] = 'Active';
          request.fields['property_address'] =
              estateListingController.propertyAddress.value;
          request.fields['negotiable'] =
              estateListingController.negotiable.value == 1 ? "1" : "0";
          request.headers['Authorization'] = "$token";

          for (var file in estateListingController.newfiles) {
            final httpImage =
                await http.MultipartFile.fromPath('images', file.path);
            request.files.add(httpImage);
            print(httpImage);
          }

          var response = await request.send();
          final respStr = await response.stream.bytesToString();
          print(respStr);
          if (response.statusCode == 200) {
            setState(() {
              isLoading = false;
            });
            estateListingController.dispose();
            AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
                width: MediaQuery.of(context).size.width / 1.2,
                buttonsBorderRadius: const BorderRadius.all(
                  Radius.circular(2),
                ),
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Published  successfully!',
                desc: "You can check your profile page to edit few info!",
                btnOk: ElevatedButton(
                  onPressed: () {
                    estateListingController.handleResetInformation();
                    Get.off(HomePageRoot(navigateIndex: 0));
                  },
                  child: const Text(
                    "Go Home",
                    style: TextStyle(color: mobileButtonColor, fontSize: 14),
                  ),
                )).show();
            estateListingController.handleResetInformation();
          } else if (response.statusCode == 500) {
            var msg = jsonDecode(respStr);
            print(msg['message']);
            setState(() {
              isLoading = false;
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
              title: 'Listing Failed',
              desc: "something went wrong",
              showCloseIcon: true,
              btnCancelOnPress: () {},
            ).show();
          } else {
            setState(() {
              isLoading = false;
            });
            var msg = jsonDecode(respStr);
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
              title: 'Listing Failed',
              desc: msg['message'].toString(),
              showCloseIcon: true,
              btnCancelOnPress: () {},
            ).show();
          }
        } on TimeoutException catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        } on SocketException catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        } on Error catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        }
      }
    }
  }

  Future handleSave() async {
    if (_formKey.currentState!.validate()) {
      if (estateListingController.newfiles.isEmpty ||
          estateListingController.newfiles.length < 3) {
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
          title: 'Listing Failed',
          desc: "Require a minimum of 3 images",
          showCloseIcon: true,
          btnCancelOnPress: () {},
        ).show();
      } else if (estateListingController.newfiles.length > 5) {
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
          title: 'Listing Failed',
          desc: "You can only upload a maximum of 5 images",
          showCloseIcon: true,
          btnCancelOnPress: () {},
        ).show();
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          _formKey.currentState!.save();

          final prefs = await SharedPreferences.getInstance();

          var token = prefs.getString('token');
          final request =
              http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));

          request.fields['property_name'] =
              estateListingController.propertyName.value;
          request.fields['facilities'] =
              jsonEncode(estateListingController.facilities);
          request.fields['age_restriction'] = '0';
          request.fields['design_type'] = 'Modern';
          request.fields['bathroom'] = "0";
          request.fields['bedroom'] = "0";
          request.fields['living_room'] = "0";
          request.fields['currency'] = estateListingController.currency.value;
          request.fields['kitchen'] = "0";
          request.fields['rental_frequency'] = forRent == true
              ? estateListingController.rentFrequency.value
              : 'Per year';
          request.fields['rental_fee'] = estateListingController.price.value;
          request.fields['other_charges'] = '0';
          request.fields['caution_fee'] = '0';
          request.fields['legal_fee'] = '0';
          request.fields['covered_by_property'] = '0';
          request.fields['agency_fee'] = '0';
          request.fields['state'] = estateListingController.location.value;
          request.fields['total_area_of_land'] = '0';
          request.fields['interior_design'] = 'Furnished';
          request.fields['parking_space'] = '0';

          request.fields['availability_of_water'] = '0';

          request.fields['availability_of_electricity'] = '0';

          request.fields['description'] =
              estateListingController.description.value;
          request.fields['property_category'] = 'Estate Market';
          request.fields['property_type'] =
              estateListingController.propertyType.value;
          request.fields['property_condition'] =
              estateListingController.propertyCondition.value;
          request.fields['status'] = 'Saved';
          request.fields['property_address'] =
              estateListingController.propertyAddress.value;
          request.fields['negotiable'] =
              estateListingController.negotiable.value == 1 ? "1" : "0";
          request.headers['Authorization'] = "$token";

          for (var file in estateListingController.newfiles) {
            final httpImage =
                await http.MultipartFile.fromPath('images', file.path);
            request.files.add(httpImage);
            print(httpImage);
          }

          var response = await request.send();
          final respStr = await response.stream.bytesToString();
          print(respStr);
          if (response.statusCode == 200) {
            setState(() {
              isLoading = false;
            });
            AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
                width: MediaQuery.of(context).size.width / 1.2,
                buttonsBorderRadius: const BorderRadius.all(
                  Radius.circular(2),
                ),
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Published  successfully!',
                desc: "You can check your profile page to edit few info!",
                btnOk: ElevatedButton(
                  onPressed: () {
                    estateListingController.handleResetInformation();
                    Get.off(HomePageRoot(navigateIndex: 0));
                  },
                  child: const Text(
                    "Go Home",
                    style: TextStyle(color: mobileButtonColor, fontSize: 14),
                  ),
                )).show();
            estateListingController.handleResetInformation();
          } else if (response.statusCode == 500) {
            var msg = jsonDecode(respStr);
            print(msg['message']);
            setState(() {
              isLoading = false;
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
              title: 'Listing Failed',
              desc: "something went wrong",
              showCloseIcon: true,
              btnCancelOnPress: () {},
            ).show();
          } else {
            setState(() {
              isLoading = false;
            });
            var msg = jsonDecode(respStr);
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
              title: 'Listing Failed',
              desc: msg['message'].toString(),
              showCloseIcon: true,
              btnCancelOnPress: () {},
            ).show();
          }
        } on TimeoutException catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        } on SocketException catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        } on Error catch (e) {
          setState(() {
            isLoading = true;
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
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        }
      }
    }
  }
}
