import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<EachFAQ> eachFaqList = [
    const EachFAQ(
        children: false,
        question: "What is FindCribs App::",
        answer:
            "FindCribs App allow users to Find and Sell all kind of Legit and Vacant Properties around you to potential Tenants, Buyers and Potential Investors."),
    const EachFAQ(
      question: "How do I Make Money Using FindCribs::",
      answer:
          "Register your business name, identify yourself, start posting legit vacant properties for Rent and For Sale and earn money when you close deals.",
      children: false,
    ),
    const EachFAQ(
      question: "How do I Rent-Out and Sell Properties::",
      answer:
          "Click on the below Blue Circle 🔵 + Button on homepage, Register, identify yourself and Start Posting Properties.",
      children: false,
    ),
    const EachFAQ(
      question: "What is meant by Promote?",
      answer:
          "Promote service allows a user Selling on FindCribs to promote their property ads to the top view and display first to every possible places potential Clients will view on with as low as N200.",
      children: false,
    ),
    const EachFAQ(
      question:
          "How Do I Find Shortlet-Rent, Service Apartment, Self-Contained on FindCribs::",
      answer: "Click on Apartments on Homepage to further view categories.",
      children: false,
    ),
    const EachFAQ(
      question: "What's Estate Market on FindCribs App:::",
      answer:
          "'Estate Market' You can post, Find every other commercial Properties existing in Nigeria by simply making use of the search engine or scroll down to see what's around you on Estate Market page.",
      children: false,
    ),
    const EachFAQ(
      question: "What Can I Sell or Rent-Out on Estate-Market::",
      answer:
          "Other Commercial Properties  existing in Nigeria like Shops, Mall, Hall, School buildings, Church buildings, Warehouse, Event Centers, Offices and many more.",
      children: false,
    ),
    const EachFAQ(
      question: "Are my Personal details Safe:::",
      answer:
          "Your personal details are safe, only your ;Business name and Brands; are promoted on the FindCribs App",
      children: false,
    ),
    const EachFAQ(
      question: "What is Listing:::",
      answer: "Listing is the Property you posted on the FindCribs App",
      children: false,
    ),
    const EachFAQ(
      question: "How do I Re-Edit My Personal and Business Information::",
      answer:
          "From Homepage, Click on Profile You will be able to access informations to aid you through.",
      children: false,
    ),
    const EachFAQ(
      question: "How do I Manage My Listing::",
      answer:
          "From Homepage, click on Profile then click on (manage your business information) you have access to tools that will aid you to manage Listings like Edit, Hide, Delete, add Video and many more after listing a property.",
      children: false,
    ),
    const EachFAQ(
      question: "How do I Add Videos to My Listings::",
      answer:
          "From Homepage, Click on Profile then click on (manage your business information) you will have access to tools that will aid you to add Videos to the properties you listed.",
      children: false,
    ),
    const EachFAQ(
      question: "How do I get Verified::",
      answer:
          "By Submitting your incoppration certificate that shows that your Business or Company name on FindCribs App is registered and signed with the CAC then a verified tick will be tag to your profile.",
      children: false,
    ),
    const EachFAQ(
      question: "How do I incorporate my Business/Company Name::",
      answer:
          "You can Incorporate your Business or Company name with FindCribs Limited and the CAC Certificate will be available.For further information contact our Customer Care on:: 07026195346. Email @FindCribs.ng@gmail.com stating your request.",
      children: false,
    ),
    const EachFAQ(
      question:
          "Can I Assign (FindCribs LTD) to Manage a Property owned by me::",
      answer:
          "With Our dedicated and professional Lawyer, Yes FindCribs Limited can Manage properties owned by a Property Owner and still provide these Property owners with decent Clients. Through the listing process, Register as (Property Owner) and initiate a request (YES) for Property management Or Call 07026195346. Email @FindCribs.ng@gmail.com",
      children: false,
    ),
    const EachFAQ(
      question: "Who are Prime Agents::",
      answer:
          "Users listing vacant properties on FindCribs will be rewarded massively base on frequent listing, frequent creating of Real Estate content.",
      children: false,
    ),
    const EachFAQ(
      question: "Advantages of Promoting your Property::",
      answer:
          "Click on the below Blue Circle 🔵 + Button on homepage, Register, identify yourself and Start Posting Properties.",
      children: true,
    ),
    const EachFAQ(
      question: "How do I Favourite An Agent::",
      answer:
          "Promoted to top view                                                                                                        ",
      children: false,
    ),
    const EachFAQ(
      question: "Can I Watch Videos on FindCribs App::",
      answer:
          "Yes, by Favouriting Agents, Realtors and many more on the App using the Favourite +🔵  Button at the top left hand corner of the homepage.",
      children: false,
    ),
    const EachFAQ(
      question: "How can I change my Business/Company name on FindCribs::",
      answer:
          "Send a mail to FindCribs.ng@gmail.com stating why your Business name should be change on FindCribs and our Team will attend to it immediately.",
      children: false,
    ),
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
                    "FAQs",
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
                      itemCount: eachFaqList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return eachFaqList[index].children == false
                            ? EachFAQ(
                                question: eachFaqList[index].question,
                                answer: eachFaqList[index].answer,
                                children: false,
                              )
                            : const EachFAQWithChildren(
                                question:
                                    "Advantages of Promoting your Property::",
                                children: true,
                                column: [
                                  "a) Promoted to top view",
                                  "b) Keyword targeting.",
                                  "c) Low Cost",
                                  "d) Leverage higher engagement rate on Property.",
                                ],
                              );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class EachFAQ extends StatelessWidget {
  final String question;
  final String answer;
  final bool children;
  const EachFAQ(
      {Key? key,
      required this.question,
      required this.answer,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.black,
      iconColor: const Color(0xFFB9C2C2),
      collapsedIconColor: const Color(0xFFB9C2C2),
      title: Text(
        question,
        style: const TextStyle(
          color: Color(0xFF09172D),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                answer,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFF8A99B1),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EachFAQWithChildren extends StatelessWidget {
  final String question;
  final bool children;
  final List<String> column;
  const EachFAQWithChildren(
      {Key? key,
      required this.question,
      required this.children,
      required this.column})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.black,
      iconColor: const Color(0xFFB9C2C2),
      collapsedIconColor: const Color(0xFFB9C2C2),
      title: Text(
        question,
        style: const TextStyle(
          color: Color(0xFF09172D),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: column.length,
                  itemBuilder: (context, index) {
                    return Text(
                      column[index],
                      style: const TextStyle(
                        color: Color(0xFF8A99B1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
