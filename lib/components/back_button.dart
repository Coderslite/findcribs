import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

backButton() {
  return InkWell(
    onTap: () {
      Navigator.pop(Get.context!);
    },
    child: Container(
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
  );
}
