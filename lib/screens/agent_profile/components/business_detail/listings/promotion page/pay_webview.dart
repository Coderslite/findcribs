import 'package:findcribs/components/constants.dart';
import 'package:findcribs/screens/agent_profile/components/business_detail/listings/promotion%20page/verify_promotion.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../../controller/login_controller.dart';

class WebViewExample extends StatefulWidget {
  final String webLink;
  final String referenceId;

  final StatefulWidget returnUrl;
  const WebViewExample(
      {super.key,
      required this.webLink,
      required this.referenceId,
      required this.returnUrl});
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    handleInit();
  }

  handleInit() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://findcribs.ng/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webLink));
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
              getProfileController.handleGetProfile();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return VerifyPromotion(
                    reference: widget.referenceId,
                    returnUrl: widget.returnUrl,
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
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ));
  }
}
