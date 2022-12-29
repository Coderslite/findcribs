import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
// import 'package:video_player/video_player.dart';

class EachStory extends StatefulWidget {
  final String type;
  final String firstName;
  final String lastName;
  final String fileName;
  const EachStory(
      {Key? key,
      required this.type,
      required this.firstName,
      required this.lastName,
      required this.fileName})
      : super(key: key);

  @override
  State<EachStory> createState() => _EachStoryState();
}

class _EachStoryState extends State<EachStory> {
  // late VideoPlayerController controller;

  @override
  void initState() {
    // controller = VideoPlayerController.network(
    //   widget.fileName,
    //   videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    // )..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == 'findcribs'
        ? Column(
            children: [
              DottedBorder(
                  borderType: BorderType.Oval,
                  color: Colors.blue,
                  strokeWidth: 1.5,
                  strokeCap: StrokeCap.round,
                  dashPattern: const [200 / 20 - (20), 2],
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipOval(
                          child: Image.asset("assets/images/logo.png")))),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.firstName.toString() + " " + widget.lastName.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          )
        : widget.type == '.png' ||
                widget.type == '.jpg' ||
                widget.type == '.jpeg'
            ? Column(
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: Colors.blue,
                    strokeWidth: 1.5,
                    strokeCap: StrokeCap.square,
                    dashPattern: const [300 / 5],
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      width: 65,
                      height: 65,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.fileName,
                          progressIndicatorBuilder: ((context, url, progress) {
                            return JumpingDotsProgressIndicator();
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.firstName.toString() +
                        " " +
                        widget.lastName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              )
            :

            // Column(
            //     children: [
            //       DottedBorder(
            //         borderType: BorderType.Circle,
            //         color: Colors.blue,
            //         strokeWidth: 1.5,
            //         strokeCap: StrokeCap.square,
            //         dashPattern: const [300 / 5],
            //         padding: const EdgeInsets.all(2),
            //         child: SizedBox(
            //           width: 65,
            //           height: 65,
            //           child: ClipOval(child: VideoPlayer(controller)),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 5,
            //       ),
            //       Text(
            //         widget.firstName.toString() +
            //             " " +
            //             widget.lastName.toString(),
            //         overflow: TextOverflow.ellipsis,
            //         style: const TextStyle(fontSize: 10),
            //       ),
            //     ],
            //   );

            Container();
  }
}
