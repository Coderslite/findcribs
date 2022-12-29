import 'package:findcribs/screens/favourite_screen/all_agent/all_agent.dart';
import 'package:findcribs/screens/favourite_screen/recommended_favourite/recommended_favourite.dart';
import 'package:flutter/material.dart';

class CreateNetworkScreen extends StatefulWidget {
  const CreateNetworkScreen({Key? key}) : super(key: key);

  @override
  State<CreateNetworkScreen> createState() => _CreateNetworkScreenState();
}

class _CreateNetworkScreenState extends State<CreateNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 60.0, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Your",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 13),
                ),
                Text(
                  "Own Network",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const AllAgent();
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.7,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1EF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "All Agents in FindCribs",
                            style: TextStyle(
                                color: const Color(0XFF8A99B1),
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                          Row(
                            children: [
                              Text(
                                "All Agents",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image1.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image2.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image3.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image4.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 7.5,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0XFF0072BA),
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "13+",
                                    style: TextStyle(
                                      color: Color(0XFF0072BA),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "200+ properties, 4k+ likes",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RecommendedFavourite();
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.7,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBE0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Recommended Pick",
                            style: TextStyle(
                                color: const Color(0XFF8A99B1),
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                          Row(
                            children: [
                              Text(
                                "Our Verified Agents",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset("assets/images/tick.png"),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image1.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image2.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image3.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image4.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 7.5,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0XFF0072BA),
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "13+",
                                    style: TextStyle(
                                      color: Color(0XFF0072BA),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "100+ properties, 2k+ likes",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RecommendedFavourite();
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.77,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Based on your location",
                            style: TextStyle(
                                color: const Color(0XFF8A99B1),
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                          Row(
                            children: [
                              Text(
                                "Lagos, Nigeria",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image1.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image2.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image3.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 15,
                                backgroundImage: const AssetImage(
                                    "assets/images/create_network_image4.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 7.5,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0XFF0072BA),
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "13+",
                                    style: TextStyle(
                                      color: Color(0XFF0072BA),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "20+ properties, 1k+ likes",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 33),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (_) {
                //       return const MostFavouritedAgent();
                //     }));
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     height: MediaQuery.of(context).size.height / 4.7,
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFFFF1EF),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Text(
                //             "Most Favourited ",
                //             style: TextStyle(
                //                 color: const Color(0XFF8A99B1),
                //                 fontSize:
                //                     MediaQuery.of(context).size.width / 33),
                //           ),
                //           Row(
                //             children: [
                //               Text(
                //                 "People’s Choice",
                //                 style: TextStyle(
                //                     fontSize:
                //                         MediaQuery.of(context).size.width / 20),
                //               ),
                //             ],
                //           ),
                //           Row(
                //             children: [
                //               CircleAvatar(
                //                 radius: MediaQuery.of(context).size.width / 15,
                //                 backgroundImage: const AssetImage(
                //                     "assets/images/create_network_image1.png"),
                //               ),
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               CircleAvatar(
                //                 radius: MediaQuery.of(context).size.width / 15,
                //                 backgroundImage: const AssetImage(
                //                     "assets/images/create_network_image2.png"),
                //               ),
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               CircleAvatar(
                //                 radius: MediaQuery.of(context).size.width / 15,
                //                 backgroundImage: const AssetImage(
                //                     "assets/images/create_network_image3.png"),
                //               ),
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               CircleAvatar(
                //                 radius: MediaQuery.of(context).size.width / 15,
                //                 backgroundImage: const AssetImage(
                //                     "assets/images/create_network_image4.png"),
                //               ),
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               Container(
                //                 width: MediaQuery.of(context).size.width / 7.5,
                //                 height: MediaQuery.of(context).size.width / 7.5,
                //                 decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   border: Border.all(
                //                     color: const Color(0XFF0072BA),
                //                     width: 2,
                //                   ),
                //                 ),
                //                 child: const Center(
                //                   child: Text(
                //                     "13+",
                //                     style: TextStyle(
                //                       color: Color(0XFF0072BA),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Text(
                //             "200+ properties, 4k+ likes",
                //             style: TextStyle(
                //                 fontSize:
                //                     MediaQuery.of(context).size.width / 33),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
