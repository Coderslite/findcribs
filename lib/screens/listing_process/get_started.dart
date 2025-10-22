import 'package:findcribs/screens/listing_process/identify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: const Color(0XFF0072BA),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Identify();
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5,
                    top: 5,
                    bottom: 5,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    top: 40,
                  ),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0XFFF0F7F8),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset("assets/svgs/arrow_back.svg"),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/findcrib_logo.png",
                    scale: MediaQuery.of(context).size.width / 130,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to ",
                      style: TextStyle(
                        fontFamily: "RedHatDisplayLight",
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "FindCribs",
                      style: TextStyle(
                        color: Color(0XFF0072BA),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Listings Manager",
                  style: TextStyle(
                    fontFamily: "RedHatDisplayLight",
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
