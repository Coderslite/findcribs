
import 'package:findcribs/models/unfavourite_agent.dart';
import 'package:findcribs/screens/agent_profile/agent_profile.dart';
import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../components/constants.dart';
import '../../../controller/user_favorited_agent_controller.dart';
import '../../../models/search_agent_model.dart';
import '../../../service/all_agents.dart';
import '../../../util/colors.dart';

class AllAgent extends StatefulWidget {
  const AllAgent({Key? key}) : super(key: key);

  @override
  State<AllAgent> createState() => _AllAgentState();
}

class _AllAgentState extends State<AllAgent> {
  late Future<List<UserUnFavouritedAgentModel>> allAgentList;
  late Future<List<SearchAgentModel>> searchedAgentModel;
  List<UserUnFavouritedAgentModel>? allAgents = [];
  List<SearchAgentModel>? searchedAgentList = [];
  String searchQuery = '';
  AllAgentController agentController = Get.put(AllAgentController());

  bool isLoading = true;
  List<int> isChecked = [];
  @override
  void initState() {
    agentController.fetchAgents(1);
    super.initState();
  }

  @override
  void dispose() {
    userFavouritedAgentController.handleGetAllAgents();
    agentController.searchQuery.value = "";
    super.dispose();
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
                              builder: (context) => const HomePageRoot(
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
                      // fillColor: const Color(0xFFF9F9F9),
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
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: context.isDarkMode
                              ? white
                              : const Color(0xFF7C7C7C))),
                  onFieldSubmitted: (val) {
                    setState(() {
                      agentController.searchQuery.value = val;
                      agentController.agentPagingController.itemList!.clear();
                      agentController.fetchAgents(1);
                    });
                  },
                  scrollPadding: const EdgeInsets.all(0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PagedGridView<int, UserUnFavouritedAgentModel>(
                    pagingController: agentController.agentPagingController,
                    // physics: NeverScrollableScrollPhysics(),
                    primary: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of items per row
                    ),
                    builderDelegate:
                        PagedChildBuilderDelegate<UserUnFavouritedAgentModel>(
                      noMoreItemsIndicatorBuilder: (context) {
                        Fluttertoast.showToast(msg: "No more items to load");
                        return Container();
                      },
                      itemBuilder: (context, post, index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return AgentProfileScreen(
                                    id: post.id,
                                  );
                                }));
                              },
                              onTap: () {
                                setState(() {
                                  // isChecked.add(int.parse(post.id.toString()));

                                  handleFavouriteAgent(
                                      int.parse(post.id.toString()));
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(post
                                                .profilePic ==
                                            null
                                        ? 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'
                                        : post.profilePic.toString()),
                                    radius:
                                        MediaQuery.of(context).size.width / 8,
                                  ),
                                  Text(
                                    post.businessName.toString(),
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
                              child: isChecked.contains(post.id)
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
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) =>
                          const Center(child: Text('No Agent found.')),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  UserFavoritedAgentController userFavouritedAgentController =
      Get.put(UserFavoritedAgentController());

  handleFavouriteAgent(int id) async {
    userFavouritedAgentController.handleGetAllAgents();
    agentController.agentPagingController.itemList!
        .removeWhere((element) => element.userId == id);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.post(
      Uri.parse("$baseUrl/agent/favourite/$id"),
      headers: {"Authorization": "$token"},
    );
  }
}
