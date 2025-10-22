// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:findcribs/controller/get_my_story_controller.dart';
import 'package:findcribs/screens/story/single_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:path/path.dart' as p;

import '../../controller/delete_story_controller.dart';
import '../../util/colors.dart';

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  late List<ItemModel> menuItems;
  final CustomPopupMenuController _controller = CustomPopupMenuController();
  final tooltipController = JustTheController();
  bool isStandalone = false;
  bool isAttached = false;
  bool isShowing = false;
  bool firstClick = true;
  List toBeDeleteStory = [];
  final ImagePicker _picker = ImagePicker();
  List<File> newfiles = [];

  DeleteStoryController deleteStoryController =
      Get.put(DeleteStoryController());

  GetMyStoryController getMyStoryController = Get.put(GetMyStoryController());

  @override
  void initState() {
    menuItems = [
      ItemModel('Delete', Icons.delete),
    ];
    super.initState();
  }

  @override
  void dispose() {
    tooltipController.dispose();
    deleteStoryController.toBeDeletedStory.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: JustTheTooltip(
          controller: tooltipController,
          preferredDirection: AxisDirection.left,
          isModal: true,
          barrierDismissible: false,
          content: Container(
              height: firstClick ? 70 : 90,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: !isStandalone
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                isStandalone = !isStandalone;
                                isAttached = false;
                                firstClick = false;
                                tooltipController.hideTooltip().then(
                                    (value) => tooltipController.showTooltip());
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Standard Alone"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0XFF0072BA),
                                        width: 2,
                                      )),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Color(0XFF0072BA),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                firstClick = true;
                                isShowing = false;
                                tooltipController.hideTooltip();
                                isStandalone = false;
                              });
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (_) {
                              //   return const StoryCamera();
                              // }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Camera"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0XFF0072BA),
                                        width: 2,
                                      )),
                                  child: const Icon(
                                    Icons.camera_rear_outlined,
                                    color: Color(0XFF0072BA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: !isStandalone
                        ?
                        // InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isAttached = true;
                        //             isStandalone = !isStandalone;
                        //             tooltipController.hideTooltip().then(
                        //                 (value) => tooltipController.showTooltip());
                        //           });
                        //         },
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.end,
                        //           children: [
                        //             const Text("Attach to property"),
                        //             const SizedBox(
                        //               width: 10,
                        //             ),
                        //             Image.asset("assets/images/list_property.png"),
                        //           ],
                        //         ),
                        //       )
                        const Text("")
                        : GestureDetector(
                            onTap: () {
                              handlePickFromGallery();
                              firstClick = true;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Gallery"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0XFF0072BA),
                                        width: 2,
                                      )),
                                  child: const Icon(
                                    Icons.photo_album_outlined,
                                    color: Color(0XFF0072BA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              )),
          // backgroundColor: const Color(0xFFE5E5E5),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  firstClick = true;
                  isShowing
                      ? tooltipController.hideTooltip()
                      : tooltipController.showTooltip();

                  isStandalone = false;
                  isShowing = !isShowing;
                });
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: context.iconColor,
                    ),
                  ))),
        ),
      ),
      body: Obx(
        () => getMyStoryController.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: const Color(0XFFF0F7F8),
                            ),
                            child: SvgPicture.asset(
                              "assets/svgs/arrow_back.svg",
                            ),
                          ),
                        ),
                        const Text(
                          "Story",
                          style: TextStyle(fontSize: 18),
                        ),
                        deleteStoryController.toBeDeletedStory.isEmpty
                            ? Container(
                                height: 60,
                              )
                            : CustomPopupMenu(
                                menuBuilder: () => ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: const Color(0xFFE5E5E5),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: menuItems
                                            .map(
                                              (item) => GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  // print("onTap");
                                                  _controller.hideMenu();
                                                  setState(() {
                                                    deleteStoryController
                                                        .handleDeleteMoment();
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        item.icon,
                                                        size: 15,
                                                        color: const Color(
                                                            0XFFC62E3D),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            item.title,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0XFFC62E3D),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                pressType: PressType.singleClick,
                                verticalMargin: -10,
                                controller: _controller,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                      "assets/images/vertical_line.png"),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: getMyStoryController.myStoryList.isEmpty
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/opps.png"),
                                  const Text(
                                    "Opps!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("You have not posted"),
                                  const Text("any story yet"),
                                  // Material(
                                  //   child: MaterialButton(
                                  //     onPressed: () {},
                                  //     child: Text("Post a story"),
                                  //   ),
                                  // )
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF0072BA)),
                                    onPressed: () {},
                                    child: const Text("Post a story"),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  getMyStoryController.myStoryList.length,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 0.6,
                                      maxCrossAxisExtent: 140,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1),
                              itemBuilder: (context, index) {
                                String fileExtension = p.extension(File(
                                        getMyStoryController
                                            .myStoryList[index].mediaUrl
                                            .toString())
                                    .path);
                                var listingId =
                                    getMyStoryController.myStoryList[index].id;
                                // print(fileExtension);
                                return GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      deleteStoryController.toBeDeletedStory
                                              .contains(listingId)
                                          ? null
                                          : deleteStoryController
                                              .handleAddDeleteStory(listingId!);
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      deleteStoryController
                                              .toBeDeletedStory.isEmpty
                                          ? null
                                          : deleteStoryController
                                              .handleAddDeleteStory(listingId!);
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      SingleStory(
                                          storyId:
                                              int.parse(listingId.toString()),
                                          type: fileExtension,
                                          mediaUrl: getMyStoryController
                                              .myStoryList[index].mediaUrl
                                              .toString()),
                                      deleteStoryController
                                              .toBeDeletedStory.isEmpty
                                          ? Container()
                                          : deleteStoryController
                                                  .toBeDeletedStory
                                                  .contains(listingId)
                                              ? Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    color:
                                                        const Color(0XFF0072BA),
                                                    child: const Icon(
                                                      Icons.check_box_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                              : Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    color:
                                                        const Color(0XFF0072BA),
                                                    child: const Icon(
                                                      Icons
                                                          .check_box_outline_blank_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                    ],
                                  ),
                                );
                              }))
                ],
              )),
      ),
    );
  }

  handlePickFromGallery() async {
    tooltipController.hideTooltip();
    final List<XFile> image = (await _picker.pickMultiImage());

    if (mounted) {
      // ignore: unnecessary_null_comparison
      if (image != null) {
        setState(() {
          for (var img in image) {
            newfiles.add(File(img.path));
          }
        });
      }
    }
  }
}
