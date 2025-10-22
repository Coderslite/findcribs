// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/login_controller.dart';
import 'package:findcribs/models/payment_plan_model.dart';
import 'package:findcribs/service/PaymentPlanService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../components/payment_plan.dart';
import '../../../../../controller/get_profile_controller.dart';
import '../../../../../controller/rent_listing_controller.dart';
import '../../../../homepage/home_root.dart';

class Rent4Stepper extends StatefulWidget {
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
  final String? location;
  final String? area;
  final String? covered;
  final String? interiorDesign;
  final String? space;
  final String? water;
  final String? electricity;
  final String? cautionFee;
  final String? serviceCharge;
  final String? legalFee;
  final String? agencyFee;
  const Rent4Stepper(
      {super.key,
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
      this.location,
      this.area,
      this.covered,
      this.interiorDesign,
      this.space,
      this.water,
      this.electricity,
      this.cautionFee,
      this.serviceCharge,
      this.legalFee,
      this.agencyFee});

  @override
  State<Rent4Stepper> createState() => _Rent4StepperState();
}

class _Rent4StepperState extends State<Rent4Stepper> {
  List myImages = [];
  List<File> files = [];
  List<File> newfiles = [];

  bool isLoading = false;
  bool isSaving = false;
  double uploadProgress =
      0.0; // Tracks the progress of image uploads (0.0 to 1.0)
  int imagesUploaded = 0; // Tracks the number of images uploaded
  int totalImages = 0; // Total number of images to upload

  RentListingController rentListingController =
      Get.put(RentListingController());

  final formKey4 = GlobalKey<FormBuilderState>();
  bool gettingPlan = true;
  @override
  void dispose() {
    formKey4.currentState?.dispose();
    super.dispose();
  }

  List<PaymentPlanModel> plans = [];

  handleGetPlans() async {
    plans = await PaymentplanService().getPlans();
    gettingPlan = false;
    setState(() {});
  }

