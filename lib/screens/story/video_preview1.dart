// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_editor/video_editor.dart';

// class VideoPreview1 extends StatefulWidget {
//   final File file;
//   const VideoPreview1({Key? key, required this.file}) : super(key: key);

//   @override
//   State<VideoPreview1> createState() => _VideoPreview1State();
// }

// class _VideoPreview1State extends State<VideoPreview1> {
//   late VideoEditorController _controller;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     _controller = VideoEditorController.file(widget.file,
//         maxDuration: const Duration(seconds: 60))
//       ..initialize(aspectRatio: 9 / 16).then((_) => setState(() {}));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 CropGridViewer(
//                   controller: _controller,
//                   showGrid: false,
//                 ),
//                 AnimatedBuilder(
//                   animation: _controller.video,
//                   builder: (_, __) => GestureDetector(
//                     onTap: () {
//                       if (isPlaying) {
//                         setState(() {
//                           isPlaying = !isPlaying;
//                           _controller.video.pause();
//                         });
//                       } else {
//                         setState(() {
//                           isPlaying = !isPlaying;
//                           _controller.video.play();
//                         });
//                       }
//                     },
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
//                           color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
