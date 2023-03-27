import 'package:url_launcher/url_launcher.dart';

abstract class IUrlClient {
  Future<void> openWebsite();
}

class UrlClient implements IUrlClient {
  static const String link = 'https://dewdrop.app/';

  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not connect to $link.';
    }
  }
}