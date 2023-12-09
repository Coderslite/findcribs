import 'package:findcribs/controller/get_profile_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkController extends GetxController {
  var dynamicLink = 'https://www.findcribs.ng';
  var link = 'https://findcribs.page.link/listings';
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String shareLink = '';
  String agentLink = '';

  handleGenerateLink(String propertyId, String imageUrl, String title,
      String description) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://findcribs.page.link',
      link: Uri.parse("$dynamicLink?propertyId=$propertyId"),
      androidParameters: const AndroidParameters(
        packageName: 'com.findcribs.ng',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.findcribs.ng',
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
    Share.share(shareLink).then((value) {});
    update();
  }

  handleGenerateAgentLink(String agentId, String imageUrl, String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://findcribs.page.link',
      link: Uri.parse("$dynamicLink?agentId=$agentId"),
      androidParameters: const AndroidParameters(
        packageName: 'com.findcribs.ng',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.findcribs.ng',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(imageUrl.toString()),
        title: title,
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    agentLink = shortLink.shortUrl.toString();
  }

  handleShareAgentLink() async {
    Share.share(agentLink).then((value) {});
    update();
  }
}
