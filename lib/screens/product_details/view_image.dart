// // ignore_for_file: avoid_print

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:progress_indicators/progress_indicators.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class ViewProperty extends StatefulWidget {
//   final List? images;
//   final String businessName;
//   const ViewProperty(
//       {Key? key, required this.images, required this.businessName})
//       : super(key: key);

//   @override
//   State<ViewProperty> createState() => _ViewPropertyState();
// }

// class _ViewPropertyState extends State<ViewProperty>
//     with SingleTickerProviderStateMixin {
//   late PageController _pageController;
//   int activePage = 1;
//   File? image;

//   late TransformationController controller;
//   TapDownDetails? tapDownDetails;

//   late AnimationController animationController;
//   Animation<Matrix4>? animation;
//   @override
//   void initState() {
//     _pageController = PageController(viewportFraction: 1);
//     controller = TransformationController();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     )..addListener(() {
//         controller.value = animation!.value;
//       });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: widget.images!.isEmpty
//                   ? Stack(children: [
//                       PageView.builder(
//                         controller: _pageController,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: 1,
//                         itemBuilder: ((context, index) {
//                           return SizedBox(
//                             width: MediaQuery.of(context).size.width * 2,
//                             height: MediaQuery.of(context).size.height,
//                             child: GestureDetector(
//                               onDoubleTapDown: (details) {
//                                 tapDownDetails = details;
//                                 print("double tapped");
//                               },
//                               onDoubleTap: () {
//                                 print("double tapped");

//                                 final position = tapDownDetails!.localPosition;
//                                 double scale = 3;
//                                 final x = -position.dx * (scale - 1);
//                                 final y = -position.dy * (scale - 1);
//                                 final zoomed = Matrix4.identity()
//                                   ..translate(x, y)
//                                   ..scale(scale);
//                                 final value = controller.value.isIdentity()
//                                     ? zoomed
//                                     : Matrix4.identity();
//                                 controller.value = value;
//                               },
//                               child: InteractiveViewer(
//                                 panEnabled: false,
//                                 clipBehavior: Clip.none,
//                                 scaleEnabled: false,
//                                 transformationController: controller,
//                                 child: AspectRatio(
//                                   aspectRatio: 1,
//                                   child: Stack(
//                                     children: [
//                                       CachedNetworkImage(
//                                         imageUrl:
//                                             "http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG",
//                                         fit: BoxFit.cover,
//                                         width: 1000,
//                                         height: double.infinity,
//                                         progressIndicatorBuilder:
//                                             (context, url, downloadProgress) =>
//                                                 JumpingDotsProgressIndicator(
//                                           fontSize: 20.0,
//                                           color: Colors.blue,
//                                         ),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(Icons.error),
//                                       ),
//                                       Positioned(
//                                         bottom:
//                                             MediaQuery.of(context).size.height /
//                                                 2.6,
//                                         // top: MediaQuery.of(context).size.height / 0.1,
//                                         left:
//                                             MediaQuery.of(context).size.width /
//                                                 7,
//                                         right:
//                                             MediaQuery.of(context).size.width /
//                                                 7,
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               widget.businessName,
//                                               style: const TextStyle(
//                                                 color: Colors.white24,
//                                                 fontSize: 24,
//                                               ),
//                                             ),
//                                             const Text(
//                                               "posted on Findcribs.ng",
//                                               style: TextStyle(
//                                                 color: Colors.white24,
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                       Positioned(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 35.0, left: 20),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                     color: const Color(0XFFF0F7F8),
//                                     borderRadius: BorderRadius.circular(13)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: SvgPicture.asset(
//                                       "assets/svgs/arrow_back.svg"),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ])
//                   : Stack(
//                       children: [
//                         PageView.builder(
//                           controller: _pageController,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: widget.images!.length,
//                           itemBuilder: ((context, index) {
//                             return SizedBox(
//                               width: MediaQuery.of(context).size.width * 2,
//                               height: MediaQuery.of(context).size.height,
//                               child: InteractiveViewer(
//                                 panEnabled: false,
//                                 clipBehavior: Clip.none,
//                                 scaleEnabled: true,
//                                 transformationController: controller,
//                                 child: GestureDetector(
//                                   onDoubleTapDown: (details) {
//                                     tapDownDetails = details;
//                                   },
//                                   onDoubleTap: () {
//                                     print("double tapped");

//                                     final position =
//                                         tapDownDetails!.localPosition;
//                                     double scale = 3;
//                                     final x = -position.dx * (scale - 1);
//                                     final y = -position.dy * (scale - 1);
//                                     final zoomed = Matrix4.identity()
//                                       ..translate(x, y)
//                                       ..scale(scale);
//                                     final end = controller.value.isIdentity()
//                                         ? zoomed
//                                         : Matrix4.identity();
//                                     // controller.value = value;
//                                     animation = Matrix4Tween(
//                                             begin: controller.value, end: end)
//                                         .animate(
//                                             CurveTween(curve: Curves.easeOut)
//                                                 .animate(animationController));
//                                     animationController.forward(from: 0);
//                                   },
//                                   child: AspectRatio(
//                                     aspectRatio: 1,
//                                     child: Stack(
//                                       children: [
//                                         CachedNetworkImage(
//                                           imageUrl: widget.images![index]
//                                               ['url'],
//                                           fit: BoxFit.cover,
//                                           width: 1000,
//                                           height: double.infinity,
//                                           progressIndicatorBuilder: (context,
//                                                   url, downloadProgress) =>
//                                               JumpingDotsProgressIndicator(
//                                             fontSize: 20.0,
//                                             color: Colors.blue,
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.error),
//                                         ),
//                                         Positioned(
//                                           bottom: MediaQuery.of(context)
//                                                   .size
//                                                   .height /
//                                               2.6,
//                                           // top: MediaQuery.of(context).size.height / 0.1,
//                                           left: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               7,
//                                           right: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               7,
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 widget.businessName,
//                                                 style: const TextStyle(
//                                                   color: Colors.white54,
//                                                   fontSize: 25,
//                                                 ),
//                                               ),
//                                               const Text(
//                                                 "posted on Findcribs.ng",
//                                                 style: TextStyle(
//                                                   color: Colors.white54,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                         Positioned(
//                           bottom: 60,
//                           width: MediaQuery.of(context).size.width,
//                           // left: MediaQuery.of(context).size.width / 2,
//                           // right: MediaQuery.of(context).size.width / 3.5,
//                           // right: 50,
//                           child: Center(
//                             child: SmoothPageIndicator(
//                               controller: _pageController,
//                               count: widget.images!.isEmpty
//                                   ? 1
//                                   : widget.images!.length,
//                               effect: const ExpandingDotsEffect(
//                                 spacing: 13,
//                                 expansionFactor: (19 / 8),
//                                 radius: 20,
//                                 activeDotColor: Colors.white,
//                                 dotColor: Color(0xFFDADADA),
//                                 dotHeight: 8,
//                                 dotWidth: 8,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 35.0, left: 20),
//                             child: Align(
//                               alignment: Alignment.topLeft,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                       color: const Color(0XFFF0F7F8),
//                                       borderRadius: BorderRadius.circular(13)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: SvgPicture.asset(
//                                         "assets/svgs/arrow_back.svg"),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   handleWaterMark(int index) {
//     ui.Image? originalImage =
//         ui.decodeImage(File(widget.images![index]['url']).readAsBytesSync());
//     ui.Image? watermarkImage =
//         ui.decodeImage(File(widget.images![index]['url']).readAsBytesSync());

