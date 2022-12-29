// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../../components/constants.dart';

class EditEstateMarket extends StatefulWidget {
  const EditEstateMarket({Key? key}) : super(key: key);

  @override
  State<EditEstateMarket> createState() => _EditEstateMarketState();
}

class _EditEstateMarketState extends State<EditEstateMarket> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  List images = [];
  List<File> files = [];
  List myImages = [];
  List<File> newfiles = [];

  bool isLoading = false;
  bool isSaving = false;

  bool forRent = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Edit Listing for Estate Market",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(""),
                  ],
                ),
                const SizedBox(height: 20),

                const Text("Property Type"),
                FormBuilderDropdown(
                  name: 'propertyType',
                  isExpanded: true,
                  initialValue: "rent",
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
                    if (value == "For Rent") {
                      setState(() {
                        forRent = true;
                      });
                    } else {
                      setState(() {
                        forRent = false;
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
                FormBuilderTextField(
                  name: 'propertyName',
                  maxLength: 20,
                  // maxLength: 300,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(),
                    ),
                    hintText: "e.g  malls, shop, schools...",
                    hintStyle: const TextStyle(color: Color(0XFFB1B1B1)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Price"),
                FormBuilderTextField(
                  name: 'price',
                  // maxLength: 300,
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
                forRent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Rental Frequency"),
                          FormBuilderDropdown(
                            name: 'rentFrequency',
                            isExpanded: true,
                            initialValue: "Per Year",
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
                FormBuilderDropdown(
                  name: 'location',
                  isExpanded: true,
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
                FormBuilderTextField(
                  name: 'description',
                  minLines: 3,
                  maxLines: 5,
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
                const Text("Property Condition"),
                FormBuilderDropdown(
                  name: 'propertyCondition',
                  isExpanded: true,
                  initialValue: "Newly Built",
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Property Media"),
                // ignore: duplicate_ignore

                InkWell(
                  onTap: () {
                    handleGetImage();
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(8),
                    height: newfiles.isEmpty
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
                        newfiles.isEmpty
                            ? Container()
                            : SizedBox(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: newfiles.length,
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5),
                                    itemBuilder: (context, index) => Stack(
                                          children: [
                                            Image.file(newfiles[index]),
                                            Positioned(
                                                child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  newfiles.removeAt(index);
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
                // FormBuilderFilePicker(
                //   name: 'image',
                //   allowMultiple: true,
                //   type: FileType.image,
                //   selector: const Icon(
                //     Icons.add_a_photo,
                //     color: Color(0XFF0072BA),
                //   ),
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5),
                //       borderSide: const BorderSide(),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: const Color(0XFF0072BA),
                      borderRadius: BorderRadius.circular(5),
                      child: MaterialButton(
                        onPressed: () {
                          handlePublish();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 6,
                            right: MediaQuery.of(context).size.width / 6,
                            top: 4.5,
                            bottom: 4.5,
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Save & Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "RedHatDisplay",
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleGetImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowCompression: true, allowMultiple: true);

    if (result != null) {
      if (mounted) {
        setState(() {
          files = result.paths.map((path) => File(path!)).toList();
          for (int y = 0; y < files.length; y++) {
            newfiles.add(files[y]);
          }
        });
      }
    } else {
      // User canceled the picker
    }
  }

  getImage() async {
    final List<XFile> image = (await _picker.pickMultiImage());

    if (mounted) {
      if (image.isEmpty) {
        setState(() {
          for (var img in image) {
            newfiles.add(File(img.path));
          }
        });
      }
    }
  }

  Future handlePublish() async {
    if (_formKey.currentState!.validate()) {
      if (newfiles.isEmpty || newfiles.length < 3) {
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
          btnOkOnPress: () {},
        ).show();
      } else if (newfiles.length > 5) {
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
          btnOkOnPress: () {},
        ).show();
      } else {
        setState(() {
          isLoading = true;
        });
        _formKey.currentState!.save();
        var formData = _formKey.currentState!.value;

        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));

        request.fields['property_name'] = formData['propertyName'];
        request.fields['age_restriction'] = '0';
        request.fields['design_type'] = 'Modern';
        request.fields['bathroom'] = "0";
        request.fields['bedroom'] = "0";
        request.fields['living_room'] = "0";
        request.fields['currency'] = formData['currency'];
        request.fields['kitchen'] = "0";
        request.fields['rental_frequency'] =
            forRent ? formData['rentFrequency'] : 'Per year';
        request.fields['rental_fee'] = formData['price'];
        request.fields['other_charges'] = '0';
        request.fields['caution_fee'] = '0';
        request.fields['legal_fee'] = '0';
        request.fields['covered_by_property'] = '0';
        request.fields['agency_fee'] = '0';
        request.fields['location'] = formData['location'];
        request.fields['total_area_of_land'] = '0';
        request.fields['interior_design'] = 'Furnished';
        request.fields['parking_space'] = '0';

        request.fields['availability_of_water'] = '0';

        request.fields['availability_of_electricity'] = '0';

        request.fields['description'] = formData['description'];
        request.fields['property_category'] = 'Estate Market';
        request.fields['property_type'] = formData['propertyType'];
        request.fields['property_condition'] = formData['propertyCondition'];
        request.fields['status'] = 'Active';
        request.fields['property_address'] = formData['propertyAddress'];
        request.fields['negotiable'] = formData['negotiable'];
        request.headers['Authorization'] = "$token";

        for (var file in newfiles) {
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
            width: 280,
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            onDismissCallback: (type) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dismissed by $type'),
                ),
              );
            },
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Listing Successful',
            desc: "You have successfully listed a property on Findcribs",
            showCloseIcon: true,
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
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
            onDismissCallback: (type) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dismissed by $type'),
                ),
              );
            },
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Listing Failed',
            desc: "something went wrong",
            showCloseIcon: true,
            btnOkOnPress: () {},
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
            onDismissCallback: (type) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dismissed by $type'),
                ),
              );
            },
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Listing Failed',
            desc: msg['message'].toString(),
            showCloseIcon: true,
            btnOkOnPress: () {},
          ).show();
        }
      }
    }
  }
}
