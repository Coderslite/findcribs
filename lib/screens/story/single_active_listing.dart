
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';


class SingleActiveListing extends StatefulWidget {
  final List? image;
  final String? currency;
  final String? propertyAddress;
  final String? propertyLocation;
  final String? id;
  final String? formattedPrice;
  final String? status;
  final String likeCOunt;
  final String viewCount;
  final bool? isPromoted;
  const SingleActiveListing({
    Key? key,
    required this.image,
    required this.currency,
    required this.propertyAddress,
    required this.id,
    required this.formattedPrice,
    required this.status,
    required this.likeCOunt,
    required this.viewCount,
    required this.isPromoted,
    required this.propertyLocation,
  }) : super(key: key);

  @override
  State<SingleActiveListing> createState() => _SingleActiveListingState();
}

class _SingleActiveListingState extends State<SingleActiveListing> {
  bool isDeleting = false;
  late CustomPopupMenuController _controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _controller = CustomPopupMenuController();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: .3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isDeleting
                  ? const CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : widget.image!.isEmpty
                      ? Image.asset(
                          'assets/images/property_image.png',
                          height: 100,
                          width: 126,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.image!.isEmpty
                              ? 'http://campus.murraystate.edu/academic/faculty/BAtieh/House1.JPG'
                              : widget.image![0]['url'],
                          fit: BoxFit.cover,
                          width: 126,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  JumpingDotsProgressIndicator(
                            fontSize: 20.0,
                            color: Colors.blue,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
              const SizedBox(width: 24.06),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.currency.toString() == 'Naira'
                            ? "NG ${widget.formattedPrice}"
                            : "\$ ${widget.formattedPrice}",
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF09172D)),
                      ),
                    ],
                  ),
                  Text(
                    widget.propertyAddress.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF304059)),
                  ),
                  Text(
                    widget.propertyLocation.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8A99B1)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8FEFF),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Color(0xFF8A99B1),
                              size: 9,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.viewCount,
                              style: const TextStyle(
                                  color: Color(0xFF8A99B1),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 9,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.likeCOunt,
                              style: const TextStyle(
                                  color: Color(0xFF8A99B1),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        widget.isPromoted == true
                            ? Image.asset(
                                "assets/images/promote.png",
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        )
      ],
    );
  }
}
