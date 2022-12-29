import 'package:flutter/material.dart';

import '../screens/product_details/product_details.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ProductDetails(
                id: 1,
              );
            }));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 166,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/images/house_listing.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Redding Villa",
              style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "\$50,000",
              style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Color(0xFFFEC121),
                  size: 10,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Maitama, Abuja",
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.qr_code_rounded,
                  color: Color(0xFFFEC121),
                  size: 10,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "2,340 sq/m",
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.star_rate,
                  color: Color(0xFFFEC121),
                  size: 10,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "4.4 Ratings",
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
