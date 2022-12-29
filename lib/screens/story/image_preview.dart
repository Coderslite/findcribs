import 'dart:convert';
import 'dart:io';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/story/story_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImagePreview extends StatefulWidget {
  final File file;
  final String? listingId;
  const ImagePreview({
    Key? key,
    required this.file,
    this.listingId,
  }) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool isUploading = false;
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // print(widget.file!.path);
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        body: isUploading
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Uploading Story"),
                ],
              ))
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(widget.file.path)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            handleUploadImageStory(textController.text);
                          },
                          child: const CircleAvatar(
                            child: Icon(
                              Icons.send,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  handleUploadImageStory(String caption) async {
    setState(() {
      isUploading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final request = http.MultipartRequest('POST', Uri.parse("$baseUrl/moment"));
    request.fields['caption'] = caption;
    request.fields['listingId'] =
        widget.listingId == null ? '' : widget.listingId.toString();
    request.headers['Authorization'] = "$token";
    final httpImage =
        await http.MultipartFile.fromPath('media', widget.file.path);
    request.files.add(httpImage);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final responseData = jsonDecode(respStr);

    if (responseData['status'] == true) {
      setState(() {
        isUploading = false;
      });
      Fluttertoast.showToast(msg: "Upload successful");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const StoryList();
      }));
    } else {
      setState(() {
        isUploading = false;
      });
      // throw Exception(response.statusCode);
      Fluttertoast.showToast(msg: "something went wrong");
    }
  }
}
