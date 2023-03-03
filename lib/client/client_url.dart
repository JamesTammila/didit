import 'package:url_launcher/url_launcher.dart';

abstract class IUrlClient {
  Future<void> openWebsite();
}

class UrlClient implements IUrlClient {
  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse('https://dewdrop.app/'))) {
      throw 'Could not connect to https://dewdrop.app/.';
    }
  }
}