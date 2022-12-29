import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:findcribs/screens/story/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';

late List<CameraDescription> cameras;

class StoryCamera extends StatefulWidget {
  const StoryCamera({Key? key}) : super(key: key);

  @override
  State<StoryCamera> createState() => _StoryCameraState();
}

class _StoryCameraState extends State<StoryCamera> {
  List<File> files = [];
  late CameraController controller;
  bool isFlash = false;
  bool isVideoStarted = false;
  int cameraIndex = 0;

  int _counter = 60;
  late Timer _timer;
  void _startTimer() {
    _counter = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
        handleVideoRecording();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[cameraIndex], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // print(');
            Fluttertoast.showToast(msg: "User denied camera access.")
                .then((value) {
              Navigator.pop(context);
            });
            break;
          default:
            // print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            CameraPreview(controller),
            Positioned(
              bottom: 0,
              child: Container(
                height: 160,
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.95),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              handleGetFiles();
                            },
                            child: Image.asset("assets/images/gallery.png")),
                        GestureDetector(
                          onTap: () {
                            handleTakePhoto();
                          },
                          child: const Icon(
                            Icons.panorama_fish_eye_outlined,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            handleRotateCamera();
                          },
                          child: Image.asset("assets/images/camera.png"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                        child: Text(
                      "Tap for photo",
                      style: TextStyle(color: Colors.white),
                    ))
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    isVideoStarted
                        ? Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                _counter.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(),
                    isFlash
                        ? GestureDetector(
                            onTap: () {
                              handleTurnFlashOnOFF();
                            },
                            child: const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              handleTurnFlashOnOFF();
                            },
                            child: const Icon(
                              Icons.flash_off,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleTurnFlashOnOFF() {
    if (isFlash) {
      controller.setFlashMode(FlashMode.torch).then(
        (value) {
          setState(() {
            isFlash = false;
            // print("turn on");
          });
        },
      );
    } else {
      controller.setFlashMode(FlashMode.off).then(
        (value) {
          setState(() {
            isFlash = true;
            // print("turn off");
          });
        },
      );
    }
  }

  handleVideoRecording() {
    if (isVideoStarted) {
      controller.stopVideoRecording().then((value) {
        // Navigator.push(context, MaterialPageRoute(builder: (_) {
        //   return VideoTrim(file: File(value.path));
        // }));
        null;
        setState(() {
          isVideoStarted = false;
          _counter = 60;
          // print(value);
        });
      });
    } else {
      controller.startVideoRecording().then((value) {
        setState(() {
          _startTimer();
          isVideoStarted = true;
        });
      });
    }
  }

  handleTakePhoto() {
    controller.takePicture().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ImagePreview(
          file: File(value.path.toString()),
        );
      }));
    });
  }

  handleRotateCamera() async {
    await controller.dispose();
    if (cameraIndex == 0) {
      controller = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: true,
      );

// If the controller is updated then update the UI.
      controller.addListener(() {
        if (mounted) setState(() {});
        if (controller.value.hasError) {
          // showInSnackBar('Camera error ${controller.value.errorDescription}');
        }
      });

      try {
        await controller.initialize();
      } on CameraException {
        // _showCameraException(e);
      }

      if (mounted) {
        setState(() {
          cameraIndex = 1;
        });
      }
    } else {
      controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: true,
      );

// If the controller is updated then update the UI.
      controller.addListener(() {
        if (mounted) setState(() {});
        if (controller.value.hasError) {
          // showInSnackBar('Camera error ${controller.value.errorDescription}');
        }
      });

      try {
        await controller.initialize();
      } on CameraException {
        // _showCameraException(e);
      }

      if (mounted) {
        setState(() {
          cameraIndex = 0;
        });
      }
    }
  }

  handleGetFiles() {
    var result = FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['mp4', 'jpg', 'png']);
    // ignore: unnecessary_null_comparison
    if (result != null) {
      result.then((value) {
        files.add(File(value!.files.single.path.toString()));
      });
    } else {
      // print("no file selected");
    }
  }
}
