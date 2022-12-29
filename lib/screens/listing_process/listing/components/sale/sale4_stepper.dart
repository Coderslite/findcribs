// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/constants.dart';
import '../../../../../controller/sale_listing_controller.dart';
import '../../../../homepage/home_root.dart';
import '../../listing.dart';

class Sale4Stepper extends StatefulWidget {
  final String? propertyCategory;
  final String? houseType;
  final String? propertyAddress;
  final String? bedroom;
  final String? bathrooom;
  final String? livingroom;
  final String? kitchen;
  final String? currency;
  final String? charge;
  final String? negotiable;
  final String? location;
  final String? area;
  final String? covered;
  final String? interiorDesign;
  final String? space;
  final String? water;
  final String? electricity;
  final String? propertyDoc;
  final String? salesPrice;
  final List? facilities;
  final String? descriptioon;
  final String? sellerFee;
  const Sale4Stepper(
      {Key? key,
      this.propertyCategory,
      this.houseType,
      this.propertyAddress,
      this.bedroom,
      this.bathrooom,
      this.livingroom,
      this.kitchen,
      this.currency,
      this.charge,
      this.negotiable,
      this.location,
      this.area,
      this.covered,
      this.interiorDesign,
      this.space,
      this.water,
      this.electricity,
      this.propertyDoc,
      this.salesPrice,
      this.facilities,
      this.descriptioon,
      this.sellerFee})
      : super(key: key);

  @override
  State<Sale4Stepper> createState() => _Sale4StepperState();
}

class _Sale4StepperState extends State<Sale4Stepper> {
  final ImagePicker _picker = ImagePicker();

  static final _formKey4 = GlobalKey<FormBuilderState>();
  List images = [];
  List<File> files = [];
  List myImages = [];
  List<File> newfiles = [];

  bool isLoading = false;
  bool isSaving = false;
  SaleListingController saleListingController =
      Get.put(SaleListingController());

