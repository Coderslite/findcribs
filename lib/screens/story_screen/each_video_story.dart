// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class EachVideoStory extends StatefulWidget {
//   final String mediaUrl;
//   const EachVideoStory({Key? key, required this.mediaUrl}) : super(key: key);

//   @override
//   State<EachVideoStory> createState() => _EachVideoStoryState();
// }

// class _EachVideoStoryState extends State<EachVideoStory> {
//   late VideoPlayerController controller;
//   bool isPlaying = true;
//   bool isLoading = true;

//   @override
//   void initState() {
//     controller = VideoPlayerController.network(
//       widget.mediaUrl.toString(),
//       videoPlayerOptions: VideoPlayerOptions(
//         allowBackgroundPlayback: false,
//       ),
//     )..initialize().then((_) {
//         controller.play();

//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {
//           isLoading = false;
//         });
//       });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: <Widget>[
//           VideoPlayer(controller),
//           // ClosedCaption(
//           //     text: _controller.value.caption.text),
//           // VideoProgressIndicator(_controller,
//           //     allowScrubbing: true),
//           Positioned(
//             // bottom: 150,
//             child: isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Container(
//                     padding: const EdgeInsets.all(20),
//                     width: 80,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white,
//                         )),
//                     child: GestureDetector(
//                       onTap: () {
//                         isPlaying ? controller.pause() : controller.play();
//                         setState(() {
//                           isPlaying = !isPlaying;
//                         });
//                       },
//                       child: Center(
//                           child: isPlaying
//                               ? const Icon(
//                                   Icons.pause,
//                                   color: Colors.white,
//                                 )
//                               : const Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.white,
//                                 )),
//                     )),
//           ),
        
        
//         ],
//       ),
//     );
//   }
// }
