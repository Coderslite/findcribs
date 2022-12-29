// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/constants.dart';
import '../../../../homepage/home_root.dart';

class EditSale4 extends StatefulWidget {
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
  final String? description;
  final String? sellerFee;
  const EditSale4(
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
      this.description,
      this.sellerFee})
      : super(key: key);

  @override
  State<EditSale4> createState() => _EditSale4State();
}

class _EditSale4State extends State<EditSale4> {
  final ImagePicker _picker = ImagePicker();

  static final _formKey4 = GlobalKey<FormBuilderState>();
  List images = [];
  List<File> files = [];
  List myImages = [];
  List<File> newfiles = [];

  bool isLoading = false;
  bool isSaving = false;

  @override
  void dispose() {
    super.dispose();
    _formKey4.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  "Edit Listing for Sale",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(""),
              ],
            ),
            const SizedBox(height: 20),
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
                          getImage();
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
                                          itemBuilder: (context, index) =>
                                              Stack(
                                                children: [
                                                  Image.file(newfiles[index]),
                                                  Positioned(
                                                      child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        newfiles
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

                      // FormBuilderFilePicker(
                      //   name: 'image',
                      //   allowMultiple: true,
                      //   // ignore: deprecated_member_use
                      //   type: FileType.image,
                      //   // ignore: deprecated_member_use
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
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 35,
                                  bottom:
                                      MediaQuery.of(context).size.width / 35,
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
          ],
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
      // ignore: unnecessary_null_comparison
      if (image != null) {
        setState(() {
          for (var img in image) {
            newfiles.add(File(img.path));
          }
        });
      }
    }
  }

  Future handlePublish() async {
    if (_formKey4.currentState!.validate()) {
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
        _formKey4.currentState!.save();
        var formData = _formKey4.currentState!.value;

        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));
        // request.fields['age_restriction'] = '0';
        // request.fields['design_type'] = widget.houseType.toString();
        // request.fields['property_address'] = widget.propertyAddress.toString();
        // request.fields['bathroom'] = widget.bathrooom.toString();
        // request.fields['bedroom'] = widget.bedroom.toString();
        // request.fields['living_room'] = widget.livingroom.toString();
        // request.fields['currency'] = "NGN";
        // request.fields['kitchen'] = widget.kitchen.toString();
        // request.fields['rental_frequency'] = widget.rent.toString();
        // request.fields['rental_fee'] = widget.rentalFee.toString();
        // request.fields['other_charges'] = '0';
        // request.fields['caution_fee'] = widget.cautionFee.toString();
        // request.fields['legal_fee'] = widget.legalFee.toString();
        // request.fields['covered_by_property'] = widget.covered.toString();
        // request.fields['agency_fee'] = widget.agencyFee.toString();
        // request.fields['state'] = 'Delta';
        // request.fields['total_area_of_land'] = widget.area.toString();
        // request.fields['interior_design'] = widget.interiorDesign.toString();
        // request.fields['parking_space'] = '0';
        // request.fields['availability_of_water'] = '0';
        // request.fields['availability_of_electricity'] = '0';
        // request.fields['description'] = formData['description'];
        // request.fields['property_type'] = widget.propertyCategory.toString();
        // request.fields['property_category'] = 'rent';
        // request.fields['status'] = 'Active';
        // request.fields['location'] = widget.location.toString();

        request.fields['age_restriction'] =
            formData['ageRestriction'] == 'Yes' ? '1' : '0';
        request.fields['design_type'] = widget.houseType.toString();
        request.fields['property_address'] = widget.propertyAddress.toString();
        request.fields['bathroom'] = widget.bathrooom.toString();
        request.fields['bedroom'] = widget.bedroom.toString();
        request.fields['living_room'] = widget.livingroom.toString();
        request.fields['currency'] = widget.currency.toString();
        request.fields['kitchen'] = widget.kitchen.toString();
        request.fields['rental_frequency'] = "per year";
        request.fields['rental_fee'] = widget.salesPrice.toString();
        request.fields['other_charges'] =
            widget.charge.toString() == 'Yes' ? '1' : '0';
        request.fields['caution_fee'] = '0';
        request.fields['legal_fee'] = '0';
        request.fields['covered_by_property'] = widget.covered.toString();
        request.fields['agency_fee'] =
            widget.charge == 'Yes' ? '0' : '${widget.sellerFee}'.toString();
        request.fields['state'] = widget.location.toString();
        request.fields['total_area_of_land'] = widget.area.toString();
        request.fields['interior_design'] = 'Furnished';
        request.fields['parking_space'] =
            widget.space.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_water'] =
            widget.water.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_electricity'] =
            widget.electricity.toString() == 'Yes' ? '1' : '0';

        request.fields['description'] = widget.description.toString();
        request.fields['property_category'] =
            widget.propertyCategory.toString();
        request.fields['property_type'] = "sale";
        request.fields['status'] = 'Active';
        request.fields['location'] = widget.location.toString();
        request.fields['negotiable'] =
            widget.negotiable.toString() == 'Yes' ? '1' : '0';
        request.fields['hasDocuments'] =
            widget.propertyDoc == 'Yes' ? '1' : '0';
        request.headers['Authorization'] = "$token";

        // List<http.MultipartFile> newList = files.cast<http.MultipartFile>();

        // for (var img in files) {
        //   if (img != null) {
        //     var multipartFile = await http.MultipartFile.fromPath(
        //       'images',
        //       img.path,
        //     );
        //     newList.add(multipartFile);
        //   }
        // }
        // request.files.addAll(newList);
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return HomePageRoot(navigateIndex: 0);
              }));
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
        print(formData);
        print(widget.area);
        print(widget.bathrooom);
        print(widget.bedroom);
        print(widget.charge);
        print(widget.covered);
        print(widget.currency);
        print(widget.electricity);
        print(widget.houseType);
        print(widget.interiorDesign);
        print(widget.kitchen);
        print(widget.livingroom);
        print(widget.location);
        print(widget.negotiable);
        print(widget.propertyAddress);
        // print(widget.rent);
        print(widget.water.toString());
        print(widget.space);
        print(widget.sellerFee);
        // print(widget.rentalFee);
        // print("agency" + widget.agencyFee.toString());
        // print("legal " + widget.legalFee.toString());
        // print("service" + widget.serviceCharge.toString());
        // print("caution" + widget.cautionFee.toString());
      }
    }
  }

  handleSave() async {
    if (_formKey4.currentState!.validate()) {
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
          isSaving = true;
        });
        _formKey4.currentState!.save();

        final prefs = await SharedPreferences.getInstance();

        var token = prefs.getString('token');
        final request =
            http.MultipartRequest('POST', Uri.parse("$baseUrl/listing"));
        request.fields['age_restriction'] = '0';
        request.fields['design_type'] = widget.houseType.toString();
        request.fields['property_address'] = widget.propertyAddress.toString();
        request.fields['bathroom'] = widget.bathrooom.toString();
        request.fields['bedroom'] = widget.bedroom.toString();
        request.fields['living_room'] = widget.livingroom.toString();
        request.fields['currency'] = widget.currency.toString();
        request.fields['kitchen'] = widget.kitchen.toString();
        request.fields['rental_frequency'] = "per year";
        request.fields['rental_fee'] = widget.salesPrice.toString();
        request.fields['other_charges'] =
            widget.charge.toString() == 'Yes' ? '1' : '0';
        request.fields['caution_fee'] = '0';
        request.fields['legal_fee'] = '0';
        request.fields['covered_by_property'] = widget.covered.toString();
        request.fields['agency_fee'] =
            widget.charge == 'Yes' ? '0' : '${widget.sellerFee}'.toString();
        request.fields['state'] = widget.location.toString();
        request.fields['total_area_of_land'] = widget.area.toString();
        request.fields['interior_design'] = 'Furnished';
        request.fields['parking_space'] =
            widget.space.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_water'] =
            widget.water.toString() == 'Yes' ? '1' : '0';

        request.fields['availability_of_electricity'] =
            widget.electricity.toString() == 'Yes' ? '1' : '0';

        request.fields['description'] = widget.description.toString();
        request.fields['property_category'] =
            widget.propertyCategory.toString();
        request.fields['property_type'] = "sale";
        request.fields['status'] = 'Saved';
        request.fields['location'] = widget.location.toString();
        request.fields['negotiable'] =
            widget.negotiable.toString() == 'Yes' ? '1' : '0';
        request.fields['hasDocuments'] =
            widget.propertyDoc == 'Yes' ? '1' : '0';
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
            title: 'Listing Saved',
            desc: "Your listing has been saved successfully",
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
