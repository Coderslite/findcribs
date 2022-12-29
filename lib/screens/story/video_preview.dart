// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPreview extends StatefulWidget {
//   final File video;
//   const VideoPreview({Key? key, required this.video}) : super(key: key);

//   @override
//   State<VideoPreview> createState() => _VideoPreviewState();
// }

// class _VideoPreviewState extends State<VideoPreview> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     _controller = VideoPlayerController.file(
//       widget.video,
//       videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
//     );

//     _initializeVideoPlayerFuture = _controller.initialize();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SizedBox(
//         height: size.height,
//         child: FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If the VideoPlayerController has finished initialization, use
//                 // the data it provides to limit the aspect ratio of the video.
//                 return AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: <Widget>[
//                       VideoPlayer(_controller),
//                       ClosedCaption(text: _controller.value.caption.text),
//                       VideoProgressIndicator(_controller, allowScrubbing: true),
//                       Positioned(
//                         // bottom: 150,
//                         child: Container(
//                             padding: const EdgeInsets.all(20),
//                             width: 80,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Colors.white,
//                                 )),
//                             child: GestureDetector(
//                               onTap: () {
//                                 isPlaying
//                                     ? _controller.pause()
//                                     : _controller.play();
//                                 setState(() {
//                                   isPlaying = !isPlaying;
//                                 });
//                               },
//                               child: Center(
//                                   child: isPlaying
//                                       ? const Icon(
//                                           Icons.pause,
//                                           color: Colors.white,
//                                         )
//                                       : const Icon(
//                                           Icons.play_arrow,
//                                           color: Colors.white,
//                                         )),
//                             )),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 // If the VideoPlayerController is still initializing, show a
//                 // loading spinner.
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }
