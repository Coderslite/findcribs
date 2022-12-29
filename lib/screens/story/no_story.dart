// import 'package:findcribs/screens/story/story_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';

// class NoStoryScreen extends StatefulWidget {
//   const NoStoryScreen({Key? key}) : super(key: key);

//   @override
//   State<NoStoryScreen> createState() => _NoStoryScreenState();
// }

// class _NoStoryScreenState extends State<NoStoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 20.0,
//                 left: 20,
//                 right: 20,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(13),
//                         color: const Color(0XFFF0F7F8),
//                       ),
//                       child: SvgPicture.asset(
//                         "assets/svgs/arrow_back.svg",
//                       ),
//                     ),
//                   ),
//                   const Text(
//                     "Story",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const Text(""),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Image.asset("assets/images/opps.png"),
//                     const Text(
//                       "Opps!",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     const Text("You have not posted"),
//                     const Text("any story yet"),
//                     // Material(
//                     //   child: MaterialButton(
//                     //     onPressed: () {},
//                     //     child: Text("Post a story"),
//                     //   ),
//                     // )
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) {
//                           return const StoryList();
//                         }));
//                         // handleVideo();
//                       },
//                       child: const Text("Post a story"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row()
//           ],
//         ),
//       ),
//     );
//   }

//   // handleVideo() {
//   //   ImagePicker.platform.getVideo(source: ImageSource.camera);
//   // }
// }
