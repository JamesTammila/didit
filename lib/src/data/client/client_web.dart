import 'package:url_launcher/url_launcher.dart';

abstract class IWebClient {
  Future<void> openWebsite();
}

class WebClient implements IWebClient {
  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse("https://dewdrop.app/"))) {
      throw "Could not connect to https://dewdrop.app/.";
    }
  }
}