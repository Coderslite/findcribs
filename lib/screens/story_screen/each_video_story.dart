// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';

// class EachVideoStory extends StatefulWidget {
//   final String mediaUrl;
//   const EachVideoStory({Key? key, required this.mediaUrl}) : super(key: key);

//   @override
//   State<EachVideoStory> createState() => _EachVideoStoryState();
// }

// class _EachVideoStoryState extends State<EachVideoStory> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: BetterPlayer.network(
//         widget.mediaUrl,
//         betterPlayerConfiguration: const BetterPlayerConfiguration(
//           autoDispose: true,
//           autoPlay: true,
//           looping: true,
//           aspectRatio: 16 / 9,
//         ),
//       ),
//     );
//   }
// }
