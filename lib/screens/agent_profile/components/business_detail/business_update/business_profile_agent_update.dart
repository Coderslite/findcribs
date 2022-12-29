import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../components/constants.dart';
import '../../../../../service/user_profile_service.dart';
import 'package:http/http.dart' as http;

class BusinessProfileUpdate extends StatefulWidget {
  const BusinessProfileUpdate({Key? key}) : super(key: key);

  @override
  State<BusinessProfileUpdate> createState() => _BusinessProfileUpdateState();
}

class _BusinessProfileUpdateState extends State<BusinessProfileUpdate> {
  final _formKey = GlobalKey<FormBuilderState>();
  CroppedFile? croppedFile;
  File? file;
  List availability = [];
  List newAvailability = [];
  bool isLoading = false;
  bool isChecking = false;
  late Future<UserProfile> userProfile;
  String message = '';
  bool manageAllowed = false;
  int selecteCompanySize = 0;
  String agentType = '';

  handleGetUserInfo() {
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        selecteCompanySize = value.agent!['staff_no'] == '2-24'
            ? 0
            : value.agent!['staff_no'] == '25-50'
                ? 1
                : value.agent!['staff_no'] == '51-100'
                    ? 2
                    : 3;
        manageAllowed =
            value.agent!['systemManaged'].toString() == 'true' ? true : false;
        print(value.agent!['systemManaged']);
      });
    });
  }

  selectedCompanySize(index) {
    setState(() {
      selecteCompanySize = index;
    });
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
    var size = MediaQuery.of(context).size;
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
                    left: MediaQuery.of(context).size.width / 4,
                    right: MediaQuery.of(context).size.width / 4,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    isLoading ? "processing..." : "Save ",
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
                String data = snapshot.data!.agent!['availability'];
                List<String> myAvailability = (data.split(','));
                // print(availability);
                print(myAvailability);
                print(availability);
                availability = myAvailability;
                agentType = snapshot.data!.agent!['category'];

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
                                initialValue:
                                    snapshot.data!.agent!['business_name'],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                                enabled: false,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  fillColor: const Color(0XFFE6E6E6),
                                  filled: true,
                                  hintText: "Create a business name",
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
                                initialValue: snapshot.data!.agent!['about'],
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
                                initialValue:
                                    snapshot.data!.agent!['phone_number'],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // const Text(
                              //   "Upload Photo",
                              //   style: TextStyle(
                              //       fontFamily: "RedHatDisplay",
                              //       color: Color(0XFF5A5A5A)),
                              // ),

                              // InkWell(
                              //   onTap: () {
                              //     handleGetImage();
                              //   },
                              //   child: Container(
                              //     padding: const EdgeInsets.all(8),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       border: Border.all(),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Row(
                              //           children: [
                              //             Image.asset("assets/images/file.png"),
                              //             const SizedBox(
                              //               width: 5,
                              //             ),
                              //             croppedFile == null
                              //                 ? const Text("select photo")
                              //                 : const Text(
                              //                     "image Available now"),
                              //           ],
                              //         ),
                              //         croppedFile == null
                              //             ? ClipOval(
                              //                 child: SizedBox(
                              //                   width: 40,
                              //                   height: 40,
                              //                   child: Image.network(
                              //                     snapshot.data!.profileImg
                              //                         .toString(),
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //               )
                              //             : ClipOval(
                              //                 child: SizedBox(
                              //                   width: 40,
                              //                   height: 40,
                              //                   child: Image.file(
                              //                     File(croppedFile!.path
                              //                         .toString()),
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //               )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              snapshot.data!.agent!['category'] ==
                                      'Property_Owner'
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          "Do you want FindCribs LTD to Receive Clients calls and manage your property?",
                                          style: TextStyle(
                                            // color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        FormBuilderDropdown(
                                          name: 'findCribManage',
                                          initialValue: snapshot.data!.agent![
                                                      'systemManaged'] ==
                                                  true
                                              ? "Yes"
                                              : "No",
                                          isExpanded: true,
                                          items: [
                                            "Yes",
                                            "No",
                                          ].map((option) {
                                            return DropdownMenuItem(
                                              child: Text(option),
                                              value: option,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value == "Yes") {
                                              setState(() {
                                                manageAllowed = true;
                                              });
                                            } else {
                                              setState(() {
                                                manageAllowed = false;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    )
                                  : Container(),

                              snapshot.data!.agent!['category'] ==
                                      'Real_Estate_Company'
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                      ],
                                    )
                                  : Container(),

                              snapshot.data!.agent!['category'] ==
                                          'Property_Owner' &&
                                      manageAllowed == true
                                  ? const Text("")
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Booking Tour Availability (?)",
                                          style: TextStyle(
                                              fontFamily: "RedHatDisplay",
                                              color: Color(0XFF5A5A5A)),
                                        ),
                                        newAvailability.isEmpty
                                            ? Text(
                                                myAvailability.join(', '),
                                                style: const TextStyle(
                                                    fontFamily: "RedHatDisplay",
                                                    color: Color(0XFF0072BA)),
                                              )
                                            : const Text(""),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 68.0),
                                          child: MultiSelectDialogField(
                                            // selectedColor: const Color(0XFF0072BA),
                                            // initialValue:  jsonDecode(snapshot.data!.agent!['availability']),a\
                                            validator: (valid) {
                                              FormBuilderValidators.compose([
                                                FormBuilderValidators.required(
                                                    context),
                                              ]);
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            dialogWidth: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                            // initialValue: myAvailability,
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
                                                .map((e) =>
                                                    MultiSelectItem(e, e))
                                                .toList(),
                                            onConfirm: (List<String> selected) {
                                              setState(() {
                                                if (selected.isEmpty) {
                                                  newAvailability = [];
                                                } else {
                                                  newAvailability = selected;
                                                }
                                              });
                                            },
                                            onSelectionChanged: (p0) {
                                              // print(p0);
                                              setState(() {
                                                if (p0.isEmpty) {
                                                  newAvailability = [];
                                                } else {
                                                  newAvailability = p0;
                                                }
                                              });
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
                                    )
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
        });
      }
    }
  }

  handleRegisterAgent() async {
    // print(file);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      final formData = _formKey.currentState!.value;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var response = await http.put(Uri.parse('$baseUrl/agent'), headers: {
        "Authorization": "$token",
      }, body: {
        "about": formData['about'],
        "phone_number": formData['phone'],
        "systemManaged": formData['findCribManage'] == 'Yes' ? '1' : '0',
        "availability": formData['findCribManage'] == 'Yes'
            ? jsonEncode(
                ['monday', 'tuesday', 'wedmesday', 'thursday', 'friday'])
            : newAvailability.isEmpty
                ? ""
                : jsonEncode(newAvailability),
        "staff_no": agentType == 'Real_Estate_Company'
            ? selecteCompanySize == 0
                ? '2-24'
                : selecteCompanySize == 1
                    ? '25-50'
                    : selecteCompanySize == 2
                        ? '51-100'
                        : '101+'
            : "",
      });
      var responseData = jsonDecode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
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
          title: 'Updated Successfully',
          desc: "Information Updated successfully",
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        ).show();
      } else if (response.statusCode == 500) {
        // print(responseData);
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
          desc: "something went wrong",
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
          desc: response.reasonPhrase.toString(),
          showCloseIcon: true,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }
}
