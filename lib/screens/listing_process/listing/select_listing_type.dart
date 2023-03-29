import 'package:findcribs/screens/listing_process/listing/components/estate_market.dart';
import 'package:findcribs/screens/listing_process/listing/components/rent/rent1.dart';
import 'package:findcribs/screens/listing_process/listing/components/sale/sale1.dart';
import 'package:flutter/material.dart';

class SelectListingType extends StatefulWidget {
  const SelectListingType({Key? key}) : super(key: key);

  @override
  State<SelectListingType> createState() => _SelectListingTypeState();
}

class _SelectListingTypeState extends State<SelectListingType> {
  bool rent = false;
  bool sale = false;
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
              color: rent
                  ? const Color(0XFF0072BA)
                  : sale
                      ? const Color(0XFF0072BA)
                      : estateMarket
                          ? const Color(0XFF0072BA)
                          : Colors.grey,
              child: MaterialButton(
                onPressed: () {
                  rent
                      ? Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                          return const Rent1();
                        }))
                      : sale
                          ? Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                              return const Sale1();
                            }))
                          : estateMarket
                              ? Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                  return const EstateMarket();
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Pick a category",
                style: TextStyle(fontSize: 18, fontFamily: "RedHatDisplay"),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rent = !rent;
                      sale = false;
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
                            Image.asset("assets/images/for_rent.png",
                                scale: MediaQuery.of(context).size.width / 110),
                            const Text(
                              "For Rent",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "RedHatDisplay"),
                            ),
                          ],
                        ),
                      ),
                      rent
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
                      rent = false;
                      sale = !sale;
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
                            Image.asset("assets/images/for_sale.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "For Sale",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      sale
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rent = false;
                      sale = false;
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
                            Image.asset("assets/images/for_estate.png",
                                scale: MediaQuery.of(context).size.width / 100),
                            const Text(
                              "Estate Market",
                              style: TextStyle(
                                fontFamily: "RedHatDisplay",
                                fontSize: 14,
                              ),
                            )
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
          )
        ],
      ),
    );
  }
}
