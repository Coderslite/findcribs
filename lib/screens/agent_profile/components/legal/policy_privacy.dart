import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Policy extends StatefulWidget {
  const Policy({Key? key}) : super(key: key);

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  List<EachPolicy> termAndConditionList = const [
    EachPolicy(
        title: "Privacy Policy",
        body:
            "Our existence is to ease the stress involved in searching of properties in Nigeria. FindCribs is clear about how we are using user's data on our platform to aid serve our users better which involve finding Properties around you and across Nigeria States. Our main goal is to provide our users with tools they need to be in total control of their privacy."),
    EachPolicy(
        title: "The use of user's information we request For::",
        body:
            "The information we seek from our app and website is to help us provide users with Properties that are vacant and available within user's location, other states in Nigeria and identity purpose."),
    EachPolicy(
        title: "How do FindCribs make use of the information collected",
        body:
            "Data collect are use to make your home/ Properties Search available at your Fingertips."),
    EachPolicy(
        title: "Controlling of your privacy",
        body:
            "Tools are provided on our platforms that allow user's to see, edit and manage their personal data."),
    EachPolicy(
        title: "Notification",
        body:
            "FindCribs platforms uses Notification to provide users with latest information on vacant properties for Rent and For Sale around user's locations and across other states in Nigeria."),
    EachPolicy(
        title: "Data Protection ",
        body:
            "Information provided by users are been stored and protected in our database, Security measures has been placed to ensure that these data provided are protected under our control which includes providing protection to control un-verified and unauthorized systems and users to access informations provided by our users that comply with our terms and conditions.Misuse of information, accidental disclosure of  your information to others FindCribs are unable to guarantee the full protection of your information, thereby we urge users to not disclose there information on our platforms to people or unverified systems."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0XFFF0F7F8),
                        borderRadius: BorderRadius.circular(13)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset("assets/svgs/arrow_back.svg"),
                    ),
                  ),
                ),
                const Text(
                  "Policy Privacy",
                  style: TextStyle(
                    fontFamily: "RedHatDisplay",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text("            "),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: termAndConditionList.length,
                  itemBuilder: (context, index) {
                    return EachPolicy(
                        title: termAndConditionList[index].title,
                        body: termAndConditionList[index].body);
                  }),
            )
          ],
        ),
      )),
    );
  }
}

class EachPolicy extends StatelessWidget {
  final String title;
  final String body;
  const EachPolicy({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            body,
            style: const TextStyle(
                color: Color(0xFF8A99B1), fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
