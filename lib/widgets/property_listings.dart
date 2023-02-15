// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../screens/product_details/product_details.dart';

// ignore: camel_case_types
class Property_Listings extends StatefulWidget {
  final int? id;
  final List? images;
  final int? bedroom;
  final String? propertyAddress;
  final String propertyState;
  final String? propertyType;
  final String? price;
  const Property_Listings(
      {Key? key,
      this.id,
      this.images,
      this.bedroom,
      this.propertyAddress,
      this.propertyType,
      this.price,
      required this.propertyState})
      : super(key: key);

  @override
  State<Property_Listings> createState() => _Property_ListingsState();
}

class _Property_ListingsState extends State<Property_Listings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ProductDetails(
            id: widget.id,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: .3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.images!.isEmpty
                  ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                  : widget.images!.first['url'].toString(),
              fit: BoxFit.cover,
              width: 126,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  JumpingDotsProgressIndicator(
                fontSize: 20.0,
                color: Colors.blue,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 24.06),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.price.toString(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF09172D)),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  widget.propertyAddress.toString(),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF304059)),
                ),
                Text(
                  widget.propertyState.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8A99B1)),
                ),
                const SizedBox(
                  height: 8.64,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8FEFF),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bed_rounded,
                        color: Color(0xFF8A99B1),
                        size: 9,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "x2",
                        style: TextStyle(
                            color: Color(0xFF8A99B1),
                            fontSize: 9,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Icon(
                        Icons.bathroom_rounded,
                        color: Color(0xFF8A99B1),
                        size: 9,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "x2",
                        style: TextStyle(
                            color: Color(0xFF8A99B1),
                            fontSize: 9,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Icon(
                        Icons.crop_square,
                        color: Color(0xFF8A99B1),
                        size: 9,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "764",
                            style: TextStyle(
                                color: Color(0xFF8A99B1),
                                fontSize: 9,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: " sqft",
                            style: TextStyle(
                                color: Color(0xFF8A99B1),
                                fontSize: 5,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
