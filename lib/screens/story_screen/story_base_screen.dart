// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/agent_profile/agent_profile.dart';
import 'package:findcribs/screens/story_screen/each_video_story.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:photo_view/photo_view.dart';
import 'package:progress_indicators/progress_indicators.dart';

class StoryBaseScreen extends StatefulWidget {
  final List moment;
  final String profileImg;
  final int? agentId;
  final String type;
  const StoryBaseScreen(
      {Key? key,
      required this.moment,
      required this.profileImg,
      required this.agentId,
      required this.type})
      : super(key: key);

  @override
  State<StoryBaseScreen> createState() => _StoryBaseScreenState();
}

class _StoryBaseScreenState extends State<StoryBaseScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<StoryItem> storyList = [
    const StoryItem(
      index: 0,
      type: StoryType.Image,
      content: 'Welcome to FindCribs Story',
      image: "assets/images/findcrib_logo.png",
      backgroundColor: Color(0xFF0072BA),
    ),
    const StoryItem(
      index: 1,
      image: '',
      type: StoryType.Text,
      content:
          "Watch videos and see what's happening in the Real Estate market today with your favorite Agents, Real Estate companies, Estate Consultants, Property managers and Property owners.",
      backgroundColor: Color(0xFF0072BA),
    ),
    const StoryItem(
      index: 2,
      image: '',
      type: StoryType.Text,
      content:
          "Get started by clicking on (Pick Favorite) on homepage to see who is posting. Pick as many as you can to never miss any update on Property Market.",
      backgroundColor: Color(0xFFFEC121),
    ),
    const StoryItem(
      index: 3,
      image: '',
      type: StoryType.Text,
      content:
          "As Agent, Estate companies, consultants, Property owners, You can now share vital information to Clients on Properties Investment/ Sales, Daily Update and Offers",
      backgroundColor: Color(
        0xFFEEC1BB,
      ),
    ),
    const StoryItem(
      index: 4,
      image: '',
      type: StoryType.Text,
      content: "Get started  By registering. Click on the",
      backgroundColor: Color(0xFF96D348),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                itemCount: widget.type == 'findcribs'
                    ? storyList.length
                    : widget.moment.length,
                itemBuilder: (context, index) {
                  if (widget.type == 'findcribs') {
                    return StoryItem(
                      index: storyList[index].index,
                      type: storyList[index].type,
                      content: storyList[index].content,
                      image: storyList[index].image,
                      backgroundColor: storyList[index].backgroundColor,
                    );
                  } else {
                    String fileExtension = p.extension(
                        File(widget.moment[index]['mediaUrl'].toString()).path);
                    if (fileExtension == '.png' ||
                        fileExtension == '.jpg' ||
                        fileExtension == '.jpeg') {
                      return PhotoView(
                          wantKeepAlive: true,
                          imageProvider:
                              NetworkImage(widget.moment[index]['mediaUrl']));
                    } else {
                      return Container();
                      //  EachVideoStory(
                      //     mediaUrl: widget.moment[index]['mediaUrl']);
                    }
                  }
                }),
          ),
          Positioned(
            top: 43,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...List.generate(
                        widget.type == 'findcribs'
                            ? storyList.length
                            : widget.moment.length,
                        (index) => Expanded(
                              child: Container(
                                height: 2,
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: index == _currentIndex
                                        ? const Color.fromARGB(134, 39, 88, 235)
                                        : const Color.fromARGB(
                                                255, 177, 176, 176)
                                            .withOpacity(.30)),
                              ),
                            )),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.type == 'findcribs'
                            ? null
                            : Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                                return AgentProfileScreen(
                                  id: widget.agentId,
                                );
                              }));
                      },
                      child: ClipOval(
                        child: widget.type == 'findcribs'
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset("assets/images/logo.png"))
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                imageUrl: widget.profileImg.toString(),
                                progressIndicatorBuilder:
                                    ((context, url, progress) {
                                  return JumpingDotsProgressIndicator();
                                }),
                              ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
          // Positioned(
          //     bottom: 20,
          //     left: 20,
          //     right: 20,
          //     child: Row(
          //       children: [
          //         Text(""),
          //         Spacer(),
          //         Row(
          //           children: [
          //             Icon(Icons.visibility),
          //             const SizedBox(width: 5),
          //             Text(widget.moment[_currentIndex]['views'].toString()),
          //           ],
          //         ),
          //       ],
          //     ))

          Positioned(
              bottom: 20,
              child: widget.type == 'findcribs'
                  ? Container()
                  : widget.moment[_currentIndex]['caption'] == null
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          decoration: BoxDecoration(color: Colors.black38),
                          child: Center(
                            child: Text(
                              widget.moment[_currentIndex]['caption'],
                              style: TextStyle(color: Colors.white),
                            ),
                          )))
        ],
      ),
    );
  }
}

enum StoryType {
  Text,
  Image,
  Video,
}

class StoryItem extends StatelessWidget {
  final StoryType type;
  final String content;
  final String image;
  final Color backgroundColor;
  final int index;
  const StoryItem(
      {Key? key,
      required this.type,
      required this.content,
      required this.image,
      required this.backgroundColor,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == StoryType.Text
        ? index == 4
            ? Container(
                decoration: BoxDecoration(color: backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: const Text(
                                "Get started  By registering. ",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "click on the ",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFFFFFF)),
                                ),
                                CircleAvatar(
                                  child: Icon(Icons.add),
                                ),
                                Text(
                                  " sign below",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(color: backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    content,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF)),
                  )),
                ),
              )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image.toString(),
                scale: 5,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8A99B1)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    " FindCribs",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0072BA)),
                  ),
                  Text(
                    "  Story",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8A99B1)),
                  )
                ],
              )
            ],
          );
  }
}
