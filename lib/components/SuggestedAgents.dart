import 'package:cached_network_image/cached_network_image.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/login_controller.dart';
import 'package:findcribs/screens/favourite_screen/all_agent/all_agent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../controller/user_favorited_agent_controller.dart';
import '../models/most_favourited_model.dart';
import '../service/all_agents.dart';

class SuggestedAgents extends StatefulWidget {
  final List<MostFavouritedModel> agents;
  const SuggestedAgents({super.key, required this.agents});

  @override
  State<SuggestedAgents> createState() => _SuggestedAgentsState();
}

class _SuggestedAgentsState extends State<SuggestedAgents> {
  UserFavoritedAgentController userFavouritedAgentController =
      Get.put(UserFavoritedAgentController());
  AllAgentController agentController = Get.put(AllAgentController());
  handleFavouriteAgent(id) async {
    print(id);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await http.post(
      Uri.parse("$baseUrl/agent/favourite/$id"),
      headers: {"Authorization": "$token"},
    );
    userFavouritedAgentController.handleGetAllAgents(id: id);
  }

  List followed = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparentColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: kPrimary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/images/particle.png"),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.close,
                    color: whiteColor,
                  ).onTap(() {
                    finish(context);
                    getProfileController.showSuggestedAgents.value = false;
                  }),
                ],
              ),
              const Text(
                "Pick a favorite",
                style: TextStyle(
                  fontSize: 24,
                  color: gold,
                ),
              ),
              Text(
                "Network with our verified realtors",
                textAlign: TextAlign.center,
                style: secondaryTextStyle(size: 12, color: whiteColor),
              ),
              20.height,
              for (int x = 0; x < widget.agents.length; x++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CachedNetworkImage(
                            imageUrl: widget.agents[x].profileImg.validate(),
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Loader(
                                value: progress.progress,
                              ).center();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          widget.agents[x].fullName.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: whiteSmoke,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteSmoke,
                        ),
                        child: Icon(
                          followed.contains(widget.agents[x].id)
                              ? Icons.check
                              : Icons.add,
                          color: kPrimary,
                          size: 20,
                        ),
                      ).onTap(() {
                        handleFavouriteAgent(
                            int.parse(widget.agents[x].userId.toString()));
                        if (userFavouritedAgentController.allAgents
                            .where((agent) => agent.id == widget.agents[x].id)
                            .toList()
                            .isNotEmpty) {
                          followed.remove(widget.agents[x].id);
                        } else {
                          followed.add(widget.agents[x].id);
                        }
                        setState(() {});
                      }),
                    ],
                  ),
                ),
              20.height,
              const Text(
                "See More Realtors",
                style: TextStyle(
                  color: gold,
                  fontSize: 16,
                ),
              ).onTap(() {
                finish(context);
                const AllAgent().launch(context);
              }),
              10.height,
            ],
          ),
        ),
      ),
    );
  }
}
