import 'dart:io';

import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/promotion%20page/verify_promotion.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewExample extends StatefulWidget {
  final String webLink;
  final String referenceId;
  const WebViewExample(
      {Key? key, required this.webLink, required this.referenceId})
      : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: mobileBackgroundColor,
          backgroundColor: mobileBackgroundColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return VerifyPromotion(
                    reference: widget.referenceId,
                  );
                }));
              },
              child: const Text("Done"),
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
              return false;
            } else {
              return true;
            }
          },
          child: SafeArea(
            child: WebView(
              onWebViewCreated: (con) {
                controller = con;
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.webLink,
            ),
          ),
        ));
  }
}