//     // add watermark over originalImage
//     // initialize width and height of watermark image
//     ui.Image image = ui.Image(160, 50);
//     ui.drawImage(image, watermarkImage!);

//     // give position to watermark over image
//     // originalImage.width - 160 - 25 (width of originalImage - width of watermarkImage - extra margin you want to give)
//     // originalImage.height - 50 - 25 (height of originalImage - height of watermarkImage - extra margin you want to give)
//     ui.copyInto(originalImage!, image,
//         dstX: originalImage.width - 160 - 25,
//         dstY: originalImage.height - 50 - 25);

//     // for adding text over image
//     // Draw some text using 24pt arial font
//     // 100 is position from x-axis, 120 is position from y-axis
//     ui.drawString(originalImage, ui.arial_24, 100, 120, 'Think Different');

//     // Store the watermarked image to a File
//     List<int> wmImage = ui.encodePng(originalImage);
//     setState(() {
//       image = File.fromRawPath(Uint8List.fromList(wmImage)) as ui.Image;
//     });
//   }
// }
// //   createStamp(index) {
// //     // File file = widget.images![index]['url'];
// //     return StampImage.create(
// //       children: [
// //         Positioned(bottom: 0, right: 0, child: _watermarkItem()),
// //         Positioned(
// //           top: 20,
// //           left: 20,
// //           child: Text("datanmnsdmnmsnfmdngmdnfmdnmdnm"),
// //         )
// //       ],
// //       context: context,
// //       image: File(widget.images![index]['url'].toString()),
// //       onSuccess: (result) {
// //         setState(() {
// //           // file = result;
// //         });
// //       },
// //     );
// //   }
// // }

// // Widget _watermarkItem() {
// //   return Padding(
// //     padding: const EdgeInsets.all(10),
// //     child: Column(
// //       crossAxisAlignment: CrossAxisAlignment.end,
// //       children: [
// //         Text(
// //           DateTime.now().toString(),
// //           style: TextStyle(color: Colors.white, fontSize: 15),
// //         ),
// //         SizedBox(height: 5),
// //         Text(
// //           "Made By Stamp Image",
// //           maxLines: 2,
// //           overflow: TextOverflow.ellipsis,
// //           style: TextStyle(
// //             color: Colors.blue,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 15,
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
