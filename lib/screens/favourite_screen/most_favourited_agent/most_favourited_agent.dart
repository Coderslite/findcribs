import 'dart:convert';

import 'package:findcribs/models/most_favourited_model.dart';
import 'package:findcribs/screens/agent_profile/agent_profile.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:findcribs/service/most_favourited_agent_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../components/constants.dart';

class MostFavouritedAgent extends StatefulWidget {
  const MostFavouritedAgent({Key? key}) : super(key: key);

  @override
  State<MostFavouritedAgent> createState() => _MostFavouritedAgentState();
}

class _MostFavouritedAgentState extends State<MostFavouritedAgent> {
    late Future<List<MostFavouritedModel>> allAgentList;
  List<MostFavouritedModel>? allAgents = [];

  bool isLoading = true;
  List<int> isChecked = [];
  @override
  void initState() {
    handleGetAgents();
    super.initState();
  }

  handleGetAgents() async {
    getFavouriteAgentList('by-favorited').then((value) {
      setState(() {
        isChecked = [];
        isLoading = false;
        allAgents = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width / 5,
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 3,
                right: MediaQuery.of(context).size.width / 3,
                bottom: 20,
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 15,
                  blurRadius: 50,
                  offset: const Offset(0, -5),
                )
              ]),
              child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageRoot(
                                    navigateIndex: 0,
                                  )));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("DONE"),
                    ),
                  )),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
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
                    const Text("Choose 5 or more agent"),
                    const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF9F9F9),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 15.67),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFB1B1B1),
                      ),
                      hintText: "Search an agent name",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xFF7C7C7C))),
                  onChanged: (va) {},
                  scrollPadding: const EdgeInsets.all(0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CollectionSlideTransition(
                                  children: const <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 6,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 6,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      radius: 6,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount:
                                allAgents!.length < 12 ? allAgents!.length : 12,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    crossAxisSpacing: 5,
                                    mainAxisExtent: 150,
                                    mainAxisSpacing: 2),
                            itemBuilder: (context, index) => Stack(
                              children: [
                                GestureDetector(
                                  onLongPress: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return AgentProfileScreen(
                                        id: allAgents![index].id,
                                      );
                                    }));
                                  },
                                  onTap: () {
                                    setState(() {
                                      isChecked.add(int.parse(
                                          allAgents![index].id.toString()));
                                      handleGetAgents();
                                      allAgents!.removeWhere((element) =>
                                          element.id == allAgents![index].id);
                                      handleFavouriteAgent(int.parse(
                                          allAgents![index].userId.toString()));
                                      // print(allAgents);
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            allAgents![index]
                                                .profileImg
                                                .toString()),
                                        radius:
                                            MediaQuery.of(context).size.width /
                                                8,
                                      ),
                                      Text(
                                        allAgents![index]
                                            .businessName
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // isFavourite
                                      //     ? const CircularProgressIndicator()
                                      //     : ElevatedButton(
                                      //         style: ElevatedButton.styleFrom(
                                      //             primary: mobileButtonColor),
                                      //         onPressed: () {
                                      //           handleFavouriteAgent(widget.id);
                                      //         },
                                      //         child: const Text("Favourite"),
                                      //       ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: isChecked
                                          .contains(allAgents![index].id)
                                      ? const CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(0XFF263238),
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          )),
              ],
            ),
          ),
        ));
  }
  handleFavouriteAgent(int id) async {
    setState(() {});
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.post(
      Uri.parse("$baseUrl/agent/favourite/$id"),
      headers: {"Authorization": "$token"},
    );
    var responseJson = jsonDecode(response.body);
    if (responseJson['status'] == true) {
      // print(responseJson['message']);

      setState(() {});
      Fluttertoast.showToast(msg: responseJson['message']);
    } else {
      // print(responseJson['message']);
      setState(() {});
      Fluttertoast.showToast(msg: responseJson['message']);
    }
  }
}
