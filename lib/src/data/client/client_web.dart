import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IWebClient {
  Future<void> shareLink();
  Future<void> openWebsite();
}

class WebClient implements IWebClient {
  @override
  Future<void> shareLink() async {
    await Share.share('https://dewdrop.app/');
  }

  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse('https://dewdrop.app/'))) {
      throw 'Could not connect to https://dewdrop.app/.';
    }
  }
}