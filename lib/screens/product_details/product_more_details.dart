// ignore_for_file: library_prefixes, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/models/house_detail_model.dart';
import 'package:findcribs/screens/product_details/photo_view_preview.dart';
import 'package:findcribs/service/property_details_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart' as launchUrl;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../controller/get_chat_controller.dart';
import '../../util/social_login.dart';
import '../agent_profile/agent_profile.dart';

class ProductMoreDetails extends StatefulWidget {
  final int? id;
  const ProductMoreDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductMoreDetails> createState() => _ProductMoreDetailsState();
}

class _ProductMoreDetailsState extends State<ProductMoreDetails> {
  // late VideoPlayerController _controller;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  late Future<HouseDetailModel> singleProperty;
  bool isPlaying = false;
  var messageController = TextEditingController();
  String message = '';
  late Socket socket;
  List? facilities;

  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    socket = IO.io(
        'http://18.233.168.44:5000/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': "$token"}) // optional
            .build());
    socket.connect();
    socket.onConnect((data) {
      print("connected");
    });
    socket.onDisconnect((data) => print("disconnected"));
    socket.on(
      "ERROR",
      (data) {
        var errorMessage = jsonDecode(data);
        print("Error" + errorMessage['message']);
        print(data);
      },
    );

    socket.on("MESSAGE_SENT", (data) {
      print("message sent successfully");
    });
  }

  @override
  void initState() {
    super.initState();
    handleConnect();
    handleGetProperty();
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    // )..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  handleGetProperty() {
    singleProperty = getSingleProperty(widget.id);
    singleProperty.then((value) {
      setState(() {
        facilities = jsonDecode(value.facilities.toString());

        print(facilities);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  GetAllChatController getAllChatController = Get.put(GetAllChatController());

  handleSendMessage(String chatMessage, int? receiverId, int? propertyId,
      bool managedBy) async {
    getAllChatController.handleGetMessage();

    // print(widget.receiverId);
    // var prefs = await SharedPreferences.getInstance();
    // var adminId = prefs.getString("adminId");

    var messageMap = {
      "clientMesgId": UniqueKey().toString(),
      "mesgType": "text",
      "receiverId": receiverId,
      "message": chatMessage,
      "propertyId": propertyId,
      "sentAt": DateTime(2022).toString(),
    };
    print(messageMap);
    socket.emit('MESSAGE', messageMap);
    messageController.clear();
    setState(() {
      message = '';
    });
    Fluttertoast.showToast(msg: "Message Sent");
  }

  @override
  Widget build(BuildContext context) {
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<HouseDetailModel>(
          future: singleProperty,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // Navigator.pu
              Fluttertoast.showToast(msg: 'Property not available');
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/opps.png"),
                  const Text(
                    "Opps!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Property No longer Available"),
                ],
              );
            }
            if (snapshot.hasData) {
              var property = snapshot.data!;
              int salesPrice = property.rentalFee!.toInt();
              int totalprice = (property.rentalFee!.toInt() +
                  (property.cautionFee)!.toInt() +
                  (property.serviceCharge)!.toInt() +
                  ((salesPrice * property.legalFee!) ~/ 100) +
                  ((salesPrice * property.agencyFee!) ~/ 100));
              var formatter = NumberFormat("#,###");
              var formatedPrice = formatter.format(totalprice);
              var formatedSalesPrice = formatter.format(salesPrice);

              return Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                            color: const Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return AgentProfileScreen(
                                id: property.agentId,
                                propertyId: property.id,
                              );
                            }));
                          },
                          child: Row(
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                    imageUrl: property.profilePic.toString(),
                                    progressIndicatorBuilder:
                                        ((context, url, progress) {
                                      return JumpingDotsProgressIndicator();
                                    })),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: mobileWidth / 3,
                                    child: Text(
                                      property.agentBusinessName.toString(),
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    property.agentCategory.toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF8A99B1),
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'RedHatDisplay',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token');
                                token == null
                                    ? showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const SocialLogin();
                                        })
                                    : showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 90,
                                            // color: Colors.amber,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF0072BA),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.call,
                                                      size: 13,
                                                      color: Color(0xFF0072BA),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        var phone = property
                                                            .agentPhoneNUmber
                                                            .toString();
                                                        launchUrl.launch(
                                                            "tel:$phone");
                                                      },
                                                      child: Text(
                                                        "Call ${property.agentBusinessName}",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'RedHatDisplay',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF0072BA)),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 130,
                                                      height: 2,
                                                      color: const Color(
                                                          0xFF0072BA),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                          );
                                        },
                                      );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF0072BA),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.call,
                                    size: 13,
                                    color: Color(0xFF0072BA),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token');
                                token == null
                                    ? showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const SocialLogin();
                                        })
                                    : showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return AnimatedPadding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.decelerate,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 200,
                                              padding: const EdgeInsets.all(10),
                                              child: Wrap(
                                                children: <Widget>[
                                                  SizedBox(
                                                    // height: 20,
                                                    child: TextFormField(
                                                        controller:
                                                            messageController,
                                                        onChanged: (value) {
                                                          message = value;
                                                        },
                                                        onFieldSubmitted:
                                                            (value) {
                                                          handleSendMessage(
                                                              messageController
                                                                  .text,
                                                              property.agentId,
                                                              property.id,
                                                              property
                                                                  .managedBy!);
                                                        },
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              "Send Message to Seller",
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        handleSendMessage(
                                                            messageController
                                                                .text,
                                                            property.agentId,
                                                            property.id,
                                                            property
                                                                .managedBy!);
                                                      },
                                                      child: const Text(
                                                          "Send Message")),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF0072BA),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child:
                                      SvgPicture.asset("assets/svgs/chat.svg"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token');
                                token == null
                                    ? showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const SocialLogin();
                                        })
                                    : AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.info,
                                        borderSide: const BorderSide(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                        width: 280,
                                        buttonsBorderRadius:
                                            const BorderRadius.all(
                                          Radius.circular(2),
                                        ),
                                        dismissOnTouchOutside: true,
                                        dismissOnBackKeyPress: false,
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        title: 'Book Availability',
                                        desc: property.availability.toString(),
                                        showCloseIcon: true,
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {},
                                      ).show();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5.33,
                                height: MediaQuery.of(context).size.height / 21,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: const Color(0xFF0072BA),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "Book Tour",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            property.propertyCategory == 'Estate Market'
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svgs/bedroom.svg"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${property.bedroom} Bedroom",
                                            style: const TextStyle(
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svgs/bathroom.svg"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${property.bathroom} Bathroom",
                                            style: const TextStyle(
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/living_room.png"),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${property.livingRoom} Living Room",
                                            style: const TextStyle(
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/kitchen.png"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${property.kitchen} Kitchen",
                                            style: const TextStyle(
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                            property.propertyCategory == 'Estate Market'
                                ? Container()
                                : const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        const Icon(Icons.location_on_outlined),
                                        const SizedBox(width: 10),
                                        Text(
                                          property.propertyAddress.toString(),
                                          style: const TextStyle(
                                              color: Color(0XFF8A99B1),
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ]),
                                      property.propertyCategory ==
                                              'Estate Market'
                                          ? const Text("")
                                          : Text(
                                              property.interiorDesign
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Color(0XFF8A99B1),
                                                  fontFamily: 'RedHatDisplay',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                    ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    property.propertyType == 'sale'
                                        ? const Text(
                                            "Sales Price",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'RedHatDisplay',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          )
                                        : Text(
                                            "Rent fee /${property.rentalFrequncy}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'RedHatDisplay',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0XFF8A99B1),
                                            ),
                                          ),
                                    // SizedBox(width: 10,),
                                    Text(
                                      property.currency == 'Naira'
                                          ? "NGN".toString() +
                                              formatedSalesPrice
                                          : "\$$formatedSalesPrice",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w900,
                                        color: Color(0XFF09172D),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: const Text(
                                        "Description",
                                        style: TextStyle(
                                            fontFamily: 'RedHatDisplay',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Text(
                                          property.description.toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF8A99B1),
                                              fontFamily: 'RedHatDisplay',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      property.images!.isEmpty
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  6,
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(20),
                                              //     image: const DecorationImage(
                                              //         image: NetworkImage(
                                              //             'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'))),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG',
                                                fit: BoxFit.cover,
                                                width: 1200,
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    JumpingDotsProgressIndicator(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (int x = 0;
                                                    x < property.images!.length;
                                                    x++)
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(
                                                    //             20),
                                                    //     image: DecorationImage(
                                                    //         image: NetworkImage(
                                                    //             property.images![
                                                    //                 x]['url']))),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return PhotoPreview(
                                                            images:
                                                                property.images,
                                                            businessName: property
                                                                .agentBusinessName
                                                                .toString(),
                                                          );
                                                          // return ViewProperty(
                                                          //   images:
                                                          //       property.images,
                                                          //   businessName: property
                                                          //       .agentBusinessName
                                                          //       .toString(),
                                                          // );
                                                        }));
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl: property
                                                            .images![x]['url'],
                                                        fit: BoxFit.cover,
                                                        width: 1000,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                JumpingDotsProgressIndicator(
                                                          fontSize: 20.0,
                                                          color: Colors.blue,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                property.propertyCondition == null
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Property Condition",
                                            style: TextStyle(
                                                color: Color(0xFF8A99B1),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            property.propertyCondition
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                property.propertyCategory == 'Estate Market'
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "House design type",
                                            style: TextStyle(
                                                color: Color(0xFF8A99B1),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            property.designType.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            property.propertyCategory != 'Estate Market'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            property.propertyType!
                                                        .toLowerCase() ==
                                                    'rent'
                                                ? "Agent Fee"
                                                : "Sellers Comm.",
                                            style: const TextStyle(
                                                color: Color(0xFF8A99B1),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "${property.agencyFee}%",
                                            style: const TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      property.propertyType!.toLowerCase() ==
                                              'rent'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Caution Fee",
                                                  style: TextStyle(
                                                      color: Color(0xFF8A99B1),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  property.cautionFee
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Total land sqm.",
                                                  style: TextStyle(
                                                      color: Color(0xFF8A99B1),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  property.totalAreaOfLand
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                      property.propertyType!.toLowerCase() ==
                                              'rent'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Service Charge",
                                                  style: TextStyle(
                                                      color: Color(0xFF8A99B1),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  property.serviceCharge
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Covered by prop",
                                                  style: TextStyle(
                                                      color: Color(0xFF8A99B1),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  property.coveredByProperty
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                      property.propertyType!.toLowerCase() ==
                                              'rent'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Legal Fee",
                                                  style: TextStyle(
                                                      color: Color(0xFF8A99B1),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  "${property.legalFee}%",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Total Price",
                                      style: TextStyle(
                                          color: Color(0xFF8A99B1),
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property.currency == 'Naira'
                                          ? 'NGN$formatedPrice'
                                          : '\$$formatedPrice',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w900,
                                        color: Color(0XFF09172D),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color(0xFF455A64),
                                          radius: 4,
                                        ),
                                        const SizedBox(width: 5),
                                        property.negotiable == true
                                            ? const Text(
                                                "Negotiable",
                                                style: TextStyle(
                                                    color: Color(0xFF8A99B1),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            : const Text("Non-negotiable"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            property.propertyCategory != 'Estate Market'
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Availability of running water",
                                                style: TextStyle(
                                                    color: Color(0xFF8A99B1),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                property.availabilityOfWater ==
                                                        false
                                                    ? 'No'
                                                    : 'Yes',
                                                style: const TextStyle(
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Availability of electricity",
                                                style: TextStyle(
                                                    color: Color(0xFF8A99B1),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                property.availabilityOfElectricity ==
                                                        false
                                                    ? 'No'
                                                    : 'Yes',
                                                style: const TextStyle(
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Parking space",
                                                style: TextStyle(
                                                    color: Color(0xFF8A99B1),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                property.parkingSpace == false
                                                    ? 'No'
                                                    : 'Yes',
                                                style: const TextStyle(
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          property.propertyType!
                                                      .toLowerCase() ==
                                                  'rent'
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Age Restriction to rent?",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF8A99B1),
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      property.ageRestriction ==
                                                              true
                                                          ? "Yes"
                                                          : "No",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Property doc available ? ",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF8A99B1),
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      property.hasDocument ==
                                                              true
                                                          ? "Yes"
                                                          : "No",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Facilities in Area",
                                  style: TextStyle(
                                      fontFamily: 'RedHatDisplay',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int x = 0; x < facilities!.length; x++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Image.network(
                                              "https://res.cloudinary.com/dae0rudcd/image/upload/v1671193468/features/${facilities![x]}.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            "${facilities![x]}",
                                            style: const TextStyle(
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  // Column(
                                  //   children: [
                                  //     Image.asset("assets/images/school.png"),
                                  //     const Text(
                                  //       "School",
                                  //       style: TextStyle(
                                  //           fontFamily: 'RedHatDisplay',
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w700),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Image.asset("assets/images/spar.png"),
                                  //     const Text(
                                  //       "Spar",
                                  //       style: TextStyle(
                                  //           fontFamily: 'RedHatDisplay',
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w700),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Image.asset("assets/images/resturant.png"),
                                  //     const Text(
                                  //       "Resturant",
                                  //       style: TextStyle(
                                  //           fontFamily: 'RedHatDisplay',
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w700),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     Image.asset("assets/images/gym.png"),
                                  //     const Text(
                                  //       "Gym",
                                  //       style: TextStyle(
                                  //           fontFamily: 'RedHatDisplay',
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w700),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //       _controller.value.isPlaying
                            //           ? _controller.pause()
                            //           : _controller.play();
                            //     });
                            //   },
                            //   child: AspectRatio(
                            //     aspectRatio: _controller.value.aspectRatio,
                            //     child: Stack(
                            //       alignment: Alignment.bottomCenter,
                            //       children: <Widget>[
                            //         VideoPlayer(_controller),
                            //         // ClosedCaption(
                            //         //     text: _controller.value.caption.text),
                            //         // VideoProgressIndicator(_controller,
                            //         //     allowScrubbing: true),
                            //         Positioned(
                            //           // bottom: 150,
                            //           child: Container(
                            //               padding: const EdgeInsets.all(20),
                            //               width: 80,
                            //               decoration: BoxDecoration(
                            //                   shape: BoxShape.circle,
                            //                   border: Border.all(
                            //                     color: Colors.white,
                            //                   )),
                            //               child: GestureDetector(
                            //                 onTap: () {
                            //                   isPlaying
                            //                       ? _controller.pause()
                            //                       : _controller.play();
                            //                   setState(() {
                            //                     isPlaying = !isPlaying;
                            //                   });
                            //                 },
                            //                 child: Center(
                            //                     child: isPlaying
                            //                         ? const Icon(
                            //                             Icons.pause,
                            //                             color: Colors.white,
                            //                           )
                            //                         : const Icon(
                            //                             Icons.play_arrow,
                            //                             color: Colors.white,
                            //                           )),
                            //               )),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.99,
                              child: ElevatedButton(
                                  // Connect EndPoint
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    token == null
                                        ? showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const SocialLogin();
                                            })
                                        : AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.info,
                                            borderSide: const BorderSide(
                                              color: Colors.yellow,
                                              width: 2,
                                            ),
                                            width: 280,
                                            buttonsBorderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(2),
                                            ),
                                            dismissOnTouchOutside: true,
                                            dismissOnBackKeyPress: false,
                                            headerAnimationLoop: false,
                                            animType: AnimType.bottomSlide,
                                            title: 'Book Availability',
                                            desc: property.availability
                                                .toString(),
                                            showCloseIcon: true,
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {},
                                          ).show();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(500, 60),
                                    primary: const Color(0xFF0072BA),
                                  ),
                                  child: const Text(
                                    'Book Tour',
                                    style: TextStyle(
                                        fontFamily: 'RedHatDisplay',
                                        fontSize: 20),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
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
    );
  }
}
