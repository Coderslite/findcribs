import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/service/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controller/get_profile_controller.dart';
import '../../../homepage/home_root.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isUpdating = false;
  final _formKey = GlobalKey<FormBuilderState>();
  // late File profileImage;
  late Future<UserProfile> userProfile;
  GetProfileController getProfileController = Get.put(GetProfileController());

  @override
  void initState() {
    super.initState();
    getProfileController.handleGetProfile();

    userProfile = getUserProfile();
  }

  @override
  void dispose() {
    getProfileController.handleGetProfile();

    super.dispose();
  }

  bool isExpandedName = false;
  bool isExpandedLastName = false;
  bool isExpandedAddress = false;
  bool isExpandedPhone = false;
  bool isExpandedEmail = false;
  bool isUploading = false;

  CroppedFile? croppedFile;
  File? file;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return HomePageRoot(navigateIndex: 4);
        }));
        return true;
      },
      child: Scaffold(
        body: FormBuilder(
          key: _formKey,
          child: SafeArea(
            child: FutureBuilder<UserProfile>(
                future: userProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.hasData) {
                    var userData = snapshot.data!;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: const Color(0XFFF0F7F8),
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                        "assets/svgs/arrow_back.svg"),
                                  ),
                                ),
                              ),
                              Text(
                                "Personal Detaiils",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    fontSize: size.width / 22),
                              ),
                              const Text("            "),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  isUploading
                                      ? const CircularProgressIndicator(
                                          color: Colors.blue,
                                        )
                                      : ClipOval(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: 126,
                                            height: 126,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                JumpingDotsProgressIndicator(
                                              fontSize: 20.0,
                                              color: Colors.blue,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageUrl: userData.profileImg ==
                                                    null
                                                ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                                : userData.profileImg
                                                    .toString(),
                                          ),
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    left: 100,
                                    right: 15,
                                    child: InkWell(
                                      onTap: () {
                                        handleGetImage();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                            "assets/images/edit.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AnimatedContainer(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 15,
                              left: 15,
                            ),
                            height: isExpandedName ? 200 : 60,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpandedName = !isExpandedName;
                                        });
                                      },
                                      // padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userData.firstName.toString(),
                                              style: TextStyle(
                                                fontFamily: "RedHatDisplay",
                                                fontSize: size.width / 26,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            "First Name",
                                            style: TextStyle(
                                                fontSize: size.width / 37,
                                                color: const Color(0XFF8A99B1)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpandedName = !isExpandedName;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        isExpandedName
                                            ? "assets/svgs/arrow_down.svg"
                                            : "assets/svgs/arrow_forward.svg",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isExpandedName
                                    ? Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller:
                                                    _firstNameController,
                                                validator: FormBuilderValidators
                                                    .compose(
                                                  [
                                                    FormBuilderValidators
                                                        .required(context)
                                                  ],
                                                ),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter first name",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width / 33,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF0072BA),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    handleUpdateFirstName(
                                                        _firstNameController
                                                            .text);
                                                  },
                                                  child: Text(
                                                    isUpdating
                                                        ? "Updating...."
                                                        : "Save",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedContainer(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 15,
                              left: 15,
                            ),
                            height: isExpandedLastName ? 200 : 60,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpandedLastName =
                                              !isExpandedLastName;
                                        });
                                      },
                                      // padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userData.lastName.toString(),
                                              style: TextStyle(
                                                fontFamily: "RedHatDisplay",
                                                fontSize: size.width / 26,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            "Last Name",
                                            style: TextStyle(
                                                fontSize: size.width / 37,
                                                color: const Color(0XFF8A99B1)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpandedLastName =
                                              !isExpandedLastName;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        isExpandedLastName
                                            ? "assets/svgs/arrow_down.svg"
                                            : "assets/svgs/arrow_forward.svg",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isExpandedLastName
                                    ? Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: _lastNameController,
                                                validator: FormBuilderValidators
                                                    .compose(
                                                  [
                                                    FormBuilderValidators
                                                        .required(context),
                                                  ],
                                                ),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter Second name",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width / 33,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF0072BA),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    handleUpdateSecondName(
                                                        _lastNameController
                                                            .text);
                                                  },
                                                  child: Text(
                                                    isUpdating
                                                        ? "Updating...."
                                                        : "Save",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // AnimatedContainer(
                          //   padding: const EdgeInsets.only(
                          //     top: 5,
                          //     bottom: 5,
                          //     right: 15,
                          //     left: 15,
                          //   ),
                          //   height: isExpandedAddress ? 200 : 60,
                          //   duration: const Duration(milliseconds: 300),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Colors.grey.withOpacity(0.5),
                          //       width: 1,
                          //     ),
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 isExpandedAddress = !isExpandedAddress;
                          //               });
                          //             },
                          //             // padding: const EdgeInsets.all(5.0),
                          //             // width: size.width / 1.5,
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 SizedBox(
                          //                   child: Text(
                          //                     "22, oyo efam street, calabar",
                          //                     style: TextStyle(
                          //                       fontFamily: "RedHatDisplay",
                          //                       fontSize: size.width / 26,
                          //                       fontWeight: FontWeight.bold,
                          //                       overflow: TextOverflow.ellipsis,
                          //                     ),
                          //                     softWrap: true,
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Address",
                          //                   style: TextStyle(
                          //                       fontSize: size.width / 37,
                          //                       color: const Color(0XFF8A99B1)),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 isExpandedAddress = !isExpandedAddress;
                          //               });
                          //             },
                          //             child: SvgPicture.asset(
                          //               isExpandedAddress
                          //                   ? "assets/svgs/arrow_down.svg"
                          //                   : "assets/svgs/arrow_forward.svg",
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       isExpandedAddress
                          //           ? Expanded(
                          //               child: SingleChildScrollView(
                          //                 child: Column(
                          //                   children: [
                          //                     TextField(
                          //                       decoration: InputDecoration(
                          //                           hintText: "Enter address",
                          //                           hintStyle: TextStyle(
                          //                             fontSize: size.width / 33,
                          //                           ),
                          //                           border: OutlineInputBorder(
                          //                               borderRadius:
                          //                                   BorderRadius.circular(
                          //                                       15))),
                          //                     ),
                          //                     const SizedBox(
                          //                       height: 10,
                          //                     ),
                          //                     Material(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       color: const Color(0XFF0072BA),
                          //                       child: MaterialButton(
                          //                         onPressed: () {},
                          //                         child: const Text(
                          //                           "Save",
                          //                           style: TextStyle(
                          //                             color: Colors.white,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //               ),
                          //             )
                          //           : Container(),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          AnimatedContainer(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 15,
                              left: 15,
                            ),
                            height: isExpandedPhone ? 200 : 60,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      // padding: const EdgeInsets.all(8.0),
                                      onTap: () {
                                        setState(() {
                                          isExpandedPhone = !isExpandedPhone;
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              userData.phoneNumber ??
                                                  "Enter your mobile number",
                                              style: TextStyle(
                                                fontFamily: "RedHatDisplay",
                                                fontSize: size.width / 25,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            "Phone number",
                                            style: TextStyle(
                                                fontSize: size.width / 37,
                                                color: const Color(0XFF8A99B1)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpandedPhone = !isExpandedPhone;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        isExpandedPhone
                                            ? "assets/svgs/arrow_down.svg"
                                            : "assets/svgs/arrow_forward.svg",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isExpandedPhone
                                    ? Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: _phoneController,
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators.numeric(
                                                      context),
                                                  FormBuilderValidators
                                                      .minLength(context, 11),
                                                ]),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter new mobile number",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width / 33,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF0072BA),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    handleUpdatePhone(
                                                        _phoneController.text);
                                                  },
                                                  child: Text(
                                                    isUpdating
                                                        ? "Updating...."
                                                        : "Save",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedContainer(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: 15,
                              left: 15,
                            ),
                            height: isExpandedEmail ? 200 : 60,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(userData.email.toString(),
                                            style: TextStyle(
                                              fontFamily: "RedHatDisplay",
                                              fontSize: size.width / 25,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          "Email email address",
                                          style: TextStyle(
                                              fontSize: size.width / 37,
                                              color: const Color(0XFF8A99B1)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isExpandedEmail
                                    ? Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: "Enter address",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width / 33,
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF0072BA),
                                                child: MaterialButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CollectionSlideTransition(
                          children: const <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 12,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.yellow,
                              radius: 12,
                            ),
                          ],
                        ),
                        FadingText('Loading...'),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  handleUpdateFirstName(firstName) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUpdating = true;
      });
      var token = prefs.getString('token');
      final response = await http.put(Uri.parse("$baseUrl/profile"), headers: {
        "Authorization": "$token",
      }, body: <String, String>{
        'first_name': firstName,
      });
      var responseData = jsonDecode(response.body);

      if (responseData['status'] == true) {
        setState(() {
          isUpdating = false;
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
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const PersonalInformationScreen();
            }));
          },
        ).show();
      } else {
        setState(() {
          isUpdating = false;
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
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  handleUpdateSecondName(secondName) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUpdating = true;
      });
      var token = prefs.getString('token');
      final response = await http.put(Uri.parse("$baseUrl/profile"), headers: {
        "Authorization": "$token",
      }, body: <String, String>{
        'last_name': secondName,
      });
      var responseData = jsonDecode(response.body);

      if (responseData['status'] == true) {
        setState(() {
          isUpdating = false;
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
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const PersonalInformationScreen();
            }));
          },
        ).show();
      } else {
        setState(() {
          isUpdating = false;
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
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  handleUpdatePhone(phone) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUpdating = true;
      });
      var token = prefs.getString('token');
      final response = await http.put(Uri.parse("$baseUrl/profile"), headers: {
        "Authorization": "$token",
      }, body: <String, String>{
        'phone_number': phone,
      });
      var responseData = jsonDecode(response.body);

      if (responseData['status'] == true) {
        setState(() {
          isUpdating = false;
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
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const PersonalInformationScreen();
            }));
          },
        ).show();
      } else {
        setState(() {
          isUpdating = false;
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
          title: 'Update Successful',
          desc: responseData['message'],
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  handleGetImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path.toString());
        _cropImage();
      });
    } else {}
  }

  Future<void> _cropImage() async {
    if (file != null) {
      var _croppedFile = await ImageCropper().cropImage(
        sourcePath: file!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: const Color(0XFF0072BA),
              toolbarWidgetColor: Colors.white,
              statusBarColor: const Color(0XFF0072BA),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (_croppedFile != null) {
        setState(() {
          croppedFile = _croppedFile;
          handleUpdateImage();
        });
      }
    }
  }

  handleUpdateImage() async {
    setState(() {
      isUploading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final request =
        http.MultipartRequest('PUT', Uri.parse("$baseUrl/profile/picture"));
    request.headers['Authorization'] = "$token";

    final httpImage =
        await http.MultipartFile.fromPath('profile_pic', croppedFile!.path);
    request.files.add(httpImage);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        isUploading = false;
      });
      // var responseData = await response.stream.toBytes();
      // var result = String.fromCharCodes(responseData);
      // print(result);
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
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        desc: "Images Updated Successfullyg",
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    } else {
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
        title: 'Image Update Failed',
        desc: "Something went wrong",
        showCloseIcon: true,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
