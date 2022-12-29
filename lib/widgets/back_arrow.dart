import 'package:flutter/material.dart';

import '../components/constants.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 38,
        width: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color: mobileIconColor),
        child: IconButton(
          padding: const EdgeInsets.only(left: 9),
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
