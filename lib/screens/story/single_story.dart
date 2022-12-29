import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/controller/delete_story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
// import 'package:video_player/video_player.dart';

class SingleStory extends StatefulWidget {
  final String type;
  final String mediaUrl;
  final int storyId;
  const SingleStory(
      {Key? key,
      required this.type,
      required this.mediaUrl,
      required this.storyId})
      : super(key: key);

  @override
  State<SingleStory> createState() => _SingleStoryState();
}

class _SingleStoryState extends State<SingleStory> {
  bool isPlaying = false;
  // late VideoPlayerController controller;

  @override
  void initState() {
    // controller = VideoPlayerController.network(
    //   widget.mediaUrl,
    //   videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    // )..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  DeleteStoryController deleteStoryController =
      Get.put(DeleteStoryController());

  @override
  Widget build(BuildContext context) {
    return widget.type == '.jpg' ||
            widget.type == '.png' ||
            widget.type == '.jpeg'
        ? SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  // ignore: unnecessary_null_comparison
                  imageUrl: widget.mediaUrl == null
                      ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                      : widget.mediaUrl.toString(),
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 200,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      JumpingDotsProgressIndicator(
                    fontSize: 20.0,
                    color: Colors.blue,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                  child:
                      deleteStoryController.idDeleting.value == widget.storyId
                          ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : Container(),
                )
              ],
            ),
          )
        : Container();

    // Container(
    //     height: 200,
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         VideoPlayer(controller),
    //         Positioned(
    //           // bottom: 150,
    //           child: Container(
    //               padding: const EdgeInsets.all(10),
    //               width: 80,
    //               decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   border: Border.all(
    //                     color: Colors.white,
    //                   )),
    //               child: deleteStoryController.idDeleting.value ==
    //                       widget.storyId
    //                   ? const Center(
    //                       child: CircularProgressIndicator(
    //                         color: Colors.red,
    //                       ),
    //                     )
    //                   : GestureDetector(
    //                       onTap: () {
    //                         isPlaying
    //                             ? controller.pause()
    //                             : controller.play();
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
    //         ),
    //       ],
    //     ),
    //   );
  }
}
