import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkController extends GetxController {
  var dynamicLink = 'https://www.findcribs.ng';
  var link = 'https://findcribs.page.link/properties';
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String shareLink = '';

  handleGenerateLink(String propertyId, String imageUrl, String title,
      String description) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://findcribs.page.link',
      // longDynamicLink: Uri.parse(
      //   'https://flutterfiretests.page.link?efr=0&ibi=io.flutter.plugins.firebase.dynamiclinksexample&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Fexample%2Fhelloworld&ofl=https://ofl-example.com',
      // ),
      link: Uri.parse("$dynamicLink?propertyId=$propertyId"),
      androidParameters: const AndroidParameters(
        packageName: 'com.findcribs',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.findcribs',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(imageUrl.toString()),
        title: title,
        description: description,
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    shareLink = shortLink.shortUrl.toString();
  }

  handleShareLink(String propertyId, String imageUrl, String title,
      String description) async {
    Share.share(shareLink).then((value) {
    });
    update();
  }
}
