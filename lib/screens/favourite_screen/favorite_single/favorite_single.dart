import 'dart:convert';

import 'package:findcribs/screens/agent_profile/agent_profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../components/constants.dart';

class FavoriteSingle extends StatefulWidget {
  final String businessName;
  final String image;
  final int id;
  const FavoriteSingle(
      {Key? key,
      required this.businessName,
      required this.image,
      required this.id})
      : super(key: key);

  @override
  State<FavoriteSingle> createState() => _FavoriteSingleState();
}

class _FavoriteSingleState extends State<FavoriteSingle> {
  bool isFavourite = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        // Text("hi"),
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AgentProfileScreen(
                  id: widget.id,
                );
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image.toString()),
                  radius: MediaQuery.of(context).size.width / 10,
                ),
                Text(
                  widget.businessName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                isFavourite
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: mobileButtonColor),
                        onPressed: () {
                          handleFavouriteAgent(widget.id);
                        },
                        child: const Text("Favourite"),
                      ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 0,
          child: isChecked
              ? const Icon(
                  Icons.check_box,
                  color: Color(0XFF0072BA),
                )
              : Container(),
        ),
      ],
    );
  }

  handleFavouriteAgent(int id) async {
    setState(() {
      isFavourite = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.post(
      Uri.parse("$baseUrl/agent/favourite/$id"),
      headers: {"Authorization": "$token"},
    );
    var responseJson = jsonDecode(response.body);
    if (responseJson['status'] == true) {
      // print(responseJson['message']);

      setState(() {
        isFavourite = false;
      });
      Fluttertoast.showToast(msg: responseJson['message']);
    } else {
      // print(responseJson['message']);
      setState(() {
        isFavourite = false;
      });
      Fluttertoast.showToast(msg: responseJson['message']);
    }
  }
}