  @override
  void dispose() {
    super.dispose();
    _formKey4.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () => Padding(
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
                  InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (_) {
                      //   return Sale3();
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
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0XFF0072BA),
                    child: Text("4"),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: _formKey4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            // handleGetImage();
                            setState(() {
                              getImage();
                            });
                          },
                          child: AnimatedContainer(
                            padding: const EdgeInsets.all(8),
                            height: saleListingController.newfiles.isEmpty
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                saleListingController.newfiles.isEmpty
                                    ? Container()
                                    : SizedBox(
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: saleListingController
                                                .newfiles.length,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 150,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5),
                                            itemBuilder: (context, index) =>
                                                Stack(
                                                  children: [
                                                    Image.file(
                                                        saleListingController
                                                            .newfiles[index]),
                                                    Positioned(
                                                        child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          saleListingController
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
                                    bottom:
                                        MediaQuery.of(context).size.width / 35,
                                    left:
                                        MediaQuery.of(context).size.width / 11,
                                    right:
                                        MediaQuery.of(context).size.width / 11,
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
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width / 35,
                                    bottom:
                                        MediaQuery.of(context).size.width / 35,
                                    left: MediaQuery.of(context).size.width / 9,
                                    right:
                                        MediaQuery.of(context).size.width / 9,
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
            ],
          ),
        ),
      ),
    );
  }

  // handleGetImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowCompression: true,
  //     allowMultiple: true,
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     if (mounted) {
  //       setState(() {
  //         files = result.paths.map((path) => File(path!)).toList();
  //         for (int y = 0; y < files.length; y++) {
  //           newfiles.add(files[y]);
  //         }
  //       });
  //     }
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  getImage() async {
    final List<XFile> image = (await _picker.pickMultiImage());

      if (mounted) {
        setState(() {
          for (var img in image) {
            newfiles.add(File(img.path));
            saleListingController.newfiles.add(File(img.path));
          }
        });
      }
  }

  Future handlePublish() async {
    if (_formKey4.currentState!.validate()) {
      if (saleListingController.newfiles.isEmpty ||
          saleListingController.newfiles.length < 3) {
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
          btnCancelOnPress: () {},
        ).show();
      } else {
        setState(() {
          isLoading = true;
        });
        _formKey4.currentState!.save();
        var formData = _formKey4.currentState!.value;

        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));
        request.fields['facilities'] =
            jsonEncode(saleListingController.facilities);
        request.fields['age_restriction'] = '0';
        request.fields['design_type'] =
            saleListingController.designType.value.toString();
        request.fields['property_address'] =
            saleListingController.propertyAddress.value.toString();
        request.fields['bathroom'] =
            saleListingController.bathroom.value.toString();
        request.fields['bedroom'] =
            saleListingController.bedroom.value.toString();
        request.fields['living_room'] =
            saleListingController.livingRoom.value.toString();
        request.fields['currency'] =
            saleListingController.currency.value.toString();
        request.fields['kitchen'] =
            saleListingController.kitchen.value.toString();
        request.fields['rental_frequency'] = "per year";
        request.fields['rental_fee'] =
            saleListingController.saleFee.value.toString();
        request.fields['other_charges'] =
            saleListingController.otherCharges.value.toString() == 'Yes'
                ? '1'
                : '0';
        request.fields['caution_fee'] = '0';
        request.fields['legal_fee'] = '0';
        request.fields['covered_by_property'] =
            saleListingController.coveredBy.value.toString();
        request.fields['agency_fee'] =
            saleListingController.otherCharges.value == 'Yes'
                ? '0'
                : '${saleListingController.saleCommission.value}'.toString();
        request.fields['state'] =
            saleListingController.location.value.toString();
        request.fields['total_area_of_land'] =
            saleListingController.totalArea.value.toString();
        request.fields['interior_design'] = 'Furnished';
        request.fields['parking_space'] =
            saleListingController.parkingSpace.value.toString() == 'Yes'
                ? '1'
                : '0';

        request.fields['availability_of_water'] =
            saleListingController.water.value.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_electricity'] =
            saleListingController.electricity.value.toString() == 'Yes'
                ? '1'
                : '0';

        request.fields['description'] =
            saleListingController.description.value.toString();
        request.fields['property_category'] =
            saleListingController.propertyCategory.value.toString();
        request.fields['property_type'] = "sale";
        request.fields['status'] = 'Active';
        request.fields['location'] =
            saleListingController.location.value.toString();
        request.fields['negotiable'] =
            saleListingController.negotiable.value == 1 ? '1' : '0';
        request.fields['hasDocuments'] =
            saleListingController.propertyDocument.value == 'Yes' ? '1' : '0';
        request.headers['Authorization'] = "$token";

        for (var file in saleListingController.newfiles) {
          final httpImage =
              await http.MultipartFile.fromPath('images', file.path);
          request.files.add(httpImage);
          print(httpImage);
        }

        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        print(respStr);
        if (response.statusCode == 200) {
          // var responseData = await response.stream.toBytes();
          // var result = String.fromCharCodes(responseData);
          // print(result);
          setState(() {
            isLoading = false;
          });
          saleListingController.handleResetInformation();
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
              btnCancel: GestureDetector(
                onTap: () {
                  Get.off(HomePageRoot(navigateIndex: 0));
                },
                child: const Text(
                  "Go Home",
                  style: TextStyle(color: mobileButtonColor, fontSize: 14),
                ),
              ),
              btnOk: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: mobileButtonColor),
                  onPressed: () {
                    Get.off(ListPropertyScreen1(tab: 1));
                  },
                  child: const Text(
                    "List Another",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))).show();
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
      }
    }
  }

  handleSave() async {
    if (_formKey4.currentState!.validate()) {
      if (saleListingController.newfiles.isEmpty ||
          saleListingController.newfiles.length < 3) {
        setState(() {
          isSaving = false;
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
          desc: "Require a minimum of 3 images",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else if (saleListingController.newfiles.length > 5) {
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
          isSaving = true;
        });
        _formKey4.currentState!.save();

        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));
        request.fields['facilities'] =
            jsonEncode(saleListingController.facilities);
        request.fields['age_restriction'] = '0';
        request.fields['design_type'] =
            saleListingController.designType.value.toString();
        request.fields['property_address'] =
            saleListingController.propertyAddress.value.toString();
        request.fields['bathroom'] =
            saleListingController.bathroom.value.toString();
        request.fields['bedroom'] =
            saleListingController.bedroom.value.toString();
        request.fields['living_room'] =
            saleListingController.livingRoom.value.toString();
        request.fields['currency'] =
            saleListingController.currency.value.toString();
        request.fields['kitchen'] =
            saleListingController.kitchen.value.toString();
        request.fields['rental_frequency'] = "per year";
        request.fields['rental_fee'] =
            saleListingController.saleFee.value.toString();
        request.fields['other_charges'] =
            saleListingController.otherCharges.value.toString() == 'Yes'
                ? '1'
                : '0';
        request.fields['caution_fee'] = '0';
        request.fields['legal_fee'] = '0';
        request.fields['covered_by_property'] =
            saleListingController.coveredBy.value.toString();
        request.fields['agency_fee'] =
            saleListingController.otherCharges.value == 'Yes'
                ? '0'
                : '${saleListingController.saleCommission.value}'.toString();
        request.fields['state'] =
            saleListingController.location.value.toString();
        request.fields['total_area_of_land'] =
            saleListingController.totalArea.value.toString();
        request.fields['interior_design'] = 'Furnished';
        request.fields['parking_space'] =
            saleListingController.parkingSpace.value.toString() == 'Yes'
                ? '1'
                : '0';

        request.fields['availability_of_water'] =
            saleListingController.water.value.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_electricity'] =
            saleListingController.electricity.value.toString() == 'Yes'
                ? '1'
                : '0';

        request.fields['description'] =
            saleListingController.description.value.toString();
        request.fields['property_category'] =
            saleListingController.propertyCategory.value.toString();
        request.fields['property_type'] = "sale";
        request.fields['status'] = 'Saved';
        request.fields['location'] =
            saleListingController.location.value.toString();
        request.fields['negotiable'] =
            saleListingController.negotiable.value == 1 ? '1' : '0';
        request.fields['hasDocuments'] =
            saleListingController.propertyDocument.value == 'Yes' ? '1' : '0';
        request.headers['Authorization'] = "$token";
        for (var file in newfiles) {
          final httpImage =
              await http.MultipartFile.fromPath('images', file.path);
          request.files.add(httpImage);
          print(httpImage);
        }

        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          // var responseData = await response.stream.toBytes();
          // var result = String.fromCharCodes(responseData);
          // print(result);
          setState(() {
            isSaving = false;
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
              title: 'Saved to draft  successfully!',
              desc: "You can check your profile page to edit few info!",
              btnCancel: GestureDetector(
                onTap: () {
                  Get.off(HomePageRoot(navigateIndex: 0));
                },
                child: const Text(
                  "Go Home",
                  style: TextStyle(color: mobileButtonColor, fontSize: 14),
                ),
              ),
              btnOk: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: mobileButtonColor),
                  onPressed: () {
                    Get.off(ListPropertyScreen1(tab: 1));
                  },
                  child: const Text(
                    "List Another",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))).show();
          saleListingController.handleResetInformation();
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
