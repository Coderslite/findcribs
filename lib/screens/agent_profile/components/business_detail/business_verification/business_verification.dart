import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:findcribs/controller/business_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';

import '../../../../../components/constants.dart';
import '../../../../../models/user_profile_information_model.dart';
import '../../../../../service/user_profile_service.dart';

class BusinessVerificationScreen extends StatefulWidget {
  const BusinessVerificationScreen({Key? key}) : super(key: key);

  @override
  State<BusinessVerificationScreen> createState() =>
      _BusinessVerificationScreenState();
}

class _BusinessVerificationScreenState
    extends State<BusinessVerificationScreen> {
  File? file;
  bool isLoading = false;
  bool isChecking = false;
  late Future<UserProfile> userProfile;
  String message = '';
  bool manageAllowed = false;
  int selecteCompanySize = 0;
  String agentType = '';
  String isVerified = '';
  int? id;

  handleGetUserInfo() {
    setState(() {
      isLoading = true;
    });
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        isLoading = false;
        id = value.id;
        isVerified = value.agent!['is_verified'];
      });
    });
  }

  BusinessVerificationController businessVerificationController =
      Get.put(BusinessVerificationController());
  @override
  void initState() {
    handleGetUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
            child: isLoading
                ? Center(child: const CircularProgressIndicator())
                : isVerified == 'pending'
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Verification is in progress... please wait")
                          ],
                        ),
                      )
                    : isVerified == 'verfied'
                        ? Center(
                            child: Column(
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    "assets/images/vector.png",
                                    fit: BoxFit.cover,
                                  )),
                              Text("Business Already Verified")
                            ],
                          ))
                        : Obx(
                            () => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: const Color(0XFFF0F7F8),
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                              "assets/svgs/arrow_back.svg"),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Business Verification",
                                      style: TextStyle(
                                          fontFamily: "RedHatDisplay",
                                          fontSize: size.width / 22),
                                    ),
                                    const Text("            "),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "Upload Business Doc (CAC),",
                                      style: TextStyle(
                                          color: Color(0xFF5A5A5A),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    handleGetImage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/file.png"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            file == null
                                                ? const Text(
                                                    "Select file",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF8A8A8A),
                                                        fontSize: 12),
                                                  )
                                                : const Text(
                                                    "File Available now",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF8A8A8A),
                                                        fontSize: 12),
                                                  ),
                                          ],
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Color(0xFF8A99B1),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: size.width / 1.2,
                                          child: const Text(
                                            "Kindly compile all documents in one PDF file",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF8A99B1)),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Color(0xFF8A99B1),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: size.width / 1.2,
                                          child: const Text(
                                            "Document should not be more than 2mb",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF8A99B1)),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 3,
                                          backgroundColor: Color(0xFF8A99B1),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: size.width / 1.2,
                                          child: const Text(
                                            "Fabrication and misleading of information on document are prohibited, any User committing such act will be penalized and fine",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF8A99B1)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: size.width * 0.99,
                                  child: ElevatedButton(
                                    // Connect EndPoint
                                    onPressed: () {
                                      businessVerificationController
                                          .handleVerifyAgent(File(file!.path.toString()), id!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(500, 60),
                                        primary: mobileButtonColor),
                                    child: businessVerificationController
                                            .isLoading.isTrue
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            //  Connect EndPoint

                                            'Upload Document',
                                            style: TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                color: mobileButtonTextColor,
                                                fontSize: 20),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )),
      ),
    );
  }

  handleGetImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path.toString());
      });
    } else {
      Fluttertoast.showToast(msg: "No file was selected");
    }
  }
}
