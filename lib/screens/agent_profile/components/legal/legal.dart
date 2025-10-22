import 'package:findcribs/screens/agent_profile/components/legal/faqs.dart';
import 'package:findcribs/screens/agent_profile/components/legal/policy_privacy.dart';
import 'package:findcribs/screens/agent_profile/components/legal/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LegalSettings extends StatefulWidget {
  const LegalSettings({super.key});

  @override
  State<LegalSettings> createState() => _LegalSettingsState();
}

class _LegalSettingsState extends State<LegalSettings> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(children: [
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
              "Legal",
              style: TextStyle(fontSize: 18),
            ),
            const Text("            "),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Policy();
            }));
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Policy Privacy",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "Know what binds us together",
                        style: TextStyle(
                            fontSize: 14, color: Color(0XFF8A99B1)),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined,
                    size: 16, color: Color(0XFF8A99B1)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Faqs();
            }));
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("FAQs",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "Some basic questions you may have",
                        style: TextStyle(
                            fontSize: 14, color: Color(0XFF8A99B1)),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined,
                    size: 16, color: Color(0XFF8A99B1)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const TermsAndCondition();
            }));
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Terms and Conditions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "Know what binds us together",
                        style: TextStyle(
                            fontSize: 14, color: Color(0XFF8A99B1)),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined,
                    size: 16, color: Color(0XFF8A99B1)),
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
