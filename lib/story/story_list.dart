// import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
// import 'package:findcribs/screens/story/story_camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:just_the_tooltip/just_the_tooltip.dart';

// class ItemModel {
//   String title;
//   IconData icon;

//   ItemModel(this.title, this.icon);
// }

// class StoryList extends StatefulWidget {
//   const StoryList({Key? key}) : super(key: key);

//   @override
//   State<StoryList> createState() => _StoryListState();
// }

// class _StoryListState extends State<StoryList> {
//   late List<ItemModel> menuItems;
//   final CustomPopupMenuController _controller = CustomPopupMenuController();
//   final tooltipController = JustTheController();
//   bool isStandalone = false;
//   bool isShowing = false;

//   var image = [
//     "assets/images/story1.png",
//     "assets/images/story2.png",
//     "assets/images/story3.png",
//     "assets/images/story1.png",
//     "assets/images/story5.png",
//     "assets/images/story6.png",
//     "assets/images/story7.png",
//     "assets/images/story1.png",
//     "assets/images/story3.png",
//     "assets/images/story5.png",
//   ];
//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     menuItems = [
//       ItemModel('Delete', Icons.delete),
//     ];
//     super.initState();
//   }

//   @override
//   void dispose() {
//     tooltipController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: JustTheTooltip(
//           controller: tooltipController,
//           preferredDirection: AxisDirection.left,
//           isModal: true,
//           barrierDismissible: false,
//           content: Container(
//               height: 90,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: !isStandalone
//                         ? InkWell(
//                             onTap: () {
//                               setState(() {
//                                 isStandalone = !isStandalone;
//                                 tooltipController.hideTooltip().then(
//                                     (value) => tooltipController.showTooltip());
//                               });
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 const Text("Standard Alone"),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Container(
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: const Color(0XFF0072BA),
//                                         width: 2,
//                                       )),
//                                   child: const Icon(
//                                     Icons.play_arrow,
//                                     color: Color(0XFF0072BA),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : InkWell(
//                             onTap: () {
//                               setState(() {
//                                 isShowing = false;
//                                 tooltipController.hideTooltip();
//                                 isStandalone = false;
//                               });
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (_) {
//                                 return const StoryCamera();
//                               }));
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 const Text("Camera"),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Container(
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: const Color(0XFF0072BA),
//                                         width: 2,
//                                       )),
//                                   child: const Icon(
//                                     Icons.camera_rear_outlined,
//                                     color: Color(0XFF0072BA),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: !isStandalone
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               const Text("Attach to property"),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Image.asset("assets/images/list_property.png"),
//                             ],
//                           )
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               const Text("Gallery"),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Container(
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: const Color(0XFF0072BA),
//                                       width: 2,
//                                     )),
//                                 child: const Icon(
//                                   Icons.photo_album_outlined,
//                                   color: Color(0XFF0072BA),
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ),
//                 ],
//               )),
//           backgroundColor: const Color(0xFFE5E5E5),
//           child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isShowing
//                       ? tooltipController.hideTooltip()
//                       : tooltipController.showTooltip();

//                   isStandalone = false;
//                   isShowing = !isShowing;
//                 });
//               },
//               child: const CircleAvatar(
//                   radius: 35,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.add,
//                     ),
//                   ))),
//         ),
//       ),
//       body: SafeArea(
//           child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20.0,
//               left: 20,
//               right: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(13),
//                       color: const Color(0XFFF0F7F8),
//                     ),
//                     child: SvgPicture.asset(
//                       "assets/svgs/arrow_back.svg",
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   "Story",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 CustomPopupMenu(
//                   child: Container(
//                     child: Image.asset("assets/images/vertical_line.png"),
//                     padding: const EdgeInsets.all(20),
//                   ),
//                   menuBuilder: () => ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Container(
//                       color: const Color(0xFFE5E5E5),
//                       child: IntrinsicWidth(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: menuItems
//                               .map(
//                                 (item) => GestureDetector(
//                                   behavior: HitTestBehavior.translucent,
//                                   onTap: () {
//                                     // print("onTap");
//                                     _controller.hideMenu();
//                                   },
//                                   child: Container(
//                                     height: 40,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: Row(
//                                       children: <Widget>[
//                                         Icon(
//                                           item.icon,
//                                           size: 15,
//                                           color: const Color(0XFFC62E3D),
//                                         ),
//                                         Expanded(
//                                           child: Container(
//                                             margin:
//                                                 const EdgeInsets.only(left: 10),
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 10),
//                                             child: Text(
//                                               item.title,
//                                               style: const TextStyle(
//                                                 color: Color(0XFFC62E3D),
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   pressType: PressType.singleClick,
//                   verticalMargin: -10,
//                   controller: _controller,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 physics: const ScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     childAspectRatio: 0.6,
//                     maxCrossAxisExtent: 140,
//                     crossAxisSpacing: 1,
//                     mainAxisSpacing: 1),
//                 itemBuilder: (context, index) => Image.asset(
//                       image[index],
//                       fit: BoxFit.fill,
//                     )),
//           )
//         ],
//       )),
//     );
//   }
// }
