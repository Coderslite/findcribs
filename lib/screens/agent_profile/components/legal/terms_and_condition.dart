import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  List<EachTermsAndCondition> termsAndConditionList = const [
    EachTermsAndCondition(
        title: "Terms and Conditions",
        body:
            "Thank you for your interest on 'FindCribs'.FindCribs and its businesses in Nigeria uses “us,” “our,” “we” by clicking on Sign up, Sign in, Create account, Continue using Google and Facebook logins on FindCribs App and accessing any content provided by us you pledge to abide by the following Terms and Conditions, as it will be updated from time to time. FindCribs Limited been incorporated in the Real Estate Sector in Nigeria, Our business and platforms are built for the primary purpose of managing, Finding, Selling and Renting-out of Properties easily through our platform and you fully understand and agree that our Services may include advertisements, to help the advertisements been useful to you, FindCribs Company will serve advertisements based on the information we collect through our Platform."),
    EachTermsAndCondition(
        title: "Account, Registration and Eligibility",
        body:
            "(i) Users on platforms must be at least 18 years of age to use our Services. By accepting to these Terms and Conditions you agree that you are at least 18 years of age"),
    EachTermsAndCondition(
        title: "",
        body:
            "(ii) To access some features of our Services, you may be required to register an account and agree to our Product’s Terms."),
    EachTermsAndCondition(
        title: "",
        body:
            "(iii) Registering of an account you will be asked to provide us with some information about yourself, such as email address, phone number and other details provided on our platforms, you agree that the information you provide is accurate and that you will keep it accurate and up to date at all times. "),
    EachTermsAndCondition(
        title: "",
        body:
            "(iv) During registration, you will be asked to provide a password, you are fully responsible for maintaining the confidentiality of your account and password also responsible for all activities taking place through your account."),
    EachTermsAndCondition(
        title: "Use of our platforms",
        body:
            "(i) Complying with our Terms and conditions, we grant you the ability to perform legal activities on our platforms "),
    EachTermsAndCondition(
        title: "",
        body:
            "(ii) The FindCribs Company must be referenced as a source where information are obtained from our platforms and this recognition may include the FindCribs logo or it name.Users may only copy information from our platforms when it is necessary for their own use and must obtain permission before displaying any further FindCribs Company details."),
    EachTermsAndCondition(
        title: "",
        body:
            "(iii) We do not guarantee that any version of our mobile application will work on your mobile device perfectly, therefore mobile dats may be applied in other to update automatically on the version you have installed in other to enhance user experience"),
    EachTermsAndCondition(
        title: "Restriction on our platforms ",
        body:
            "Using the FindCribs Company trademarks as part of your screen name, part of your business name, part of email address on or off our platform are prohibited and its considered a criminal offense."),
    EachTermsAndCondition(
        title: "",
        body:
            "FindCribs information and platforms are not to be fabricated and modified."),
    EachTermsAndCondition(
        title: "", body: "Upload invalid data, viruses, worm and "),
    EachTermsAndCondition(
        title: "",
        body:
            "other software agents to the Services we provide isn't allowed."),
    EachTermsAndCondition(
        title: "",
        body:
            "Posting of spam or other unsolicited messages through our platform isn't supported."),
    EachTermsAndCondition(
        title: "",
        body:
            "Fabricating another person, brand and Company, or  making any representation to any third party under false pretenses is unacceptable and prohibited on any of our platforms."),
    EachTermsAndCondition(
        title: "",
        body:
            "Services in any way that is unlawful, illegal, untruthful and will harm FindCribs Company name and its integrity is fully prohibited."),
    EachTermsAndCondition(
        title: "",
        body:
            "Listing irrelevant information on our platform is consider illegal and offensive."),
    EachTermsAndCondition(
        title: "",
        body:
            "Interfering with our system integrity and security of Service isn't permitted."),
    EachTermsAndCondition(
        title: "",
        body:
            "Conducting automated queries, screen and database scraping, spiders, robots, crawlers, bypassing “captcha” or any other illegal activities are offensive and prohibited."),
    EachTermsAndCondition(
        title: "Restrictions on Liability",
        body:
            "To the fullest extent permitted by law, FindCribs Limited disclaims all liability for any loss of revenue, loss of profits, lost business, lost contracts, lost data, and any indirect or consequential loss or damage of any kind. We also disclaim all responsibility for any personal injuries or fatalities brought on by our non-performance of duty"),
    EachTermsAndCondition(
        title: "Third Parties",
        body:
            "We take no liability for any errors in the information on our platforms that has been given by third parties, you agree to alternate us from any type of issues that are resulted and are related to third-party information on our platform. We don't guarantee or accept liability for the goods, services of these third parties in which we have no control. "),
    EachTermsAndCondition(
        title: "Mandtory Obligation by our users",
        body:
            "Agents, Property Manager, Property Owner, Real Estate company on FindCribs are responsible for listing and providing the details of the property been listed.Property which are owned or managed by FindCribs will be notified as (FindCribs Owned on our platform).Part of security measure on FindCribs platforms are verifying the Legit agents and other parties listing on FindCribs platform after they undergo verification process, this Sign ✅  will be attached to the Seller's Porfile indicating that this person is verified. Aside this we do not get involved in any communication between you and any agents or any other body or corporate body listing properties on our platform and we do not take part in any purchasing and enquiring process of their own listed properties on FindCribs App.However, You are responsible for making your own Findings and enquiries, we accept no responsibility for the accuracy or completeness of any information contained within the Details."),
    EachTermsAndCondition(
        title: "",
        body:
            "You are responsible for confirming details, making a physical Search and been fully satisfied with yourself about what you've seen on our platform before making any payments."),
    EachTermsAndCondition(
        title: "",
        body:
            "Payment should not be made to any body renting out or selling through our "),
    EachTermsAndCondition(
        title: "",
        body:
            "platform without any physical evidience, a legal practitioner, Surveyor if at any point they are needed."),
    EachTermsAndCondition(
        title: "",
        body:
            "Good customer relationship with you and any agent on our platform is highly welcome and endorse on our platform for better service."),
    EachTermsAndCondition(
        title: "Disclaimer ",
        body:
            "We shall not be responsible in anyway for any User listing on our platforms and the information they provide if they are legit, and we are under no duty to modify User information on our platforms, we have the right to remove or block any User informations that deem to be offensive, misleading and violating our Terms and Conditions at any time without prior notice, which we find to be inaccurate, inappropriate, offensive and information been deceitful, we also have the right to waive any legal right you have on us in respect to our platforms.Links to thirdparty content may be found on our platforms but we do not guarantee, support, or take responsibility for it, If we receive a complaint from a user or content owner alleging that a user information are violating our Terms and Conditions, FindCribs will look into the claim and decide in our sole discretion whether to take down the user information in question at any time without prior notice."),
    EachTermsAndCondition(
        title: "Fee Payment ",
        body:
            "With as low as N200 a seller on FindCribs App can promote his or her property ads to top view on FindCribs."),
    EachTermsAndCondition(
        title: "Merit of Promoting Property Ads::",
        body: "a) Promoted to top view"),
    EachTermsAndCondition(title: "", body: "b) Keyword targeting."),
    EachTermsAndCondition(title: "", body: "c) Low Cost"),
    EachTermsAndCondition(
        title: "", body: "d) Leverage higher engagement rate on Property."),
    EachTermsAndCondition(
        title: "Privacy Policy",
        body:
            "FindCribs Company will collect, store and use information in accordance with our Privacy Policy."),
    EachTermsAndCondition(
        title: "Feedback",
        body:
            "Suggestions and improvements of our product is highly welcome and we appreciate them however, the suggestions you provide regarding our product and services, you've grant us an unrestricted, irrevocable, non-exclusive, fully-paid, royalty-free right to use the Feedback in any manner and for any purpose, including the improvement of our product and Services we Provide."),
    EachTermsAndCondition(
        title: "Intellectual Property",
        body:
            "FindCribs terms and conditions are governed in accordance with Nigerian law and all parties agree that any arguments or disagreement will be settled in a Nigerian court, the Services we provide are owned by FindCribs Limited Company, The user interfaces, Design, information, Data, products, software, graphics, Code and all other elements of our platforms are of FINDCRIBS Limited Company."),
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
                  "Terms & Conditions",
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
                  itemCount: termsAndConditionList.length,
                  itemBuilder: (context, index) {
                    return EachTermsAndCondition(
                        title: termsAndConditionList[index].title,
                        body: termsAndConditionList[index].body);
                  }),
            )
          ],
        ),
      )),
    );
  }
}

class EachTermsAndCondition extends StatelessWidget {
  final String title;
  final String body;
  const EachTermsAndCondition(
      {Key? key, required this.title, required this.body})
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
