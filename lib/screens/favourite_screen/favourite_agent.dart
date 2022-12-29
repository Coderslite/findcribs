import 'package:findcribs/controller/user_favorited_agent_controller.dart';
import 'package:findcribs/models/user_favourite_agent.dart';
import 'package:findcribs/widgets/agent_listings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavouriteAgentScreen extends StatefulWidget {
  const FavouriteAgentScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteAgentScreen> createState() => _FavouriteAgentScreenState();
}

class _FavouriteAgentScreenState extends State<FavouriteAgentScreen> {
  late Future<List<UserFavouriteAgentModel>> agentList;
  List<UserFavouriteAgentModel> filteredList = [];
  List<UserFavouriteAgentModel> firstList = [];
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // agentList = getMyFavouriteAgentList();
    // // storyList = getFavouriteStoryList();
    // agentList.then((value) {
    //   // print(value);
    //   setState(() {
    //     isLoading = false;
    //     firstList = filteredList = value;
    //   });
    // });
  }

  UserFavoritedAgentController userFavoritedAgentController =
      Get.put(UserFavoritedAgentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF0072BA),
                        )),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Favourite Agents",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                color: Color(0xFFE0E0E0),
              ),
              const SizedBox(
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: const Color(0xFFF9F9F9),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      hintText: "Search for agent by name...",
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFFB1B1B1))),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: userFavoritedAgentController.isLoading.isTrue
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
                    : userFavoritedAgentController.allAgents.isEmpty
                        ? const Center(
                            child:
                                Text("You have not favourited any agent yet"))
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount:
                                userFavoritedAgentController.allAgents.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(19, 0, 19, 15),
                                  child: Agent_Listings(
                                    id: userFavoritedAgentController
                                        .allAgents[index].userId,
                                    name: userFavoritedAgentController
                                        .allAgents[index].businessName
                                        .toString(),
                                    image: userFavoritedAgentController
                                        .allAgents[index].profilePic
                                        .toString(),
                                    category: userFavoritedAgentController
                                        .allAgents[index].category
                                        .toString(),
                                    isverified: userFavoritedAgentController
                                        .allAgents[index].isVerified,
                                  ));
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
