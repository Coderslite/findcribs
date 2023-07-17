import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../screens/agent_profile/agent_profile.dart';
import '../util/colors.dart';

// ignore: camel_case_types
class Agent_Listings extends StatelessWidget {
  final String isverified;
  final String name;
  final String image;
  final String category;
  final int? id;
  const Agent_Listings({
    Key? key,
    required this.name,
    required this.image,
    required this.category,
    required this.id,
    required this.isverified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return AgentProfileScreen(id: id);
        }));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: grey,
            width: .3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
          leading: Stack(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    imageUrl:
                        image.isEmpty || image == 'null' ? avataImg : image,
                    progressIndicatorBuilder: (context, url, progress) {
                      return JumpingDotsProgressIndicator();
                    }),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: isverified.toLowerCase() == 'verified'
                      ? Image.asset("assets/images/tick.png")
                      : Container())
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: context.isDarkMode ? white : Color(0xFF4F5E76)),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                category,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: context.isDarkMode ? white : Color(0xFF4F5E76)),
              ),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   children: [
              //     SvgPicture.asset('assets/svgs/star_spur.svg'),
              //     const SizedBox(
              //       width: 4.33,
              //     ),
              //     const Text(
              //       "4.4 Ratings",
              //       style: TextStyle(
              //           fontSize: 10,
              //           fontWeight: FontWeight.w400,
              //           color: Color(0xFF4F5E76)),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
