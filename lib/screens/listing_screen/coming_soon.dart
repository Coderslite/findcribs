import 'package:findcribs/screens/homepage/home_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF0072BA).withOpacity(0.9),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 36,
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: 0.4,
                decoration:const BoxDecoration(
                  color: Color(0xFFBDBDBD),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HomePageRoot(
                          navigateIndex: 0,
                        );
                      }));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: SvgPicture.asset(
                        "assets/svgs/home.svg",
                        width: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HomePageRoot(
                          navigateIndex: 1,
                        );
                      }));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: SvgPicture.asset(
                        "assets/svgs/love.svg",
                        width: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: SvgPicture.asset(
                      "assets/svgs/blank.svg",
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return HomePageRoot(
                          navigateIndex: 3,
                        );
                      }));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: SvgPicture.asset(
                        "assets/svgs/chat2.svg",
                        width: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return HomePageRoot(
                              navigateIndex: 4,
                            );
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: SvgPicture.asset(
                        "assets/svgs/account.svg",
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(child: Image.asset("assets/images/coming_soon.png")),
    );
  }

}