  @override
  void initState() {
    handleGetPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return KeyboardDismissOnTap(
      child: Scaffold(
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
                      const Text("")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        key: formKey4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Detailed description of property"),
                            rentListingController.description.value == ''
                                ? FormBuilderTextField(
                                    name: 'description',
                                    maxLines: 5,
                                    minLines: 3,
                                    maxLength: 450,
                                    onChanged: (value) {
                                      rentListingController.description.value =
                                          value.toString();
                                    },
                                    style: TextStyle(
                                      color:
                                          context.textTheme.bodyMedium!.color,
                                      fontFamily: "RedHatDisplay",
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
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
                                    maxLength: 450,
                                    initialValue:
                                        rentListingController.description.value,
                                    onChanged: (value) {
                                      rentListingController.description.value =
                                          value.toString();
                                    },
                                    style: TextStyle(
                                      color:
                                          context.textTheme.bodyMedium!.color,
                                      fontFamily: "RedHatDisplay",
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            const Text("Age restriction to rent ?"),
                            FormBuilderRadioGroup(
                              name: "ageRestriction",
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              activeColor: const Color(0XFF0072BA),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              initialValue:
                                  rentListingController.ageRestriction.value ==
                                          1
                                      ? "Yes"
                                      : "No",
                              onChanged: (value) {
                                if (value == 'Yes') {
                                  setState(() {
                                    rentListingController.ageRestriction.value =
                                        1;
                                  });
                                } else {
                                  setState(() {
                                    rentListingController.ageRestriction.value =
                                        0;
                                  });
                                }
                              },
                              options: const [
                                FormBuilderFieldOption(value: "Yes"),
                                FormBuilderFieldOption(value: "No"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            getProfileController.hasSubscription.value
                                ? Container()
                                : gettingPlan
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimary,
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var x = 0;
                                                x < plans.length;
                                                x++)
                                              paymentPlan(
                                                id: plans[x].id!,
                                                selected: getProfileController
                                                        .subscriptionId.value ==
                                                    plans[x].id.toString(),
                                                name: plans[x].name!,
                                                price:
                                                    plans[x].price.toString(),
                                                benefits: plans[x].benefit!,
                                                subscriptionId:
                                                    getProfileController
                                                        .subscriptionId.value,
                                                returnUrl: Rent4Stepper(),
                                              ),
                                          ],
                                        ),
                                      ),
                            SizedBox(
                              height: 20,
                            ),
                            const Text("Property Media"),
                            InkWell(
                              onTap: () {
                                rentListingController.getImage();
                              },
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(8),
                                height: rentListingController.newfiles.isEmpty
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
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              color: Color(0XFF0072BA),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                    rentListingController.newfiles.isEmpty
                                        ? Container()
                                        : SizedBox(
                                            child: GridView.builder(
                                                shrinkWrap: true,
                                                itemCount: rentListingController
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
                                                            rentListingController
                                                                    .newfiles[
                                                                index]),
                                                        Positioned(
                                                            child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              rentListingController
                                                                  .newfiles
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .cancel_rounded,
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
                            // Updated LinearProgressIndicator with progress text
                            Visibility(
                              visible: isLoading,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LinearProgressIndicator(
                                    color: kPrimary,
                                    backgroundColor: Colors.grey,
                                    value: uploadProgress,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    isLoading
                                        ? 'Uploading $imagesUploaded of $totalImages images...'
                                        : 'Upload Progress: ${((uploadProgress * 100).toStringAsFixed(0))}% (${totalImages - imagesUploaded} images left)',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 500,
                              child: Material(
                                color: const Color(0XFF0072BA),
                                borderRadius: BorderRadius.circular(5),
                                child: MaterialButton(
                                  onPressed: () {
                                    handlePublish();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width /
                                          35,
                                      bottom:
                                          MediaQuery.of(context).size.width /
                                              35,
                                      left:
                                          MediaQuery.of(context).size.width / 9,
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
        ),
      ),
    );
  }

  Future handlePublish() async {
    if (formKey4.currentState!.validate()) {
      if (rentListingController.newfiles.isEmpty ||
          rentListingController.newfiles.length < 3) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          borderSide: const BorderSide(color: Colors.red, width: 2),
          width: 280,
          buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Listing Failed',
          desc: "Require a minimum of 3 images",
          showCloseIcon: true,
          btnCancelOnPress: () {},
        ).show();
      } else {
        try {
          setState(() {
            isLoading = true;
            imagesUploaded = 0;
            totalImages = rentListingController.newfiles.length;
            uploadProgress = 0.0;
          });

          final prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          final request = http.MultipartRequest(
            'POST',
            Uri.parse("$baseUrl/listing"),
          );

          // Add form fields
          request.fields['facilities'] =
              jsonEncode(rentListingController.facilities);
          request.fields['age_restriction'] =
              rentListingController.ageRestriction.value == 0 ? '0' : '1';
          request.fields['design_type'] =
              rentListingController.designType.value.toString();
          request.fields['property_address'] =
              rentListingController.propertyAddress.value.toString();
          request.fields['bathroom'] =
              rentListingController.bathroom.value.toString();
          request.fields['bedroom'] =
              rentListingController.bedroom.value.toString();
          request.fields['living_room'] =
              rentListingController.livingRoom.value.toString();
          request.fields['currency'] =
              rentListingController.currency.value.toString();
          request.fields['kitchen'] =
              rentListingController.kitchen.value.toString();
          request.fields['rental_frequency'] =
              rentListingController.rentFrequency.value.toString();
          request.fields['rental_fee'] =
              rentListingController.rentFee.value.toString();
          request.fields['other_charges'] =
              rentListingController.otherCharges.value.toString() == 'Yes'
                  ? '1'
                  : '0';
          request.fields['caution_fee'] =
              rentListingController.otherCharges.value == 'Yes'
                  ? '0'
                  : rentListingController.cautionFee.value.toString();
          request.fields['serviceCharge'] =
              rentListingController.otherCharges.value == 'Yes'
                  ? '0'
                  : rentListingController.serviceCharge.value.toString();
          request.fields['legal_fee'] =
              rentListingController.otherCharges.value == 'Yes'
                  ? '0'
                  : rentListingController.legalFee.value.toString();
          request.fields['covered_by_property'] =
              rentListingController.coveredBy.value.toString();
          request.fields['agency_fee'] =
              rentListingController.otherCharges.value == 'Yes'
                  ? '0'
                  : rentListingController.agencyFee.value.toString();
          request.fields['state'] =
              rentListingController.state.value.toString();
          request.fields['lga'] = rentListingController.lga.value.toString();
          request.fields['country'] = 'Nigeria';
          request.fields['total_area_of_land'] =
              rentListingController.totalArea.value.toString();
          request.fields['interior_design'] =
              rentListingController.interiorDesign.value.toString();
          request.fields['parking_space'] =
              rentListingController.parkingSpace.toString() == 'Yes'
                  ? '1'
                  : '0';
          request.fields['availability_of_water'] =
              rentListingController.water.toString() == 'Yes' ? '1' : '0';
          request.fields['availability_of_electricity'] =
              rentListingController.electricity.toString() == 'Yes' ? '1' : '0';
          request.fields['description'] =
              rentListingController.description.value.toString();
          request.fields['property_category'] =
              rentListingController.propertyCategory.toString();
          request.fields['property_type'] = "rent";
          request.fields['status'] = 'Active';
          request.fields['location'] = rentListingController.state.toString();
          request.fields['negotiable'] =
              rentListingController.negotiable.value == 1 ? '1' : '0';
          request.headers['Authorization'] = "$token";

          // Add images and track progress
          for (var file in rentListingController.newfiles) {
            final httpImage =
                await http.MultipartFile.fromPath('images', file.path);
            request.files.add(httpImage);

            // Simulate upload progress for each image
            setState(() {
              imagesUploaded++;
              uploadProgress = imagesUploaded / totalImages;
            });

            // Optional: Add a small delay to make the progress visible (for demo purposes)
            await Future.delayed(const Duration(milliseconds: 500));
          }

          var response = await request.send();
          final respStr = await response.stream.bytesToString();
          print(respStr);

          if (response.statusCode == 200) {
            rentListingController.handleResetInformation();
            setState(() {
              isLoading = false;
              uploadProgress = 1.0; // Set to 100% on completion
            });

            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              borderSide: const BorderSide(color: Colors.green, width: 2),
              width: MediaQuery.of(context).size.width / 1.2,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              headerAnimationLoop: false,
              animType: AnimType.bottomSlide,
              title: 'Published successfully!',
              desc: "You can check your profile page to edit few info!",
              btnOk: ElevatedButton(
                onPressed: () {
                  Get.off(const HomePageRoot(navigateIndex: 0));
                },
                child: const Text(
                  "Go Home",
                  style: TextStyle(color: mobileButtonColor, fontSize: 14),
                ),
              ),
            ).show();
          } else {
            setState(() {
              isLoading = false;
            });
            var msg = jsonDecode(respStr);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              borderSide: const BorderSide(color: Colors.red, width: 2),
              width: 280,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
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
        } on Error catch (e) {
          setState(() {
            isLoading = false;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            borderSide: const BorderSide(color: Colors.red, width: 2),
            width: 280,
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Listing Failed',
            desc: e.toString(),
            showCloseIcon: true,
            btnCancelOnPress: () {},
          ).show();
        } catch (e) {
          isLoading = false;
          setState(() {});
          print(e);
        }
      }
    }
  }
}
