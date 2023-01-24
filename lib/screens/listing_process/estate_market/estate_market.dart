// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent1.dart';
import 'package:findcribs/screens/listing_process/listing/select_listing_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

import '../../../models/user_profile_information_model.dart';
import '../../../service/user_profile_service.dart';

class EstateMarketRegistration extends StatefulWidget {
  const EstateMarketRegistration({Key? key}) : super(key: key);

  @override
  State<EstateMarketRegistration> createState() =>
      _EstateMarketRegistrationState();
}

class _EstateMarketRegistrationState extends State<EstateMarketRegistration> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool manageAllowed = true;
  int selecteCompanySize = 0;
  bool isLoading = false;
  bool isChecking = false;
  String message = '';
  String businessName = '';
  File? file;
  List? availability;
  CroppedFile? cropFile;

  late Future<UserProfile> userProfile;
  handleGetUserInfo() {
    userProfile = getUserProfile();
  }

  @override
  void initState() {
    handleGetUserInfo();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List companySize = [
      selecteCompanySize == 0
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
                  "2-24",
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
                  "2-24",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      selecteCompanySize == 1
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
                  "25-50",
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
                  "25-50",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteCompanySize == 2
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
                  "51-100",
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
                  "51-100",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
      selecteCompanySize == 3
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
                  "101+",
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
                  "101+",
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ),
    ];

    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          bottom: 18.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: const Color(0XFF0072BA),
              borderRadius: BorderRadius.circular(5),
              child: MaterialButton(
                onPressed: () {
                  // handleSave();
                  handleRegisterAgent();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    isLoading ? "processing..." : "Save & Continue",
                    style: const TextStyle(
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
      ),
      body: SafeArea(
        child: FutureBuilder<UserProfile>(
            future: userProfile,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("something went wrong");
              }
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
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
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Kindly provide us brief information about you",
                                style: TextStyle(
                                  fontFamily: "RedHatDisplay",
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Full Name",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    color: Color(0XFF5A5A5A)),
                              ),
                              FormBuilderTextField(
                                name: 'fullName',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                                initialValue:
                                    snapshot.data!.firstName.toString() +
                                        " " +
                                        snapshot.data!.lastName.toString(),
                                enabled: false,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  fillColor: Color(0XFFE6E6E6),
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: "E.g Abraham Great",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFF8A8A8A),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Business Name(Public)",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    color: Color(0XFF5A5A5A)),
                              ),
                              FormBuilderTextField(
                                name: 'businessName',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                                onChanged: (value) {
                                  businessName = value.toString();
                                  validateBusinessName(value.toString());
                                },
                                decoration: InputDecoration(
                                  hintText: "Create a business name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              isChecking
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CollectionSlideTransition(
                                            children: const <Widget>[
                                              CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                radius: 6,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(message),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "About Business",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    color: Color(0XFF5A5A5A)),
                              ),
                              FormBuilderTextField(
                                name: 'about',
                                minLines: 3,
                                maxLines: 5,
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
                                height: 30,
                              ),
                              const Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    color: Color(0XFF5A5A5A)),
                              ),
                              FormBuilderTextField(
                                name: 'phone',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.minLength(context, 11),
                                  FormBuilderValidators.maxLength(context, 11),
                                ]),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                  "How many working staffs are in the company ?"),
                              // SfSlider(
                              //   min: 0.0,
                              //   max: 100.0,
                              //   value: _value,
                              //   interval: 20,
                              //   stepSize: 1,
                              //   showTicks: true,
                              //   showLabels: true,
                              //   enableTooltip: true,
                              //   minorTicksPerInterval: 10,
                              //   onChanged: (dynamic value) {
                              //     setState(() {
                              //       _value = value;
                              //     });
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 30,
                              // ),
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
                                    companySize.length,
                                    (index) {
                                      return InkWell(
                                        onTap: () {
                                          selectedCompanySize(index);
                                        },
                                        child: SizedBox(
                                          width: size.width / 4.5,
                                          child: companySize[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Upload Photo",
                                style: TextStyle(
                                    fontFamily: "RedHatDisplay",
                                    color: Color(0XFF5A5A5A)),
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
                                          Image.asset("assets/images/file.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          cropFile == null
                                              ? const Text("select photo")
                                              : const Text(
                                                  "image Available now"),
                                        ],
                                      ),
                                      cropFile == null
                                          ? Image.asset(
                                              "assets/images/avatar.png")
                                          : SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: ClipOval(
                                                  child: Image.file(
                                                File(cropFile!.path.toString()),
                                                fit: BoxFit.cover,
                                              )),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Booking Tour Availability (?)",
                                    style: TextStyle(
                                        fontFamily: "RedHatDisplay",
                                        color: Color(0XFF5A5A5A)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 68.0),
                                    child: MultiSelectDialogField(
                                      // selectedColor: const Color(0XFF0072BA),
                                      dialogWidth:
                                          MediaQuery.of(context).size.width,
                                      buttonIcon: const Icon(
                                        Icons.check_box,
                                        color: Color(0XFF0072BA),
                                        size: 15,
                                      ),
                                      listType: MultiSelectListType.CHIP,
                                      buttonText: const Text(
                                        "Select availability",
                                        // style: TextStyle(fontWeight: FontWeight.w100),
                                      ),
                                      searchable: true,
                                      items: [
                                        "Monday",
                                        "Tuesday",
                                        "Wednesday",
                                        "Thursday",
                                        "Friday",
                                        "Saturday",
                                        "Sunday",
                                      ]
                                          .map((e) => MultiSelectItem(e, e))
                                          .toList(),
                                      onConfirm: (List<String> selected) {
                                        availability = selected;
                                      },
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  void handleSave() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {}
  }

  selectedCompanySize(index) {
    setState(() {
      selecteCompanySize = index;
    });
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
          cropFile = _croppedFile;
        });
      }
    }
  }

  handleRegisterAgent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      if (availability == null || availability!.isEmpty) {
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
          title: 'Registration Failed',
          desc: "Please select availability",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else if (file == null) {
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
          title: 'Registration Failed',
          desc: "Please choose an image",
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      } else {
        _formKey.currentState!.save();
        final formData = _formKey.currentState!.value;
        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/agent"));
        request.fields['category'] = 'Real_Estate_Company';
        request.fields['full_name'] = formData['fullName'];
        request.fields['business_name'] = formData['businessName'];
        request.fields['phone_number'] = formData['phone'];
        request.fields['about'] = formData['about'];
        request.fields['availability'] = jsonEncode(availability);
        request.fields['systemManaged'] = '0';
        request.fields['staff_no'] = selecteCompanySize == 0
            ? '2-24'
            : selecteCompanySize == 1
                ? '25-50'
                : selecteCompanySize == 2
                    ? ''
                    : selecteCompanySize == 3
                        ? '51-100'
                        : '101+';

        request.headers['Authorization'] = "$token";

        final httpImage =
            await http.MultipartFile.fromPath('profile_pic', cropFile!.path);
        request.files.add(httpImage);

        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        print(respStr);
        if (response.statusCode == 201) {
          // var responseData = await response.stream.toBytes();
          // var result = String.fromCharCodes(responseData);
          // print(result);
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
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Registration Successful',
            desc: "You are now a registered Real Estate Company on FindCribs.",
            showCloseIcon: true,
            btnOkOnPress: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return Rent1();
              }));
            },
          ).show();
        } else if (response.statusCode == 500) {
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
            title: 'Registration Failed',
            desc: "Something went wrong",
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
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Registration Failed',
            desc: msg['message'],
            showCloseIcon: true,
            btnOkOnPress: () {},
          ).show();
        }
      }
    }
  }

  Future<bool> validateBusinessName(String businessName) async {
    // if (businessName.isEmpty) {
    //   setState(() {
    //     message = 'business name cannot be empty';
    //   });
    // }
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecking = true;
    });
    var token = prefs.getString('token');
    var businessNameValid = await http.get(
      Uri.parse(
          "$baseUrl/agent/check-business-name-availability?businessName=$businessName"),
      headers: {
        "Authorization": "$token",
      },
    );

    var businessNameResponse = jsonDecode(businessNameValid.body);
    print(businessNameResponse);
    if (businessNameResponse['data']['isAvailable'] == true) {
      if (businessName == '') {
        setState(() {
          message = "business cannot be empty";
          isChecking = false;
        });
        return true;
      } else {
        setState(() {
          message = "business name available";
          isChecking = false;
        });
        return true;
      }
    } else {
      setState(() {
        message = "not available available";

        isChecking = false;
      });
      print(businessNameValid.body);
      return false;
    }
  }
}
