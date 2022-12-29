import 'package:findcribs/components/constants.dart';
import 'package:flutter/material.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image 10.png'),
            const SizedBox(
              height: 54,
            ),
            const Text(
              'Password changed successfully!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'RedHatDisplay',
                color: mobileTextSmallColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 57,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ElevatedButton(
                // Connect EndPoint
                onPressed: () {
                  // Get.off(const Verified Successfully)
                  //Navigate to homepage acct verified Page
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(500, 60), primary: mobileButtonColor),
                child: const Text(
                  //  Connect EndPoint

                  'Go to listing',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'RedHatDisplay',
                    color: mobileButtonTextColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
