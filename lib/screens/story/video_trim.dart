// import 'dart:convert';
// import 'dart:io';

// import 'package:findcribs/screens/story/story_list.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import '../../components/constants.dart';
// import '../../controller/get_my_story_controller.dart';
// import 'package:better_player/better_player.dart';

// class VideoTrim extends StatefulWidget {
//   final File file;
//   final String? listingId;

//   const VideoTrim({required this.file, this.listingId});

//   @override
//   _VideoTrimState createState() => _VideoTrimState();
// }

// class _VideoTrimState extends State<VideoTrim> {
//   bool isUploading = false;
//   GetMyStoryController getMyStoryController = Get.put(GetMyStoryController());

//   double _startValue = 0.0;
//   double _endValue = 0.0;

//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//   String caption = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Video Preview"),
//         actions: [
//           ElevatedButton(
//             onPressed: _progressVisibility
//                 ? null
//                 : () async {
//                     handleUploadVideoStory(caption);
//                   },
//             child: Text("Upload"),
//           )
//         ],
//       ),
//       body: Builder(
//         builder: (context) => Center(
//           child: Container(
//             padding: EdgeInsets.only(bottom: 30.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: const LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Expanded(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       BetterPlayer.file(widget.file.path),
//                       Positioned(
//                         child: TextButton(
//                           child: _isPlaying
//                               ? Icon(
//                                   Icons.pause,
//                                   size: 80.0,
//                                   color: Colors.white,
//                                 )
//                               : Icon(
//                                   Icons.play_arrow,
//                                   size: 80.0,
//                                   color: Colors.white,
//                                 ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         caption = value;
//                       });
//                     },
//                     decoration: InputDecoration(hintText: "Type here...."),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   handleUploadVideoStory(String caption) async {
//     setState(() {
//       isUploading = true;
//     });
//     var prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString('token');
//     final request = http.MultipartRequest('POST', Uri.parse("$baseUrl/moment"));
//     request.fields['caption'] = caption;
//     request.fields['listingId'] =
//         widget.listingId == null ? '' : widget.listingId.toString();
//     request.headers['Authorization'] = "$token";
//     final httpImage =
//         await http.MultipartFile.fromPath('media', widget.file.path);
//     request.files.add(httpImage);
//     var response = await request.send();
//     final respStr = await response.stream.bytesToString();
//     final responseData = jsonDecode(respStr);

//     if (responseData['status'] == true) {
//       setState(() {
//         isUploading = false;
//       });
//       Fluttertoast.showToast(msg: "Upload successful");
//       getMyStoryController.handleGetStoryList();
//       Get.off(const StoryList());
//     } else {
//       setState(() {
//         isUploading = false;
//       });
//       // throw Exception(response.statusCode);
//       Fluttertoast.showToast(msg: "something went wrong");
//     }
//   }
// }
