// import 'dart:convert';
// import 'dart:io';
// import 'package:findcribs/screens/story/story_list.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// import '../../components/constants.dart';
// import 'package:http/http.dart' as http;

// class VideoTrim extends StatefulWidget {
//   final File file;
//   final String? listingId;
//   const VideoTrim({Key? key, required this.file, this.listingId})
//       : super(key: key);

//   @override
//   State<VideoTrim> createState() => _VideoTrimState();
// }

// class _VideoTrimState extends State<VideoTrim> {
//   final Trimmer _trimmer = Trimmer();
//   double _startValue = 0;
//   double _endValue = 0;
//   bool isUploading = false;
//   bool isPlaying = false;
//   var textController = TextEditingController();
//   bool _progressVisibility = false;
//   // late File _value;
//   handleLoadVideo() async {
//     await _trimmer.loadVideo(videoFile: widget.file);
//   }

//   Directory dir = Directory('/storage/emulated/0/Download/output.mp4');
//   // handleFfmpeg() async {
//   //   var arguments = [
//   //     "-i",
//   //     {widget.file.path}.toString(),
//   //     "-c:v",
//   //     "mpeg4",
//   //     dir.toString()
//   //   ];
//   //   _flutterFFmpeg
//   //       .executeWithArguments(arguments)
//   //       .then((rc) => print("FFmpeg process exited with rc $rc"));
//   // }

//   Future<String?> saveVideo() async {

//     setState(() {
//       _progressVisibility = true;
//     });

//     String? _value;

//     _trimmer.saveTrimmedVideo(
//       startValue: _startValue,
//       endValue: _endValue,
//       onSave: (String? outputPath) {
//         handleUploadImageStory(
//             textController.text, File(outputPath.toString()));
//       },
//     );

//     return _value;
//   }

//   handleUploadImageStory(String caption, File videoFile) async {
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
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
//         return const StoryList();
//       }));
//     } else {
//       setState(() {
//         isUploading = false;
//       });
//       // throw Exception(response.statusCode);
//       Fluttertoast.showToast(msg: "something went wrong");
//     }
//   }

//   @override
//   void initState() {
//     handleLoadVideo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: isUploading
//           ? Center(
//               child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircularProgressIndicator(),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text("Uploading Story"),
//               ],
//             ))
//           : Stack(
//               alignment: Alignment.center,
//               children: [
//                 VideoViewer(
//                   trimmer: _trimmer,
//                 ),
//                 Positioned(
//                   top: 0,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TrimEditor(
//                             trimmer: _trimmer,
//                             viewerHeight: 50,
//                             viewerWidth:
//                                 MediaQuery.of(context).size.width / 1.1,
//                             maxVideoLength: const Duration(seconds: 60),
//                             onChangeStart: (value) {
//                               setState(() {
//                                 _startValue = value;
//                               });
//                             },
//                             onChangeEnd: (value) {
//                               setState(() {
//                                 _endValue = value;
//                               });
//                             },
//                             onChangePlaybackState: (value) {
//                               setState(() {
//                                 isPlaying = value;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                         width: MediaQuery.of(context).size.width / 1.1,
//                         child: Visibility(
//                           visible: _progressVisibility,
//                           child: const LinearProgressIndicator(
//                             backgroundColor: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       bool playbackState = await _trimmer.videPlaybackControl(
//                         startValue: _startValue,
//                         endValue: _endValue,
//                       );
//                       setState(() {
//                         isPlaying = playbackState;
//                       });
//                     },
//                     child: isPlaying
//                         ? const Icon(
//                             Icons.pause,
//                             size: 80,
//                             color: Colors.white,
//                           )
//                         : const Icon(
//                             Icons.play_arrow,
//                             size: 80,
//                             color: Colors.white,
//                           )),
//                 Positioned(
//                   bottom: 20,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width / 1.2,
//                           child: TextField(
//                             controller: textController,
//                             decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(7),
//                                 )),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             // handleFfmpeg();
//                             saveVideo();
//                             // saveVideo().then((outputPath) {
//                             //   print('OUTPUT PATH: $outputPath');
//                             //   final snackBar =
//                             //       SnackBar(content: Text('Video Saved successfully'));
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     snackBar,
//                             //   );
//                             // });
//                           },
//                           child: const CircleAvatar(
//                             child: Icon(
//                               Icons.send,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//     ));
//   }
// }
