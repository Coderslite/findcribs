
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/widgets/back_arrow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignUpPhoneNumber extends StatefulWidget {
  final String email;
  final String password1;
  final String password2;
  final String firstname;
  final String lastname;
  const SignUpPhoneNumber(
      {Key? key,
      required this.email,
      required this.password1,
      required this.password2,
      required this.firstname,
      required this.lastname})
      : super(key: key);

  @override
  _SignUpPhoneNumberState createState() => _SignUpPhoneNumberState();
}

class _SignUpPhoneNumberState extends State<SignUpPhoneNumber> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Mobile Width & Height
    double mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BackArrow(),
                const Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                        color: mobileTextColor,
                        fontFamily: 'RedHatDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                mobileSizedBoxHeight,
                const Text(
                  'Enter your mobile number',
                  style: TextStyle(color: mobileTextSmallColor, fontSize: 14),
                ),
                // mobileSizedBoxHeight,
                // mobileSizedBoxHeight,

                mobileSizedBoxHeight,
                mobileSizedBoxHeight2,
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 11),
                  ]),
                  decoration: const InputDecoration(
                      // hintText: 'Enter Email Address',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                mobileSizedBoxHeight,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'By tapping Register, I accept',
                      style: TextStyle(
                        color: mobileTextSmallColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('Regulations');
                        }
                      },
                      child: const Text(
                        ' FindCribs Term of Use',
                        style: TextStyle(color: mobileButtonColor),
                      ),
                    ),
                  ],
                ),
                mobileSizedBoxHeight,
                SizedBox(
                  width: mobileWidth * 0.99,
                  child: ElevatedButton(
                      // Connect EndPoint
                      onPressed: () {
                        // Get.off(const Verified Successfully)
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) =>
                        //         const VerifyEmailScreen(),
                        //   ),
                        // );
                  
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 60),
                          primary: mobileButtonColor),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              //  Connect EndPoint

                              'Register',
                              style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  color: mobileButtonTextColor,
                                  fontSize: 20),
                            )),
                ),
                mobileSizedBoxHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn’t get code?',
                      style: TextStyle(
                          color: mobileColorForText,
                          fontSize: 16,
                          fontFamily: 'RedHatDisplayLight'),
                    ),
                    InkWell(
                      onTap: () {
                        // Connect EndPoint
                      },
                      child: const Text(' Resend',
                          style: TextStyle(
                              color: mobileButtonColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
