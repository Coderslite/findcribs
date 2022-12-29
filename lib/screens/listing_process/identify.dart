import 'package:findcribs/screens/listing_process/agent/agent.dart';
import 'package:findcribs/screens/listing_process/estate_market/estate_market.dart';
import 'package:findcribs/screens/listing_process/property_manager/property_manager.dart';
import 'package:findcribs/screens/listing_process/property_owner/property_owner.dart';
import 'package:flutter/material.dart';

class Identify extends StatefulWidget {
  const Identify({Key? key}) : super(key: key);

  @override
  State<Identify> createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  bool agent = false;
  bool propertyOwner = false;
  bool propertyManager = false;
  bool estateMarket = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: agent
                  ? const Color(0XFF0072BA)
                  : propertyManager
                      ? const Color(0XFF0072BA)
                      : propertyOwner
                          ? const Color(0XFF0072BA)
                          : estateMarket
                              ? const Color(0XFF0072BA)
                              : Colors.grey,
              child: MaterialButton(
                onPressed: () {
                  agent
                      ? Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                          return const AgentRegistration();
                        }))
                      : propertyManager
                          ? Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                              return const PropertyManagerRegistration();
                            }))
                          : propertyOwner
                              ? Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                  return const PropertyOwnerRegistration();
                                }))
                              : estateMarket
                                  ? Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                      return const EstateMarketRegistration();
                                    }))
                                  : () {};
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5,
                    top: 5,
                    bottom: 5,
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "RedHatDisplay",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "What can we identify you as?",
              style: TextStyle(fontSize: 18, fontFamily: "RedHatDisplay"),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      agent = !agent;
                      propertyManager = false;
                      propertyOwner = false;
                      estateMarket = false;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            width: 0.8,
                            color: const Color(0XFFE9E9E9),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Image.asset("assets/images/agent.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "Agent",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "RedHatDisplay"),
                            ),
                          ],
                        ),
                      ),
                      agent
                          ? const Positioned(
                              child: Icon(
                              Icons.check_box,
                              color: Color(0XFF0072BA),
                            ))
                          : Container(),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      agent = false;
                      propertyManager = false;
                      propertyOwner = false;
                      estateMarket = !estateMarket;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            width: 0.8,
                            color: const Color(0XFFE9E9E9),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Image.asset("assets/images/real-estate.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "Real Estate Company",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      estateMarket
                          ? const Positioned(
                              child: Icon(
                              Icons.check_box,
                              color: Color(0XFF0072BA),
                            ))
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      agent = false;
                      propertyManager = !propertyManager;
                      propertyOwner = false;
                      estateMarket = false;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            width: 0.8,
                            color: const Color(0XFFE9E9E9),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Image.asset("assets/images/property-manager.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "Property Manager",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      propertyManager
                          ? const Positioned(
                              child: Icon(
                              Icons.check_box,
                              color: Color(0XFF0072BA),
                            ))
                          : Container(),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      agent = false;
                      propertyManager = false;
                      propertyOwner = !propertyOwner;
                      estateMarket = false;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            width: 0.8,
                            color: const Color(0XFFE9E9E9),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Image.asset("assets/images/property-owner.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "Property Owner",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      propertyOwner
                          ? const Positioned(
                              child: Icon(
                              Icons.check_box,
                              color: Color(0XFF0072BA),
                            ))
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
