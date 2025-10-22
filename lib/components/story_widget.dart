import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/story_list_controller.dart';
import '../screens/favourite_screen/all_agent/all_agent.dart';
import '../screens/homepage/each_story.dart';
import '../screens/story_screen/story_base_screen.dart';
import '../util/social_login.dart';

SingleChildScrollView storyWidget(BuildContext context) {
  GetStoryListController getStoryListController =
      Get.put(GetStoryListController());
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('token');
                token == null
                    ? showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return const SocialLogin();
                        })
                    : Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const AllAgent();
                      }));
              },
              child: Container(
                width: 75,
                height: 75,
                margin: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0XFF0072BA)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Pick a favourite",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        getStoryListController.allStoryList.isEmpty
            ? GestureDetector(
                onTap: () {
                  Get.to(const StoryBaseScreen(
                      moment: [],
                      profileImg: '',
                      agentId: 1,
                      type: 'findcribs'));
                },
                child: Column(
                  children: [
                    DottedBorder(
                      options: OvalDottedBorderOptions(
                        // dashPattern: [200 / 20 - (20), 2],
                        padding: EdgeInsets.all(2),
                        color: Colors.blue,
                        strokeWidth: 1.5,
                        strokeCap: StrokeCap.round,
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: ClipOval(
                            child: Image.asset("assets/images/logo.png")),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "FindCribs",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
        SizedBox(
          height: 95,
          child: ListView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: getStoryListController.allStoryList.length,
              itemBuilder: (context, index) {
                String fileExtension = p.extension(File(getStoryListController
                        .allStoryList[index].moment!.last['mediaUrl']
                        .toString())
                    .path);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return StoryBaseScreen(
                              type: 'individuals',
                              agentId:
                                  getStoryListController.allStoryList[index].id,
                              profileImg: getStoryListController
                                  .allStoryList[index].profilePic
                                  .toString(),
                              moment: getStoryListController
                                  .allStoryList[index].moment!
                                  .toList(),
                            );
                          }));
                        },
                        child: EachStory(
                          type: fileExtension,
                          firstName: getStoryListController
                              .allStoryList[index].firstName
                              .toString(),
                          lastName: getStoryListController
                              .allStoryList[index].lastName
                              .toString(),
                          fileName: getStoryListController
                              .allStoryList[index].moment!.last['mediaUrl'],
                        )),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                );
              }),
        )
      ],
    ),
  );
}
